import axios from "axios";
import fs from "fs-extra";
import path from "path";
import { execSync } from "child_process";
// import { fileURLToPath } from "url";

let log = console.log;

/**
 * clone 或者 pull gitlab 仓库
 * @param {*} setting
 * @param {*} args
 * @returns
 */
export async function runCloneGitLab(setting, args) {
  log = setting.log || log;

  log(setting.welcomeTip(setting));
  const { folder, uid, realRun } = args;

  const repos = await fetchReposByUser(setting.reposByUidApi({ uid }));
  if (!realRun) return printReposOverview(setting, repos);

  const pullSuccessRepos = repos.map((item) => item.name); // 拉取成功的repos
  const pullFailedRepos = []; // 拉取失败的repos

  cdReposFolder(setting)
  for (const key in repos) {
    if (!Object.prototype.hasOwnProperty.call(repos, key)) return;
    const { name: repoName, git: repoUrl } = repos[key];

    try {
      const repoFolder = path.join(folder, repoName);
      log(`[仓库名称]: ${repoName}, 即将 clone 到本地路径是：${repoFolder}`);
      // 当前路径下无该仓库
      if (!fs.existsSync(repoFolder)) {
        runCloneOrPull(`git clone ${repoUrl}`, repoName);
        continue;
      }

      // https://github.com/google/zx#nothrow
      // 当前路径下有该仓库-拉取master最新代码
      const command = `cd ${repoFolder} && git checkout master && git pull`;
      runCloneOrPull(command, repoName);
    } catch (error) {
      // 打印失败信息
      log(error);
      logError(repoName);
    }
  }

  // 打印成功的仓库名
  pullSuccessRepos.length > 0 && log(`clone 成功仓库: ${pullSuccessRepos}`);
  // 打印失败的仓库名
  pullFailedRepos.length > 0 &&
    log(`clone 失败仓库: ${pullFailedRepos}, 请联系 TL 或 导师 开通相关权限`);
}

function runCloneOrPull(command, repoName) {
  execSync(command, () => logError(repoName));
}

function logError(repoName) {
  pullFailedRepos.push(repoName);
  pullSuccessRepos.splice(pullSuccessRepos.indexOf(repoName), 1);
}

// 获取对应员工id名下的仓库地址
async function fetchReposByUser(apiUrl) {
  log(`从 ${apiUrl} 获取Repos`);
  if (!apiUrl) {
    warn("获取员工名下仓库信息接口地址不存在");
    return [];
  }

  const res = await axios(apiUrl);
  const repos = res.data?.data?.list ?? [];
  return repos;
}

/**
 * 解析 Git 仓库所属 Group
 * git@demo.com::h5/learn-node.git => h5
 * git@demo.com::h5/freshman/learn-node.git => h5/freshman
 *
 * @param {*} repos
 * @returns
 */
function getGroupsByRepos(setting, repos) {
  const reg = new RegExp(`^git@${setting.gitLabHost}:(.*)\/[^/]*$`);

  const groups = repos.map((item) => item.git.replace(reg, "$1"));
  const uniqueGroups = [...new Set(groups)];
  return uniqueGroups;
}

/**
 * 打印概览信息
 * @param {*} repos
 */
function printReposOverview(setting, repos) {
  const groups = getGroupsByRepos(setting, repos);

  log(`
    即将 clone 仓库的基本信息如下: 
    ${printGroupUrls(setting, groups)}

    共 ${repos.length}  个Repo

    - 请先确保 有对应Group或者Repo的权限, 否则会导致代码 clone 失败, 请联系TL/导师 开通相关权限
    - 如果您确认有相关权限, 请在原命令添加 -r 来真正执行: node gitlab --uid xxx -r
    
  `);
}

/**
 * 打印 GitLab Group 清单
 *
 * @param groups
 * @returns
 */
function printGroupUrls(setting, groups) {
  const groupsInfo = groups
    .map((group, index) => {
      const groupUrl = `https://${setting.gitLabHost}/${group}`;
      const addGroupMemberUrl = `${groupUrl}/-/group_members`;
      return `[${index}] ${group}, 访问 ${addGroupMemberUrl} 开通权限`;
    })
    .join("\r\n      ");

  return `
      共 ${groups.length} 个Group, 如果没有权限，请联系 TL或导师访问如下地址, 开通权限:

      ${groupsInfo}
    `;
}


function cdReposFolder(setting) {
  if (!setting.folder) return
  // const __filename = fileURLToPath(import.meta.url);
  // const __dirname = path.dirname(__filename);
  // console.log('__dirname', __dirname)
  // console.log('process.cwd()', process.cwd())
  const reposFolder = path.join(process.cwd(), setting.folder);
  if (!fs.existsSync(reposFolder)) {
    fs.mkdirSync(reposFolder)
    process.chdir(reposFolder)
  }
}
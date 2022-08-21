import axios from "axios";
import fs from "fs-extra";
import path from "path";
import { execSync } from "child_process";

let log = console.log

/**
 * clone 或者 pull gitlab 仓库
 * @param {*} setting 
 * @param {*} args 
 * @returns 
 */
export async function runCloneGitLab(setting, args) {
  const { folder, uid, realRun } = args
  log = setting.log || log

  const repos = await fetchReposByUser(setting.reposByUidApi(uid));
  if (!realRun) return printReposOverview(repos)

  const pullSuccessRepos = repos.map((item) => item.name); // 拉取成功的repos
  const pullFailedRepos = []; // 拉取失败的repos

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
  pullSuccessRepos.length > 0 &&
    log(`clone 成功仓库: ${pullSuccessRepos}`);
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
function getGroupsByRepos(repos) {
  const reg = new RegExp(`^git@${setting.gitLabHost}:(.*)\/[^/]*$`);

  const groups = repos.map((item) => item.git.replace(reg, "$1"));
  const uniqueGroups = [...new Set(groups)];
  return uniqueGroups;
}


/**
 * 打印概览信息
 * @param {*} repos 
 */
function printReposOverview(repos) {
  const groups = getGroupsByRepos(repos);

  log(`
    即将 clone 仓库的基本信息如下: 
    共 ${groups.length} 个Group,
    ${printGroupUrls(groups)}

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
function printGroupUrls(groups) {
  return groups
    .map((group) => `https://${settings.gitLabHost}/${group}`)
    .join("\r\n      ");
}


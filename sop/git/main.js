import { runCloneGitLab } from "./executor";

const Setting = {
  gitLabHost: "gitlab.your-company.com",
  // 根据工号获取 其负责的Gitlab 项目信息
  reposByUidApi: ({ uid }) => `https://api.your-company.com/get-gitlab-projects-by-uid?uid=${uid}`,
  // 可能有其它打印框架, 默认采用 console.log
  log: console.log,
};

const flags = {
  folder: "./repos",
  uid: "123456",
  realRun: false, // dry run vs real run
}; 


function run(setting, flags) {
  if (!validate(setting, flags)) return;
  runCloneGitLab(setting, flags);
}


function validate(setting, flags) {
  if (!flags.uid) {
    Setting.log(`
    欢迎加入大前端团队
  
    新人指引提供如下命令行
      - 拉取员工负责的Repos: node gitlab --uid xxx
        - uid: 工号
  `);
    return false
  }
}

run(Setting, flags)

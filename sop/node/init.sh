#!/usr/bin/env bash

echo '欢迎来到大前端团队，本命令将会完成Node环境的初始化'


# shell vs javascript 注意事项
# 1. if 需要使用 fi 来结束
# 2. 取反需要有空格：! is_valid 而不是 !is_valid

# declare an array
# 单个安装函数执行完成后，向该数组 push 安装成功/失败消息，在脚本最后进行打印
tips=() 

# 判断命令是否存在
command_exists() {
  # echo "$(type $1)"
  if type $1 > /dev/null
  then
    echo "[$1] is installed, skipping..."
  else
    echo "[$1] is not installed, installing..."
  fi
  type "$1" > /dev/null 2>&1
  # command -v "$@" >/dev/null 2>&1
}

# https://stackoverflow.com/questions/16721940/why-when-use-sys-platform-on-mac-os-it-print-darwin
# https://zhuanlan.zhihu.com/p/436752408
is_mac() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*)   machine=Linux;;
    Darwin*)  machine=Mac;;
    CYGWIN*)  machine=Cygwin;;
    MINGW*)   machine=MinGw;;
    *)      machine="UNKNOWN:${unameOut}"
  esac
  [[ "$machine" == "Mac" ]]
  # echo ${machine} 
}

install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# https://brew.sh/index_zh-cn
install_homebrew() {
  if ! is_mac; then
    echo '[homebrew] 非Mac环境，不安装 homebrew'
    return
  fi
  echo '[homebrew] 开始安装'

  # 采用清华大学镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
  /bin/bash brew-install/install.sh
  rm -rf brew-install

  echo '[homebrew] 安装完成'
  tips+="✅ brew 安装完成： brew -v $(brew -v)"
}

# https://github.com/nvm-sh/nvm
install_node_by_nvm() {
  echo '[nvm] 开始安装'
  # https://github.com/nvm-sh/nvm#installing-and-updating
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  curl -o- https://gitcode.net/mirrors/nvm-sh/nvm/-/raw/master/install.sh | bash
  source ~/.zshrc

  echo '[nvm] 安装完成'

  echo '[node] 开始安装'
  nvm install 10
  nvm install 12
  nvm install 14
  nvm install 16
  nvm alias default 14
  echo '✅ [node] 安装完成，默认版本为：14'
  tips+="✅ [node] 安装完成：node -v $(node -v)"
}

# 安装全局必要模块，比如 yarn、nrm
# 采用淘宝镜像源加速
# https://www.npmjs.com/package/nrm
install_global_npm_modules() {
  echo '[全局模块] nrm yarn 开始安装'
  npm set registry https://registry.npmmirror.com
  npm install -g yarn nrm
  nrm ls
  echo '✅ [全局模块] nrm yarn 安装/配置完成'
  tips+="✅ [全局模块] yarn 安装完成：yarn -v $(yarn -v)"
  tips+="✅ [全局模块] nrm  安装完成：nrm --version $(nrm --version)"
}

# 在脚本最后打印汇总信息，提示用户本次脚本执行后，一共做了哪些事情：成功安装了哪些软件
print_tips_after_install_finish() {
  for value in "${tips[@]}"
  do
    echo $value
  done
}



# TODO
# detect curl/wget installed

# 判断 ~/.zshrc 是否存在，因为 nvm 需要在安装后将配置文件写入 ~/.zshrc、~/.bashrc、~/.bash_profile 等文件中
# 我们推荐全部采用 zsh + oh-my-zsh：https://ohmyz.sh/

if [ -f ~/.zshrc ]; then
  (! command_exists "brew") && install_homebrew
  (! command_exists "node") && install_node_by_nvm
  (! command_exists "nrm") && install_global_npm_modules
  print_tips_after_install_finish
else
  # install_oh_my_zsh
  echo '~/.zshrc not exist, please use zsh and oh-my-zsh: https://ohmyz.sh/'
fi

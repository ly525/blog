#!/usr/bin/env bash



tips=()

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



is_mac() {
   unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    [[ "$machine" == "Mac" ]]
    # echo ${machine} 
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_homebrew() {
    if ! is_mac; then
        echo '[homebrew] 非Mac环境，不安装 homebrew'
        return
    fi
    echo '[homebrew] 开始安装'

    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
    /bin/bash brew-install/install.sh
    rm -rf brew-install

    echo '[homebrew] 安装完成'
    tips+="✅ brew 安装完成： brew -v $(brew -v)"
}


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


install_global_npm_modules() {
    echo '[全局模块] nrm yarn 开始安装'
    npm set registry https://registry.npmmirror.com
    npm install -g yarn nrm
    nrm add ymm http://npm.amh-group.com
    nrm use ymm
    nrm ls
    echo '✅ [全局模块] nrm yarn 安装/配置完成'
    tips+="✅ [全局模块] yarn 安装完成：yarn -v $(yarn -v)"
    tips+="✅ [全局模块] nrm  安装完成：nrm --version $(nrm --version)"
}

print_tips_after_install_finish() {
    for value in "${tips[@]}"
    do
        echo $value
    done
}
echo '欢迎来到大前端团队，本命令将会完成Node环境的初始化'

# TODO
# detect curl/wget installed
if [ -f ~/.zshrc ]; then
    install_homebrew
    (! command_exists "node") && install_node_by_nvm
    (! command_exists "nrm") && install_global_npm_modules
    print_tips_after_install_finish
else
    # install_oh_my_zsh
    echo '~/.zshrc not exist, please use zsh and oh-my-zsh'
fi



# echo "✅ node 安装完成：node -v $(node -v)"
# echo "✅ yarn 安装完成：yarn -v $(yarn -v)"
# echo "✅ nrm 安装完成： nrm --version $(nrm --version)"
# echo "✅ brew 安装完成： brew -v $(brew -v)"

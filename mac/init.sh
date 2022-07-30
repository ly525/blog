echo '欢迎来到大前端团队，本命令将会完成Node环境的初始化'

# TODO
# detect curl/wget installed

echo 'Homebrew 开始安装'

export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash brew-install/install.sh
rm -rf brew-install

echo 'Homebrew 安装完成'


echo 'NVM 开始安装'
# https://github.com/nvm-sh/nvm#installing-and-updating
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl -o- https://gitcode.net/mirrors/nvm-sh/nvm/-/raw/master/install.sh | bash
source ~/.zshrc

echo 'NVM 安装完成'

echo 'NODE 开始安装'
nvm install 10
nvm install 12
nvm install 14
nvm install 16
nvm alias default 14
echo '✅ NODE 安装完成，默认版本为：14'

echo 'nrm yarn 开始安装'
npm set registry https://registry.npmmirror.com
npm install -g yarn nrm
nrm add ymm http://npm.amh-group.com
nrm use ymm
nrm ls
echo '✅ nrm yarn 安装/配置完成'


echo "✅ node 安装完成：node -v $(node -v)"
echo "✅ yarn 安装完成：yarn -v $(yarn -v)"
echo "✅ nrm 安装完成： nrm --version $(nrm --version)"
# echo "✅ brew 安装完成： brew -v $(brew -v)"




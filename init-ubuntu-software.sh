sudo apt-get install git wget curl vim zsh mpg123 sshpass supervisor sqlite3 ssh terminator build-essential 
libgtop2-dev libgtk-3-dev -y libappindicator3-dev git-core python-pip indicator-netspeed -y
# install nvm to install node
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
# install oh-my-zsh for better experience
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #input your password

nvm ls-remote
nvm install v7.7.2

# openjdk
sudo apt install openjdk-9-jdk -y
# nautilus
wget https://www.jianguoyun.com/static/exe/installer/ubuntu/nautilus_nutstore_amd64.deb
sudo dpkg -i nautilus_nutstore_amd64.deb
# sougoupinyi
# googlechrome
# sublime
# vscode
# wechat
# virtualenv django etc

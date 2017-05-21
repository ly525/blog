# notice do not run this file use sudo. yes! not sudo; just run './init-ubuntu-software.sh'
# update system
sudo apt update 

# install dev tools
sudo apt install git git-core wget curl vim supervisor sqlite3 python-pip -y

# install system enhance tools
sudo apt install sshpass mpg123 ssh terminator build-essential indicator-netspeed -y

# intall base lib
sudo apt install libgtop2-dev libgtk-3-dev -y libappindicator3-dev -y


# install oh-my-zsh for better experience
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #input your password

# install nvm to install node
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
echo 'export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
. /usr/share/autojump/autojump.zsh
alias open="gvfs-open"'  >> ~/.zshrc
source ~/.zshrc

nvm ls-remote
nvm install v7.7.2

# openjdk
# sudo apt install openjdk-9-jdk -y
# nautilus
wget https://www.jianguoyun.com/static/exe/installer/ubuntu/nautilus_nutstore_amd64.deb
sudo dpkg -i nautilus_nutstore_amd64.deb
# sougoupinyi
# googlechrome
# sublime
# vscode
# wechat
# virtualenv django etc

# terminator config file
mkdir -p ~/.config/terminator
echo '[global_config]
  handle_size = -3
  enabled_plugins = CustomCommandsMenu, LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
  title_transmit_fg_color = "#000000"
  suppress_multiple_term_dialog = True
  title_transmit_bg_color = "#3e3838"
  inactive_color_offset = 1.0
[keybindings]
[profiles]
  [[default]]
    use_system_font = False
    login_shell = True
    background_darkness = 0.92
    background_type = transparent
    background_image = None
    cursor_color = "#3036ec"
    foreground_color = "#00ff00"
    show_titlebar = False
    custom_command = tmux
    font = Liberation Mono 12
[layouts]
  [[default]]
    [[[child0]]]
      position = 446:100
      type = Window
      order = 0
      parent = ""
      size = 1440, 1050
    [[[child1]]]
      position = 444
      type = HPaned
      order = 0
      parent = child0
    [[[child2]]]
      position = 275
      type = VPaned
      order = 0
      parent = child1
    [[[child5]]]
      position = 219
      type = HPaned
      order = 1
      parent = child1
    [[[child6]]]
      position = 275
      type = VPaned
      command = 'j internal;'
      order = 0
      parent = child5
    [[[child9]]]
      position = 275
      type = VPaned
      order = 1
      parent = child2
    [[[terminal10]]]
      profile = default
      command = 'j internal; pwd'
      type = Terminal
      order = 0
      parent = child2
[plugins]' > ~/.config/terminator/config

sudo ln -s ~/workspace/tools/connect/to /usr/local/bin/to


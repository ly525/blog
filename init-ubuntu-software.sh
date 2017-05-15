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
    palette = "#000000:#5a8e1c:#2d5f5f:#cdcd00:#1e90ff:#cd00cd:#00cdcd:#e5e5e5:#4c4c4c:#868e09:#00ff00:#ffff00:#4682b4:#ff00ff:#00ffff:#ffffff"
    background_image = ""
    background_darkness = 0.8
    scrollback_lines = 3000
    background_type = transparent
    use_system_font = False
    scroll_background = False
    show_titlebar = False
    cursor_shape = ibeam
    font = Liberation Mono 12
    background_color = "#291829"
    foreground_color = "#e8e8e8"
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
      profile = default
    [[[window0]]]
      type = Window
      parent = ""
      size = 925, 570
[plugins]' > ~/.config/terminator/config

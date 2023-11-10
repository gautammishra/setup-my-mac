#!/bin/bash

print_green() {
    GREEN='\033[1;32m'
    NC='\033[0m'
    printf "${GREEN}$1${NC}\n"
}

sudo -v

print_green "Installing Command Line Tools"
xcode-select --install

# Install Homebrew
if test ! $(which brew); then
    print_green "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dev tools
print_green "Installing Developer Tools"
brew tap spring-io/tap
apps=(
    iterm2
    pyenv
    pyenv-virtualenv
    poetry
    tfenv
    awscli
    wget
    jq
    xq
    git
    tree
    spring-boot
    openjdk
    maven
)
brew install ${apps[@]}

print_green "Installing Developer Apps"
casks=(
    1password
    1password-cli
    google-chrome
    visual-studio-code
    github
    maccy
    docker
    rectangle
    postman
    intellij-idea-ce
    pycharm-ce
    vnc-viewer
)
brew install --cask ${casks[@]}

# Install Oh-My-Zsh
if [ -d "~/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Oh-My-Zsh Plugins
if  [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if  [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    git clone  --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install PowerLevel10k
if [[ ! -f "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && [[ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    brew install powerlevel10k
fi

if test -f ~/.p10k.zsh; then
    print_green "Replacing ~/.p10k.zsh. Old config stored at \$TMPDIR/.p10k.zsh.backup"
    mv ~/.p10k.zsh $TMPDIR/.p10k.zsh.backup
fi
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/gautammishra/setup-my-mac/main/.p10k.zsh

if test -f ~/.zshrc; then
    print_green "Replacing ~/.zshrc. Old config stored at \$TMPDIR/.zshrc.backup"
    mv ~/.zshrc $TMPDIR/.zshrc.backup
fi
curl -o ~/.zshrc https://raw.githubusercontent.com/gautammishra/setup-my-mac/main/.zshrc

# brew tap homebrew/cask-fonts
# brew install font-hack-nerd-font

# Install Python
PYTHON_VERSION="3.12.0"
print_green "Installing python $PYTHON_VERSION and setting as default"
pyenv install -s $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Install applications
print_green "Installing Other Apps"
casks=(
    nordvpn
    logi-options-plus
    microsoft-office
    whatsapp
    notion
    spotify
)
brew install --cask ${casks[@]}

# Install VS Code Extensions
print_green "Installing VSCode Extensions"
code --install-extension hashicorp.terraform
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-spring-initializr
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-python.python

# Remove Chrome Apps
rm -rf ~/Applications/Chrome\ Apps.localized/*

# Setting defaults
print_green "Setting Defaults"
defaults write com.apple.finder ShowStatusBar -bool true            # Finder: Show status bar
defaults write com.apple.finder ShowPathbar -bool true              # Finder: Show path bar
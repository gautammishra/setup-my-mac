#!/bin/bash

print_green() {
    GREEN='\033[1;32m'
    NC='\033[0m'
    printf "${GREEN}$1${NC}\n"
}

print_green "Installing Command Line Tools"
xcode-select --install

# Install Homebrew
if test ! $(which brew); then
    print_green "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dev tools
print_green "Installing Developer Tools"
apps=(
    iterm2
    pyenv
    poetry
    tfenv
    awscli
    wget
    jq
    git
    tree
)
brew install ${apps[@]}

print_green "Installing Developer Apps"
casks=(
    1password
    google-chrome
    visual-studio-code
    github
    maccy
    docker
    rectangle
    postman
    intellij-idea-ce
    pycharm-ce
)
brew install --cask ${casks[@]}

# Install Oh-My-Zsh
if [ -d "~/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install PowerLevel10k
if [ ! -f "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ] && [ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k"]; then
    brew install powerlevel10k
    echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
fi

if test -f ~/.p10k.zsh; then
    print_green "Replacing ~/.p10k.zsh. Old config stored at \$TMPDIR/.p10k.zsh.backup"
    mv ~/.p10k.zsh $TMPDIR/.p10k.zsh.backup
fi
cp .p10k.zsh ~/

# brew tap homebrew/cask-fonts
# brew install font-hack-nerd-font

# Install applications
print_green "Installing Other Apps"
casks=(
    nordvpn
    logi-options-plus
    microsoft-office
)
brew install --cask ${casks[@]}

# Install VS Code Extensions
print_green "Installing VSCode Extensions"
code --install-extension hashicorp.terraform
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-spring-initializr
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python

# Remove Chrome Apps
rm -rf ~/Applications/Chrome\ Apps.localized/*
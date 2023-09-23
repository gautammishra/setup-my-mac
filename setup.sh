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
    poetry
    tfenv
    awscli
    wget
    jq
    git
    tree
    spring-boot
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

# Install PowerLevel10k
if [[ ! -f "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && [[ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    brew install powerlevel10k
    echo '\n# Powerlevel10k configuration' >> ~/.zshrc
    echo 'source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo '\n# To customize prompt, run \`p10k configure\` or edit ~/.p10k.zsh.' >> ~/.zshrc
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
fi

if test -f ~/.p10k.zsh; then
    print_green "Replacing ~/.p10k.zsh. Old config stored at \$TMPDIR/.p10k.zsh.backup"
    mv ~/.p10k.zsh $TMPDIR/.p10k.zsh.backup
fi
cp .p10k.zsh ~/

# brew tap homebrew/cask-fonts
# brew install font-hack-nerd-font

# Configure PyEnv and install Python
if ! grep -wq "pyenv init -" ~/.zshrc; then
    echo '\n# PyEnv Configuration' >> ~/.zshrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
fi
PYTHON_VERSION="3.11.5"
print_green "Installing python $PYTHON_VERSION and setting as default"
pyenv install -s $PYTHON_VERSION
pyenv global $PYTHON_VERSION

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

# Setting defaults
print_green "Setting Defaults"
defaults write com.apple.finder ShowStatusBar -bool true            # Finder: Show status bar
defaults write com.apple.finder ShowPathbar -bool true              # Finder: Show path bar
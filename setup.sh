#!/bin/bash

paci() {
    sudo pacman -S $1 --noconfirm --needed
}

pacman_packages() {
    packages=(
        "git"
        "curl"
        "wget"
        "zsh"
        "python-pip"
        "yay"
        "tilix"
        "xclip"
        "ruby"
        
        #Neovim dependencies ========
        "neovim"
        "ranger"
        "ueberzug"
        "ripgrep"
        "silver_searcher"
        "fd"
        "universal-ctags"
    )
    for pkg in ${packages[@]}; do
        echo "Installing ${pkg}"
        paci $pkg
    done
}

aur_packages() {
    packages=(
        "visual-studio-code-bin"
        
        #Neovim dependencies ========
        "lazygit"
        "lazydocker"
        "slack-desktop"
        "zulip-desktop-bin"
        "gitkraken"
        "jetbrains-toolbox"
    )
    for pkg in ${packages[@]}; do
        echo "Installing ${pkg}"
        yay -S $pkg --noconfirm
    done
}

install_gems(){
    packages=(
        "colorls"
    )
    for pkg in ${packages[@]}; do
        echo -e "\nInstalling ${pkg}"
        gem install $pkg
    done
}

install_prerequisites() {
    echo -e "\n============== Installing pre-requisite packages ==============\n"
    pacman_packages
    aur_packages
    install_gems
    echo -e "\nDone.\n"
}

setup_neovim(){
    echo -e "\n============== Setting up neovim ==============\n"
    bash <(curl -s https://raw.githubusercontent.com/Kshitij09/nvim/master/utils/install.sh)
    echo -e "\nDone.\n"
}

install_ohmyzsh() {
    echo -e "\n============== Installing oh-my-zsh ==============\n"
    # Install zsh
    which zsh > /dev/null && echo "zsh installed, moving on.." || paci zsh
    # Set zsh as default shell
    [ "$SHELL##*zsh*" ] && echo "zsh is already your default shell, moving on.." || chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_post_omz() {
    echo -e "\n============== Installing powerlevel10k ==============\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
    
    echo -e "\n============== Installing ohmyzsh custom plugins ==============\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

install_meslo_fonts() {
    echo -e "\n============== Downloading and Installing MesloLGS NF Fonts ==============\n"
    meslo_fonts=(
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
    )
    # In case partially downloaded
    rm -rf /tmp/MesloLGS*
    for font in ${meslo_fonts[@]}; do
        wget -q "$font" -P /tmp
    done
    mkdir -p ~/.local/share/fonts
    cp /tmp/MesloLGS* ~/.local/share/fonts
    fc-cache -f
    fc-list | grep MesloLGS
    echo -e "\nDone.\n"
}

setup_conda(){
    echo -e "\n============== Setting up miniconda ==============\n"
    miniconda_url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    filepath="$HOME/Downloads/Miniconda3-latest-Linux-x86_64.sh"
    minsize=85000
    if [ -s $filepath ]; then
        filesize=$(du -k $filepath | cut -f 1)
        if [ $filesize -le $minsize ]; then
            rm $filepath
            echo -e "Downloading setup files\n"
            wget $miniconda_url -P ~/Downloads
        fi
    else
        echo -e "Downloading setup files\n"
        wget $miniconda_url -P ~/Downloads
    fi
    echo -e "Initiating installation..\n"
    sh $filepath -b
    # Run after restarting your terminal
    # conda config --set auto_activate_base false
    echo -e "\nDone\n"
}

setup_git(){
    echo -e "\n============== Setting up global git =============="
    echo -e "\nNote: (These details will be used to signoff your commits)\n"
    read -p "\nName: " name
    read -p "\nEmail: " email
    git config --global user.name "$name"
    git config --global user.email "$email"
}

ask() {
    read -ep "$1" answer
    [ "$answer" == "${answer#[Yy]}" ]
}


#install_prerequisites
#install_ohmyzsh
install_post_omz
#ask "Do you want to install MesloLGS Nf fonts (y/n)? " || install_meslo_fonts
#setup_neovim
#setup_conda
#setup_git

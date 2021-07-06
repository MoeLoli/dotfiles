#!/bin/zsh

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "No macOS detected!"
  exit 1
fi

start() {
    clear

    echo -n "[38;5;220m▓▒░[0m The setup will begin in [38;5;82m5[0m seconds..."
    echo ""

    sleep 5

    echo -n "[34m▓▒░[0m Times up! Here we start!"
    echo ""

    cd $HOME
}

# xcode command tool will be installed during homebrew installation
install_homebrew() {
    echo "[1;34m▓▒░[0m Installing [1;36mHomebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

install_packages() {
    __pkg_to_be_installed=(
        cmake
        wget
        git
        neofetch
        thefuck
        unrar
        telnet
        jq
        coreutils
    )

    __casks_to_be_installed=(
        # iina
        # maczip
        # typora
        # google-chrome
        # firefox
        # motrix
        # visual-studio-code
        # neteasemusic
        # switchhosts
    )

    __taps_to_be_installed=(

    )

    echo "[1;34m▓▒░[0m Install [1;36mPackages"

    brew update

    for __pkg ($__pkg_to_be_installed); do
        echo "[34m▓▒░[0m Installing [1;34m${__pkg}"
        brew install ${__pkg}
    done

    for __cask ($__casks_to_be_installed); do
        echo "[34m▓▒░[0m Installing [1;34m${__cask}"
        brew install ${__cask} --cask
    done

    for __tap ($__taps_to_be_installed); do
        echo "[34m▓▒░[0m Installing [1;34m${__tap}"
        brew install ${__tap}
    done
}

clone-repo() {
    echo "[1;34m▓▒░[0m Cloning [1;36mSoraJin424/dotfiles[0m from [1;33mGithub.com [0mat [1;35m${HOME}[0m"
    
    git clone https://github.com/SoraJin424/dotfiles.git ${HOME}/dotfiles

    cd ./dotfiles
    rm -rf .git
}

install-nodejs() {
    echo "[1;34m▓▒░[0m Setting up [1;36mNodeJS[0m Environment[0m"


    install-node() {
        echo "[34m▓▒░[0m Install[1;34m NodeJS [0m"
        
        brew install nodejs
        
        echo "[1;34m▓▒░[0m Node.js succesfully installed, version is [1;32m$(node -v)[0m"
    }

    install-yarn() {
        echo "[34m▓▒░[0m Install[1;34m Yarn[0m"
        
        npm install -g yarn
        
        echo "[1;34m▓▒░[0m Yarn succesfully installed, version is [1;32m$(yarn --version)[0m"
    }

    install-node
    install-yarn
}

install-goenv() {
    echo "[1;34m▓▒░[0m Install [1;36msyndbg/goenv[0m from [1;33mGithub.com [0mat [1;35m$HOME/.goenv[0m"
    
    git clone https://github.com/syndbg/goenv.git $HOME/.goenv
}

zshrc() {
    echo "[1;34m▓▒░[0m Set [1;36mzsh[0m"

    cat $HOME/dotfiles/zshrc/macOS.zshrc > $HOME/.zshrc
    cat $HOME/dotfiles/p10k/macOS.zsh > $HOME/.p10k.zsh
}

finish() {
    echo "[1;34m▓▒░[0m Clean up[0m"
    cd $HOME
    rm -rf $HOME/dotfiles

    echo "[1;34m▓▒░[0m Done! [0m"
    echo "[1;34m▓▒░[0m Enviroment Setup finished! [0m"
    echo "[1;34m▓▒░[0m Do not forget run those things: [0m"
    echo "[38;5;219m▓▒░[0m chsh -s /usr/bin/zsh [0m"

    cd $HOME
}

start
install_homebrew
install_packages
clone-repo
install-nodejs
zshrc
finish

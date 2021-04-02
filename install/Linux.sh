#!/bin/bash
###
 # @Author: Jin
 # @Date: 2021-03-31 14:43:58
 # @LastEditors: Jin
 # @LastEditTime: 2021-04-02 11:17:03
 # @FilePath: /dotfiles/install/Linux.sh
### 

start() {
    clear

    echo -n "[38;5;220m▓▒░[0m The setup will begin in [38;5;82m5[0m seconds..."
    echo ""

    sleep 5

    echo -n "[34m▓▒░[0m Times up! Here we start!"
    echo ""

    cd $HOME
}

install-packages() {
    __pkg_to_be_installed=(
        zsh
        curl
        git
        tree
    )
    echo "[1;34m▓▒░[0m Installing [1;36mPackages"

    echo "[34m▓▒░[0m Updating package index"
    sudo apt-get update

    for __pkg in "${__pkg_to_be_installed[@]}"; do
        echo "[34m▓▒░[0m Install[1;34m ${__pkg}"
        sudo apt-get install -y ${__pkg} 
    done
}

clone-repo() {
    echo "[1;34m▓▒░[0m Cloning [1;36mSoraJin424/dotfiles[0m from [1;33mGithub.com [0mat [1;35m${HOME}[0m"
    
    git clone https://github.com/SoraJin424/dotfiles.git

    cd ./dotfiles
    rm -rf .git
}

install-nodejs() {
    echo "[1;34m▓▒░[0m Setting up [1;36mNodeJS[0m Environment[0m"


    install-nvm() {
        echo "[34m▓▒░[0m Install[1;34m ${__pkg}[0m"

        curl -o- https://cdn.jsdelivr.net/gh/creationix/nvm/install.sh | bash

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        
        echo "[1;34m▓▒░[0m NVM succesfully installed, version is [1;32m$(nvm --version)[0m"
    }

    install-node() {
        echo "[34m▓▒░[0m Install[1;34m NodeJS LTS[0m"
        
        nvm install --lts
        nvm use --lts
        nvm alias default node
        
        echo "[1;34m▓▒░[0m Node.js succesfully installed, version is [1;32m$(node -v)[0m"
    }

    install-yarn() {
        echo "[34m▓▒░[0m Install[1;34m Yarn[0m"
        
        npm install -g yarn
        
        echo "[1;34m▓▒░[0m Yarn succesfully installed, version is [1;32m$(yarn --version)[0m"
    }
}

install-goenv() {
    echo "[1;34m▓▒░[0m Install [1;36msyndbg/goenv[0m from [1;33mGithub.com [0mat [1;35m$HOME/.goenv[0m"
    
    git clone https://github.com/syndbg/goenv.git $HOME/.goenv
}

zshrc() {
    echo "[1;34m▓▒░[0m Set [1;36mzsh[0m"

    cat $HOME/dotfiles/zshrc/Linux.zshrc > $HOME/.zshrc
    cat $HOME/dotfiles/p10k/Linux.zsh > $HOME/.p10k.zsh
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
install-packages
clone-repo
install-nodejs
zshrc
finish

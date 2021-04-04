###
 # @Author: Jin
 # @Date: 2021-03-30 16:21:48
 # @LastEditors: Jin
 # @LastEditTime: 2021-04-04 23:49:34
 # @FilePath: /dotfiles/zshrc/macOS.zshrc
### 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    git clone https://github.com/zdharma/zinit.git "$HOME/.zinit/bin"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
zinit light zinit-zsh/z-a-rust
zinit light zinit-zsh/z-a-as-monitor
zinit light zinit-zsh/z-a-patch-dl
zinit light zinit-zsh/z-a-bin-gem-node

# Load a few plugins, without Turbo
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit load zdharma/history-search-multi-word
zinit ice depth=1; zinit light romkatv/powerlevel10k

export LESSCHARSET="utf-8"
export NVM_SYMLINK_CURRENT="true"
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD="true"
zinit light lukechilds/zsh-nvm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# You may need to manually set your language environment
export LANG="en_US.UTF-8"

# Preferred editor for local and remote sessions
if (( $#SSH_CONNECTION )); then
    export EDITOR='vim'
else
    export EDITOR='nano'
fi

export PATH="/usr/local/sbin:$PATH"
export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/Go"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE="on"

alias vi="vim"
alias cls="clear"
alias rmrf="rm -rf"
alias gitcm="git commit -m"
alias gitp="git push"
alias gita="git add -a"
alias gitall="git add ."
alias rezsh="source $HOME/.zshrc"

alias ls="gls -F --color"
alias l="gls -lAh --color"
alias ll="gls -l --color"
alias la="gls -A --color"

clear_dns_cache() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    sudo killall mDNSResponderHelper
}

git-config() {
    echo -n "
===================================
      * Git Configuration *
-----------------------------------
Please input Git Username: "

    read username

    echo -n "
-----------------------------------
Please input Git Email: "

    read email

    echo -n "
-----------------------------------
Done!
===================================
"

    git config --global user.name "${username}"
    git config --global user.email "${email}"
}

killport() {
  echo "Killing process on port: $1"
  fuser -n tcp -k $1;
}

extract() {
    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
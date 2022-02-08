################################################################################
#                                                                              #
# Install Dependencies (Arch):                                                 #
#                                                                              #
# $ pacman -S zsh                                                              #
# $ yay -S antigen-git                                                         #
#                                                                              #
################################################################################


# Antigen
source /usr/share/zsh/share/antigen.zsh
antigen init ~/.antigenrc


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Menu-selection customization
zstyle ':completion:*' menu select
zmodload zsh/complist

# Use the Vi navigation keys in menu completion.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


#
# Fix Zsh ZLE's "backward-delete-char" widget to restore previously-overwritten
# characters when hitting backspace (\b) in Vi replace-mode.
#
# See here: https://stackoverflow.com/questions/57604539/make-zsh-zle-restore-characters-on-backspace-in-vi-overwrite-mode
#

readonly ZLE_VI_MODE_CMD=0
readonly ZLE_VI_MODE_INS=1
readonly ZLE_VI_MODE_REP=2
readonly ZLE_VI_MODE_OTH=3

function zle-vi-mode {
    if [[ $KEYMAP == vicmd ]]; then
        printf $ZLE_VI_MODE_CMD
    elif [[ $KEYMAP == (viins|main) ]] && [[ $ZLE_STATE == *insert* ]]; then
        printf $ZLE_VI_MODE_INS
    elif [[ $KEYMAP == (viins|main) ]] && [[ $ZLE_STATE == *overwrite* ]]; then
        printf $ZLE_VI_MODE_REP
    else
        printf $ZLE_VI_MODE_OTH
    fi
}

function zle-backward-delete-char-fix {
    case "$(zle-vi-mode)" in
        $ZLE_VI_MODE_REP)
            if [[ $CURSOR -le $MARK ]]; then
                CURSOR=$(( $(($CURSOR-1)) > 0 ? $(($CURSOR-1)) : 0 ))
                MARK=$CURSOR
            else
                zle undo
            fi
            ;;
        *)
            zle backward-delete-char
            ;;
    esac
}

zle -N zle-backward-delete-char-fix

# Change the cursor shape according to the current Vi-mode.
function zle-line-init zle-keymap-select {
    # Prevent `tmux` from interpretting the below escape sequences.
    # See here: https://unix.stackexchange.com/questions/409068/tmux-and-control-sequence-character-issue
    if [[ -v TMUX ]]; then
        local tmux_fmts='\ePtmux;\e%b\e\\'
    else
        local tmux_fmts='%b'
    fi

    case "$(zle-vi-mode)" in
        $ZLE_VI_MODE_CMD) printf $tmux_fmts "\e[2 q" ;; # cursor -> block
        $ZLE_VI_MODE_INS) printf $tmux_fmts "\e[6 q" ;; # cursor -> vertical bar
        $ZLE_VI_MODE_REP)
            printf $tmux_fmts "\e[4 q" # cursor -> underline
            MARK=$CURSOR
            ;;
        *)
            ;;
    esac
}

zle -N zle-line-init
zle -N zle-keymap-select


# Vi-mode
bindkey -v

bindkey '^L' clear-screen

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

bindkey '^[[3~' delete-char
bindkey '^?' zle-backward-delete-char-fix
bindkey '^h' zle-backward-delete-char-fix

bindkey -M menuselect '^[[Z' reverse-menu-complete

export KEYTIMEOUT=1


# Aliases

# Make sure that aliases still work even when run, using `sudo` or `nohup`.
# See here: https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias nohup='nohup '

alias sl='lsd'
alias ls='lsd'
alias la='lsd -AF'
alias ll='lsd -AF -l'
alias li='lsd -AF -l -i'

alias cat='bat'

alias vi='nvim -O'
alias vim='nvim -O'
alias nvim='nvim -O'
alias vimdiff='nvim -d'

alias antigenrc='nvim -O ~/.antigenrc'
alias tmuxrc='nvim -O ~/.tmux.conf'
alias vimrc='nvim -O ~/.config/nvim/init.vim'
alias zshrc='nvim -O ~/.zshrc'

alias gdb='gdb -q'
alias gdb-pwndbg='gdb -q -ex init-pwndbg'
alias gdb-gef='gdb -q -ex init-gef'

alias info='info --vi-keys'

alias pacman='pacman --color=always'
alias yay='yay --color=always'


# Envvars
export EDITOR=nvim
export VISUAL=nvim

export BROWSER=firefox

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if [[ ! $PATH =~ $HOME/.cargo/bin ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="/opt/cuda/bin:$PATH"
fi


# Miscellaneous
tabs -4

# Use this utility as recommended by the manpage.
# See here: `man which`
function which
{
    ( alias; declare -f ) | /usr/bin/which \
        --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}

# Easily open various files.
function open
{
    ( xdg-open "$@" </dev/null >/dev/null 2>&1 & )
}

# Get a list of installed packages, sorted by install time.
function yaylog
{
    yay -Qi                                                                 \
        | grep -P "^(Name|Install Date)"                                    \
        | sed  -r ":a;N;s/Name\s+: (.*)\nInstall Date\s+: (.*)/\2\t\1/"     \
        | { while IFS=$'\t' read pkg_date pkg_name; do
                echo -e $(date +%F\ %T --date="$pkg_date") '\t' $pkg_name
            done
            }                                                               \
        | sort
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Pyenv shims and autocompletion.
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## Options section
unsetopt NOMATCH                                                # Passes the command as is instead of reporting pattern matching failure see Chrysostomus/manjaro-zsh-config#14
setopt CORRECT                                                  # Auto correct mistakes
setopt EXTENDEDGLOB                                             # Extended globbing. Allows using regular expressions with *
setopt NOCASEGLOB                                               # Case insensitive globbing
setopt RCEXPANDPARAM                                            # Array expension with parameters
setopt NOCHECKJOBS                                              # Don't warn about running processes when exiting
setopt NUMERICGLOBSORT                                          # Sort filenames numerically when it makes sense
setopt NOBEEP                                                   # No beep
setopt APPENDHISTORY                                            # Immediately append history instead of overwriting
setopt HISTIGNOREALLDUPS                                        # If a new command is a duplicate, remove the older one
setopt AUTOCD                                                   # if only directory path is entered, cd there.
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS						                              # Ignore rows if they are duplicates
setopt HIST_REDUCE_BLANKS					                              # Delete empty lines from history file
setopt HIST_IGNORE_SPACE					                              # Ignore a record starting with a space

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history


# Some enviroment variables
export HELPDIR=/usr/share/zsh/$ZSH_VERSION/help  # directory for run-help function to find docs
unalias run-help && autoload -Uz run-help

# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# Make it possible to use completion specifications and functions written for bash.
autoload -Uz bashcompinit
bashcompinit

# Completion
autoload -Uz compinit
compinit -d ${XDG_CACHE_HOME:-~/.cache}/.zcompdump-$ZSH_VERSION

# list of completers to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate _files

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'       original true

# format for completion
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# format for warnings
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

# activate color-completion
zstyle ':completion:*'                 list-colors ${(s.:.)LS_COLORS}

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false

# activate menu
zstyle ':completion:*:history-words'   menu yes

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# match uppercase from lowercase
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''

# if there are more than 3 options allow selecting from a menu
zstyle ':completion:*'                 menu select=3
zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*'                 verbose true

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete manual by their section
zstyle ':completion:*:manuals'         separate-sections true
zstyle ':completion:*:man:*'           menu yes select

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin            \
                                           /usr/X11R6/bin  \

# provide .. as a completion
zstyle ':completion:*'                 special-dirs ..

# Prompt for spelling correction of commands.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]?'

## Keybindings section
bindkey -e

# If NumLock is off, translate keys to make them appear the same as with NumLock on.
bindkey -s '^[OM' '^M'  # enter
bindkey -s '^[Ok' '+'
bindkey -s '^[Om' '-'
bindkey -s '^[Oj' '*'
bindkey -s '^[Oo' '/'
bindkey -s '^[OX' '='

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
 bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
 bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Aliases.
alias ..="cd ../"
alias ...="cd ../../"
alias cat="bat"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias tree="tree -aC -I .git"
alias cp="cp -iv"
alias du="du -ach | sort -h"
alias free="free -mth"
alias dir="ls -lSrah"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias myip="curl http://ipecho.net/plain; echo"

alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'

alias xbup='sudo xbps-install -Suv'
alias xbin='sudo xbps-install'
alias xbrm='sudo xbps-remove'
alias xbq='xbps-query'

ff() {
  find . -type f -iname '*'$@'*' -ls
}

# Theming section
eval "$(dircolors -b)"
autoload -U colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done


# Maia prompt
PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "

## Prompt on right side:
RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"

# enable substitution for prompt
setopt prompt_subst

# support colors in less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS=-iRFXMx4
export PAGER=less

## Plugins section

[[ -s "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s "$HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]] && source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[[ -s "$HOME/.zsh/zsh-history-substring-search-master/zsh-history-substring-search.plugin.zsh" ]] && source $HOME/.zsh/zsh-history-substring-search-master/zsh-history-substring-search.plugin.zsh
[[ -s "/usr/share/grc/grc.zsh" ]] && source /usr/share/grc/grc.zsh

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

#
#zsh-autosuggestions
#
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
ZSH_AUTOSUGGEST_USE_ASYNC=true

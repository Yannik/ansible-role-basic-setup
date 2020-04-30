# This file is getting sourced, therefore no hashbang

# Not an interactive shell?
[[ $- == *i* ]] || return 0

export EDITOR=vim

source /usr/local/bin/hcmnt
hcmntextra='date "+%d.%m.%Y %H:%M:%S"'

hcmnt_cmd() {
    hcmnt -eityl ~/.hcmnt.log $LOGNAME@$HOSTNAME
}

[ -n "$ZSH_VERSION" ] && precmd_functions+=(hcmnt_cmd)

# only bash stuff after this
[ -n "$BASH_VERSION"  ] || return 0

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}hcmnt_cmd"

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it (https://unix.stackexchange.com/questions/6501)
shopt -s histappend

# make .bash_history unlimited size
HISTSIZE=
HISTFILESIZE=

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
#src: https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows/1292#1292


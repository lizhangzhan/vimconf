# mkdir -p & cd
function mkcd() {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

# svn diff & less
function svndiff() {
  svn diff "$@" | colordiff | less -r;
}

# svn log & less
function svnlog() {
  svn log "$@" --limit 10 | less -r;
}

# svn diff -r <latest commit>
function svnshow() {
  head=$(svn log --limit 1 | awk -F '|' 'NR==2 {print $1}' | tr -s ' ');
  last='r'$((${head:1} - 1));
  svn diff -r ${last} | colordiff | less -r;
}

# set iterm window title
function title {
  unset PROMPT_COMMAND
  echo -ne "\033]0;"$@"\007"
}

# show tree directory in current path
function tree {
  dir=$@
  find ${dir} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

# scp2 between local and removte
function scp2 {
  if [[ $# != 4 ]]; then
    echo "$#"
    echo "Usage: scp2 <localDir> <remoteDir> <username> <remote_server>"
  else
    local_dir=$1
    remote_dir=$2
    username=$3
    remote_server=$4
    echo "scp -r -P 36000 ${local_dir} ${username}@${remote_server}:${remote_dir}"
    scp -r -P 36000 ${local_dir} ${username}@${remote_server}:${remote_dir}
  fi
}

function docker_daemon() {
  ret=$(ps -ef | grep colima1 | grep -v grep)
  if [[ $? == 1 ]]; then
    colima start
  fi
}

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

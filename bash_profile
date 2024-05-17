source ~/.bashrc
source ~/.bash_prompt

# work around for issue, https://github.com/matplotlib/matplotlib/issues/5420
export LC_ALL=en_US.UTF-8

# token for brew install
export HOMEBREW_GITHUB_API_TOKEN=e619e6e5d47d067acfd7c0645b6401075461112f

# some more ls aliases
alias rm='rm -i'
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias kubectl="minikube kubectl --"

alias cls='rm *~'
alias vi='/usr/local/bin/vim'
alias chrome='open -a "Google Chrome"'
alias colima_start="colima start --cpu 4 --memory 6 --disk 100"
alias colima_stop="colima stop --force"

export TERM=screen-256color
export EDITOR=vim
export GIT_EDITOR=vim

#===================================
# enable auto completion
#==================================
bind "set completion-ignore-case on"
#==================================

# export CC=/usr/bin/g++
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home/"
export PATH="/usr/local/opt/python/libexec/bin:${PATH}"
export PATH="/usr/local/bin":${PATH}
export PATH="${HOME}/Local/bin":${PATH}

# ================================
# C/C++ compile setting
# ================================
export LD_LIBRARY_PATH=.:/usr/local/lib:${LD_LIBRARY_PATH}

# ================================
# virtual env setting
# ================================
source ~/tf_venv/bin/activate

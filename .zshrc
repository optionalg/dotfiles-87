# Essential
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Theme
autoload -Uz promptinit
promptinit
prompt peepcode $

# (Neo)Vim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
alias nvr="${HOME}/.pyenv/versions/py36/bin/nvr"
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias vim="nvim"
alias vi="nvim"

# Matlab
export PATH="/Applications/MATLAB_R2016b.app/bin:/Applications/MATLAB_R2016b.app/bin/maci64:$PATH"

# Git
export DEFAULT_USER=$(whoami)
# Conflict between git stash in zsh shell and ghostscript
unalias gs

# Neovim for everything
export EDITOR=nvim
export GIT_EDITOR=nvim
export VISUAL=nvim
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    nvim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Stop cronjob annoying 'mails'
unset MAILCHECK

# Python
export PYTHON_CONFIGURE_OPTS="--enable-framework"  # to install Python as a Framework (matplotlib backend)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# Save time when expliciting if 2 or 3...
alias python3=~/.pyenv/versions/venv36/bin/python3
alias python2=~/.pyenv/versions/venv27/bin/python2

# Prepend local: priority to installed apps.
# Reminder: Homebrew sometimes (if intrusive) won't automatically symlink to these folders.
export PATH="/usr/local/bin:/usr/local/lib:/usr/local/include:$PATH"

export PATH="$HOME/bin:/usr/local/share/npm/bin:/usr/local/share/python:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/bin:$PATH"
export EDITOR="$HOME/scripts/editor.sh"

# Based on http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=ExFxBxDxcxegedabagacad

# For rbenv
# To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# To use Homebrew's directories rather than ~/.rbenv add to your profile:
# export RBENV_ROOT=/usr/local/opt/rbenv

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# From http://www.worldgoneweb.com/2011/iterm2-advanced-features/
growl() { echo -e $'\e]9;'${1}'\007' ; return  ; }

# Git prompt
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWTRACKEDFILES=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# Make Terminal tab completion rational
# From http://sigpipe.macromates.com/2012/08/10/path-completion-bash/
FIGNORE=".o:~:Application Scripts"

source ~/.alias

# In case RVM is installed, set it up:
# This loads RVM into a shell session. If editing this file, keep this at the end.
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

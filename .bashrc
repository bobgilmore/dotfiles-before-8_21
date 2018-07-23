function function_exists {
    FUNCTION_NAME=$1
    [ -z "$FUNCTION_NAME" ] && return 1
    declare -F "$FUNCTION_NAME" > /dev/null 2>&1
    return $?
}

function parse_xcode_version {
    if hash xcodebuild 2>/dev/null; then
        echo `xcodebuild -version | head -1 | cut -f2 -d" "`
    else
        echo ""
    fi
}

export GOROOT="/usr/local/opt/go/libexec/"
export GOPATH="$HOME/code/go"
export PATH="$HOME/bin:$HOME/scripts:$HOME/scripts/colors:/usr/local/share/npm/bin:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/sbin:/usr/local/bin:$GOROOT/bin:$GOPATH/bin:$HOME/Library/Haskell/bin:$HOME/.cask/bin:$PATH"
export EDITOR="$HOME/scripts/editor.sh"
export MANPATH="$MANPATH:/usr/local/opt/erlang/lib/erlang/man"
# Opt out of Homebrew analytics
# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# CDPATH completon http://pivotallabs.com/cdpath-bash-completion-in-osx/
# http://stackoverflow.com/questions/657108/bash-recursively-adding-subdirectories-to-the-path
if [ -d "$HOME/code" ]; then
  export CDPATH=".:$(find $HOME/code -type d -depth 1 -maxdepth 1 | tr '\n' ':')"
fi
if [ -d "$HOME/Documents/code" ]; then
  export CDPATH=".$CDPATH:$(find $HOME/Documents/code -type d -depth 1 -maxdepth 1 | tr '\n' ':')"
fi

if hash brew 2>/dev/null; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
else
    echo "Skipping brew bash completion setup"
fi

# Based on http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1

# For rbenv
# To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# To use Homebrew's directories rather than ~/.rbenv add to your profile:
# export RBENV_ROOT=/usr/local/opt/rbenv

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Added by MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

### Added by fastlane:
export PATH="$HOME/.fastlane/bin:$PATH"

source ~/.bash.colors

# Git prompt
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]
then
  source /usr/local/etc/bash_completion.d/git-completion.bash
  source /usr/local/etc/bash_completion.d/git-prompt.sh
else
  if [ -f ~/bash_completion.d/git-completion.bash ]
  then
    echo "Loading local (possibly outdated) copies of git-completion.bash etc."
    source ~/bash_completion.d/git-completion.bash
    source ~/bash_completion.d/git-prompt.sh
  else
    echo "Could not find /usr/local/etc/bash_completion.d/git-completion.bash"
  fi
fi

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWTRACKEDFILES=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

if [[ $(uname -n) == *local ]]
then
  uname_display="local"
else
  uname_display=$(uname -n)
fi

if [ $(uname) = 'Darwin' ]; then
  MAIN_PROMPT_COLOR=${BIBlue}
else
  MAIN_PROMPT_COLOR=${BIRed}
fi

if function_exists __git_ps1; then
  export PS1="\[${MAIN_PROMPT_COLOR}\["'\! \u@$uname_display \w 🔨 `parse_xcode_version`$(git branch &>/dev/null;\
  if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
      echo "'\\[${Green}\\['" ; \
    else
      echo "'\\[${Red}\\['" ; \
    fi)"; \
  fi)$(__git_ps1 " (%s)") > \n\[\e[0m\['
fi

if [ $(whoami) = 'root' ]
then
  red
  echo "You're using a root shell.  ROOT?  Are you insane?"
fi

# Things that are obviously Mac-only go here.
if [ $(uname) = 'Darwin' ]
then
  # Make Terminal tab completion rational on Mac
  # From http://sigpipe.macromates.com/2012/08/10/path-completion-bash/
  FIGNORE=".o:~:Application Scripts"
fi

if [ -s "$HOME/scripts/na.sh" ]; then source "$HOME/scripts/na.sh"; fi

export HISTFILESIZE=3000
export HISTSIZE=${HISTFILESIZE}
export HISTCONTROL=ignoredups
export HISTIGNORE="pwd:ls:ls -latr:git status:"

if [ -f ~/.alias ]
then
  source ~/.alias
fi

if [ -f /usr/local/bin/tmux ]
then
  tmux list-sessions 2> /dev/null
fi

# In case RVM is installed, set it up:
# This loads RVM into a shell session. If editing this file, keep this at the end.
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# From https://gist.github.com/burke/1688857
# These need to be updated for Ruby 2.1.x
export RUBY_GC_MALLOC_LIMIT=1000000000
#export RUBY_FREE_MIN=500000
export RUBY_GC_HEAP_FREE_SLOTS=40000

# For hh command line completion - https://github.com/dvorka/hstr/blob/master/CONFIGURATION.md
bind '"\C-r": "\C-ahh \C-j"'
export HH_CONFIG=hicolor

shopt -s histappend

## Fastlane
# Set up environment for Fastlane
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Finally, read a purely custom .bashrc.local if it exists.
# Among other things this allows me to keep proprietary information
# (such as server names) out of my public dotfiles repo.
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

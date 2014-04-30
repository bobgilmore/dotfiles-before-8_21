#!/bin/bash

# Find the location of the script.
DOTFILE_DIRECTORY=`pwd`
BIN_DIRECTORY="$HOME/bin"
SCRIPT_DIRECTORY="$HOME/scripts"
DROPBOX_DIRECTORY="$HOME/Dropbox/dotfile_symlinks"
LIB_SUBLIME="Library/Application Support/Sublime Text 2"
HOME_VIM="$HOME/.vim"

# Three-argument form: sourcedir, targetdir, source_and_target_file
# Four-argument form:  sourcedir, targetdir, sourcefile, targetfile
link_if_necessary() {
  local sourcefile="$3"
  local sourcedir="$1"
  local targetdir="$2"
  if [ -z "$4" ]
  then
    local targetfile="$3"
  else
    local targetfile="$4"
  fi

  if [ ! -e "$targetdir/$targetfile" ]; then
    ln -is "$sourcedir/$sourcefile" "$targetdir/$targetfile"
  else
    if [[ $(readlink "$targetdir/$targetfile") != "$sourcedir/$sourcefile" ]]; then
      local full_targ="$targetdir/$targetfile"
      rm ${full_targ%/}
      ln -is "$sourcedir/$sourcefile" "$full_targ"
    fi
  fi
}

if [ $(uname) = 'Darwin' ]; then
  if [ ! -f /usr/local/bin/brew ]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi
  Echo "Installing Homebrew formulae"
  brew bundle
fi

echo "Symlinking dotfiles in ~"
for f in $DOTFILE_DIRECTORY/.* ; do
  base=$(basename $f)
  if [[ ($base != ".") && ($base != "..") && ($base != ".git") ]]; then
    link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" $base
  fi
done

echo "Symlinking local helper apps in ~/bin"
mkdir -p "$BIN_DIRECTORY"

if [ $(uname) = 'Darwin' ]; then
  if [ -f "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ]
  then
    link_if_necessary "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin" "$BIN_DIRECTORY" "subl"
  else
    echo "Can't find /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl for symlink."
  fi
fi

echo "Symlinking helper scripts in ~/scripts"
mkdir -p "$SCRIPT_DIRECTORY"
for f in $DOTFILE_DIRECTORY/scripts/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPT_DIRECTORY" $(basename $f)
done

echo "Symlinking warning git hooks in ~/.git_template_warning"
link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".git_template_warning"
git config --global init.templatedir '~/.git_template_warning'

gitconfig_include_path=`git config --global --get-all include.path`
if [[ ! $gitconfig_include_path == *~/.gitconfig_shared* ]] ; then
  echo "Including ~/.gitconfig_shared in ~/.gitconfig"
  git config --global --add include.path "~/.gitconfig_shared"
fi

# Deal with constantly-changing files (that shouldn't be checked in) stored on Dropbox

if [ $(uname) = 'Darwin' ]; then
  if [ -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME/Installed Packages" ]
  then
    echo "Symlinking Sublime Text 2 in ~/Library/Application Support/"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Installed Packages"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Packages"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Pristine Packages"
  else
    echo "Can't find $DROPBOX_DIRECTORY/Library/Application Support/Sublime Text 2/Installed Packages/ for symlinks."
  fi
fi

  else
  fi
fi

# Install Vim addons...
# From https://github.com/tpope/vim-pathogen
echo -e "Installing Vim pathogen into $HOME_VIM/autoload"
mkdir -p $HOME_VIM/autoload
curl -Sso $HOME_VIM/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

if [ -d "$DROPBOX_DIRECTORY/vim" ]; then
  echo "Symlinking Vim bundles in $HOME_VIM/bundle"
  link_if_necessary "$DROPBOX_DIRECTORY/vim" "$HOME_VIM" "bundle"
else
  if [ ! -d "$HOME_VIM/bundle" ]; then
    echo "Creating $HOME_VIM/bundle for Vim pathogen bundles"
    mkdir -p "$HOME_VIM/bundle"
  fi
fi
# Done with Vim

if [ -d "$DROPBOX_DIRECTORY" ]; then
echo "This directory exists for use by https://github.com/bobgilmore/dotfiles

It contains directories and files that apps (such as Sublime Text and Vim)
constantly modify, and which therefore aren't really suited for
checking in to git.

This README.md was created by the github project's setup.sh script for
informational purposes.

See the github repo for more information.

20 September 2013, Bob Gilmore
" > "$DROPBOX_DIRECTORY/README.md"
fi
#Finished with Dropbox files.

# Perform operations that only make sense on a Mac...
if [ $(uname) = 'Darwin' ]
then
  
  # Install Brett Terpstra's na script - https://github.com/ttscoff/na
  if [ -d "/Applications/TaskPaper.app" ]
  then
    NA_DIR="$DOTFILE_DIRECTORY/na"
    if [ -d "$NA_DIR" ]; then
      echo "Updating Brett Terpstra's NA script for TaskPaper"
      cd $NA_DIR && git pull
    else
      # Cloning to $NA_DIR
      echo "Installing Brett Terpstra's NA script for TaskPaper; cloning NA repo into $NA_DIR"
      git clone https://github.com/ttscoff/na.git $NA_DIR
    fi
    cd $DOTFILE_DIRECTORY
    if [ -d "$NA_DIR" ]
    then
      echo "Symlinking NA in $SCRIPT_DIRECTORY"
      link_if_necessary "$NA_DIR" "$SCRIPT_DIRECTORY" "na.sh"
    else
      echo "Can't find directory $NA_DIR for symlink to the NA script."
    fi
  else
    echo "Skipping NA since TaskPaper not installed."
  fi


  # Install the CriticMarkup-toolkit.  
  # See http://brettterpstra.com/2013/05/18/criticmarkup-in-marked-1-dot-4/ and 
  # https://github.com/CriticMarkup/CriticMarkup-toolkit
  WANTS_CM='n'
  if [ -d "$DOTFILE_DIRECTORY/CriticMarkup-toolkit" ]
  then
    WANTS_CM='y'
  else
    echo "If you're a MultiMarkdown user, we'll install the CriticMarkup-toolkit."
    read -r -p "ARE you a MultiMarkdown user? [y/N] " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      WANTS_CM='y'
    fi
  fi

  if [ "$WANTS_CM" = 'y' ]
  then
    CRIT_DIR="$DOTFILE_DIRECTORY/CriticMarkup-toolkit"
    if [ -d "$CRIT_DIR" ]; then
      echo "Updating CriticMarkup-toolkit"
      cd $CRIT_DIR && git pull
    else
      # Cloning to $CRIT_DIR
      echo "=> Cloning CriticMarkup-toolkit into $CRIT_DIR"
      git clone https://github.com/CriticMarkup/CriticMarkup-toolkit.git $CRIT_DIR
    fi
    cd $DOTFILE_DIRECTORY
    if [ -d "$CRIT_DIR" ]
    then
      echo "Symlinking CriticMarkup-toolkit in $SCRIPT_DIRECTORY"
      link_if_necessary "$CRIT_DIR/Marked Processor" "$SCRIPT_DIRECTORY" "critic.py" "marked_processor_critic.py"
    else
      echo "Can't directory $CRIT_DIR for symlinks to the CriticMarkup-toolkit scripts."
    fi
  fi

  echo "Configuring bundle..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

  echo "------ TODO ------"
  if [ -d "/Applications/KeyRemap4MacBook.app/" ]
  then
    mkdir -m 755 -p "$HOME/Library/Application Support/KeyRemap4MacBook/"
    link_if_necessary "$DOTFILE_DIRECTORY" "$HOME/Library/Application Support/KeyRemap4MacBook" "private.xml"
    /Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli reloadxml
    echo "When installation is complete,"
    echo "Run KeyRemap4MacBook, open its Preference pane, go to the Change Key panel, and check all of the check boxes at the top of the remapping list."
    echo "This will enable Hyper key.  See http://brettterpstra.com/2012/12/08/a-useful-caps-lock-key/ for more on implementing it." 
  else
    echo "You should install KeyRemap4MacBook.  It's awesome!  Then run this setup script again."
  fi
  echo "---- END TODO ----"

  echo "Running .osx preferences script"
  chmod 777 ./.osx
  ./.osx
fi

# Define env vars and functions required by setup scripts

# Find the location of the script.
DOTFILE_DIRECTORY=$(pwd)
BIN_DIRECTORY="$HOME/bin"
ALIASES_DIRECTORY="$HOME/aliases"
SCRIPTS_DIRECTORY="$HOME/scripts"
DROPBOX_DIRECTORY="$HOME/Dropbox/dotfile_symlinks"
LIB_SUBLIME_3="Library/Application Support/Sublime Text 3"
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
      rm -rf "${full_targ%/}"
      ln -is "$sourcedir/$sourcefile" "$full_targ"
    fi
  fi
}

dotfiles
========
* Pre-configure System, Finder, etc. preferences
* Bash settings, paths, aliases, etc.
* Vim settings
* Git configuration
* Fix Terminal tab completion
* Tweak Rails project creation
* Tweak gem installation behavior
* Create symbolic links...
    * For Sublime Text 2 executable in ~/bin/
    * For Sublime Text 2 packages from Dropbox (ignored if the packages don't exist on Dropbox).
    * For vim packages from Dropbox (ignored if the packages don't exist on
      Dropbox).

System and Finder preferences based on work by Mathias Bynens.

Setup
=====
Will require a restart for all changes to take effect.

Clone the repository locally, then run the setup script.

    git clone git@github.com:bobgilmore/dotfiles.git
    cd (into the repository directory)
    chmod 777 ./setup.sh
    ./setup.sh

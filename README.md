dotfiles
========
* Pre-configure System, Finder, etc. preferences
* Bash settings, prompts, paths, aliases, etc.
* Homebrew and npm setup
* Vim settings
* Git aliases
    * Does *not* install git hooks - those are at https://github.com/bobgilmore/githooks
* Fix Terminal tab completion
* Rails project creation
    * `.railsrc` contains instruction on making new projects default to postgresql
* Gem installation behavior
* Create symbolic links...
    * For Sublime Text 3 executable in ~/bin/
    * For Sublime Text 3 preferences and packages from Dropbox (ignored if the packages don't exist on Dropbox).
    * For Emacs and vim packages from Dropbox (ignored if the packages don't exist on Dropbox).

System and Finder preferences based on work by Mathias Bynens.

Setup
=====
Requires a restart for all changes to take effect.

Clone the repository locally, then run the setup script.

    git clone git@github.com:bobgilmore/dotfiles.git
    cd (into the repository directory)
    ./setup.sh

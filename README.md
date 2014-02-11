dotfiles
========
* Pre-configure System, Finder, etc. preferences
* Bash settings, prompts, paths, aliases, etc.
* Vim settings
* Git configuration
    * Sets up an included config file to install aliases
    * Installs a pre-commit hook prompting users to install some *useful* hooks.
        * If the git config variable `hooks.symlinksourcerepo` is set from a previous git hooks installation, this git pre-commit hook will specifically prompt users on how to create symlinks to *that* installation.  Otherwise it prompts the user to install and use https://github.com/bobgilmore/githooks
* Fix Terminal tab completion
* Rails project creation
    * `.railsrc` contains instruction on making new projects default to postgresql
* Gem installation behavior
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

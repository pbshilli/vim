vim
===

Overview
--------

This repository is a self-contained package of all my settings for Vim.

Installation
------------
* Check out this repository
* Add the repository path to the PATH environment variable
* Create a symlink to \_vimrc in $USERPROFILE/
* If Visual Studio with VsVim is intalled, create a symlink to \_vsvimrc in $USERPROFILE/ and remap CTRL-O, CTRL-I, CTRL-N, CTRL-P, and CTRL-] to the vim-style behavior
* Run install.ps1
* Open Vim, run `:PlugInstall` and restart

Jedi Vim Installation
------------
* Install Jedi by navigating to $USERPROFILE/vimfiles/plugged/jedi-vim/jedi and running `python setup.py install`
* Add $USERPROFILE/plugged/jedi-vim to the PYTHONPATH environment variable

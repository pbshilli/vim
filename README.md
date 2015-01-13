vim
===

Overview
--------

This repository is a self-contained package of all my settings for Vim.

Installation
------------
1. Check out this repository to $HOME/vimfiles/bundle
2. Add $HOME/vimfiles/bundle to the PATH environment variable
3. Create a symlink to $HOME/vimfiles/bundle\_vimrc in $HOME/
4. If Visual Studio with VsVim is intalled, create a symlink to $HOME/vimfiles/bundle\_vsvimrc in $HOME/ and remap CTRL-O, CTRL-I, CTRL-N, CTRL-P, and CTRL-] to the vim-style behavior
4. Install Jedi by navigating to $HOME/vimfiles/bundle/jedi-vim/jedi and running `python setup.py install`
5. Add $HOME/vimfiles/bundle/jedi-vim to the PYTHONPATH environment variable


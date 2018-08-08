# .emacs.d
My configuration of the emacs text editor. There are comments in the init file if you want to know what is going on. I might make a cleaner, more understandable version later.

## setup
Some basic setup is needed for the configuration to work. I have not yet installed it on another computer than my own mac, so you might have to tweak some stuff if you want to use it.

### submodule
This project uses submodules so you have to run `git submodule init` followed by `git submodule update` after you´ve cloned the repository. This will install the git repositories within this repository (with lots of cool features)

### python
I use a "Global virtual environment" for python in emacs. To get this up and running you have to run these commands from the shell inside the .emacs.d folder:
```
pip install venv
python3 -m venv emacs-env
source emacs-env/bin/activate
pip install -r pip-requirements.txt
```

### magit
If you want to byte-compile magit (make it faster) you will have to make a file called `config.mk` inside the ~/.emacs.d/packages/magit/ directory containing these lines:
```
LOAD_PATH  = -L ~/.emacs.d/packages/magit/lisp
LOAD_PATH += -L ~/.emacs.d/packages/dash.el
LOAD_PATH += -L ~/.emacs.d/packages/magit-popup
LOAD_PATH += -L ~/.emacs.d/packages/ghub
LOAD_PATH += -L ~/.emacs.d/packages/with-editor
```
and then run `make` within the ~/.emacs.d/packages/magit directory.
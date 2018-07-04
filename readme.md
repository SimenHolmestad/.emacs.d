# .emacs.d

My configuration files for the emacs text editor. Still in the works but this is what i´ve got so far. The init.el file is kind of messy right now and could need a cleanup, but i´ve commented parts of it to make it a little more understandable.

## setup
Some basic setup is needed for the project to work. I have not yet installed it on another computer, so you might have to tweak some stuff if you want to use it. 

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
Magit is currently a hassle to install. While i have plan to make some kind of setup-script, currently, you will have to make a file called `config.mk` inside the ~/.emacs.d/packages/magit/ directory containing these lines:
```
LOAD_PATH  = -L ~/.emacs.d/packages/magit/lisp
LOAD_PATH += -L ~/.emacs.d/packages/dash.el
LOAD_PATH += -L ~/.emacs.d/packages/magit-popup
LOAD_PATH += -L ~/.emacs.d/packages/ghub
LOAD_PATH += -L ~/.emacs.d/packages/with-editor
```
and then run `make` within the ~/.emacs.d/packages/magit directory.
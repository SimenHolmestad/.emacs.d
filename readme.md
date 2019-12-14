# .emacs.d
My configuration file for the emacs text editor. It is written in an org-mode-file (.org) for easier organisation and a better editing experience in emacs. All the code blocks in the org-file are run with the `org-babel-load-file`-function in `init.el` when emacs starts.

Although you are free to use my configuration as a starting point for emacs, I would rather recommend you to make your own config-file and steal stuff from this one (and others!) while you go along. Some of the fun part of emacs is to configure it the way you want.

## How to run emacs with this configuration
1. Download emacs. This can be done by following [this guide](https://www.gnu.org/software/emacs/download.html), but in my experience [this version](https://github.com/railwaycat/homebrew-emacsmacport) (using `brew cask`) is better for mac than the regular homebrew version.
2. Clone this repo into your home folder
3. Run emacs

Be prepared to wait a bit while starting emacs for the first time, as it will take some time to download all the packages. There will perhaps be some compile warnings after the packages are downloaded, and these might be smart to check out.

The `init.el`-file is going to change after running emacs for the first time with this config and should not be committed afterwards. To make sure `init.el` is not shown in git, you can run the command:
```
git update-index --assume-unchanged init.el
```
To undo the operation above, you can run:
```
git update-index --no-assume-unchanged init.el
```

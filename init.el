;; remove mouse stuff
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(ns-alternate-modifier nil)
 '(ns-command-modifier (quote meta))
 '(ns-right-command-modifier (quote super))
 '(select-enable-clipboard t))

(fset 'yes-or-no-p 'y-or-n-p) ;; Changes "yes or no" to "y or n"
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-h") 'delete-backward-char) ;; You can use F1 for help
(global-set-key (kbd "C-+") 'text-scale-increase) ;; increase text-size
(global-set-key (kbd "C--") 'text-scale-decrease) ;; decrease text-size

;; Send backup-files to the .backups-directory
(setq backup-directory-alist `(("." . "~/.emacs.d/.backups"))) ;; So no backup-files pop up everywhere

;; a string manipulation library
(add-to-list 'load-path "~/.emacs.d/packages/s.el")

(require 'linum)
(global-linum-mode t) ;; Add line-numbers


;; windmove configuration
(global-set-key (kbd "M-F") 'windmove-right)
(global-set-key (kbd "M-B") 'windmove-left)
(global-set-key (kbd "M-P") 'windmove-up)
(global-set-key (kbd "M-N") 'windmove-down)


;; iy-go-to-char for char navigation by chars instead of C-f C-f C-f...
(add-to-list 'load-path "~/.emacs.d/packages/iy-go-to-char/")
(require 'iy-go-to-char)
(global-set-key (kbd "C-l") 'iy-go-to-char)
(global-set-key (kbd "M-L") 'iy-go-to-char-backward)
(global-set-key (kbd "M-s M-s") 'isearch-forward-symbol-at-point)


;; Web-mode for editing html-files, docs at http://web-mode.org/
(add-to-list 'load-path "~/.emacs.d/packages/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django"    . "\\html\\'"))) ;; will indent django-tags in html-files
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)


;; Expand-region
(add-to-list 'load-path "~/.emacs.d/packages/expand-region.el/")
(require 'expand-region)
(global-set-key (kbd "M-ø") 'er/expand-region)


;; Ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/packages/ace-jump-mode/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-ø") 'ace-jump-mode)


;; Multiple-cursors
(add-to-list 'load-path "~/.emacs.d/packages/multiple-cursors.el")
(require 'multiple-cursors)
(global-set-key (kbd "C-æ") 'mc/mark-next-like-this)
(global-set-key (kbd "M-æ") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c æ") 'mc/mark-all-like-this)


;; Solarized-themes
(add-to-list 'load-path "~/.emacs.d/packages/solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq solarized-high-contrast-mode-line nil) ;; Set this for fancy mode-line
(setq x-underline-at-descent-line t)
(load-theme 'solarized-dark)

;; a way to toggle themes found on stackexchange
(defvar *haba-theme-dark* 'solarized-dark)
(defvar *haba-theme-light* 'solarized-light)
(defvar *haba-current-theme* *haba-theme-dark*)

;; disable other themes before loading new one
(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

(defun haba/next-theme (theme)
  (if (eq theme 'default)
      (disable-theme *haba-current-theme*)
    (progn
      (load-theme theme t)))
  (setq *haba-current-theme* theme))

(defun haba/toggle-theme ()
  (interactive)
  (cond ((eq *haba-current-theme* *haba-theme-dark*) (haba/next-theme *haba-theme-light*) (spaceline-emacs-theme))
        ((eq *haba-current-theme* *haba-theme-light*) (haba/next-theme 'default) (powerline-revert))
        ((eq *haba-current-theme* 'default) (haba/next-theme *haba-theme-dark*) (spaceline-emacs-theme))))

(global-set-key (kbd "C-x t") 'haba/toggle-theme) ;; bind theme-toggling to c-x t (starts in dark-theme)


;; Spaceline for status bar
(add-to-list 'load-path "~/.emacs.d/packages/powerline")
(add-to-list 'load-path "~/.emacs.d/packages/spaceline")
(require 'spaceline)
(require 'spaceline-segments)
(require 'spaceline-config)
(setq spaceline-minor-modes-separator " | ")
(setq powerline-default-separator 'slant)
(spaceline-emacs-theme)
(spaceline-helm-mode)
(setq powerline-image-apple-rgb t)
(setq powerline-height 20)
(add-to-list 'load-path "~/.emacs.d/packages/fancy-battery")
(require 'fancy-battery)
(add-hook 'after-init-hook #'fancy-battery-mode) ;; Shows battery in fullscreen mode
(setq fancy-battery-show-percentage t)


;; Org-mode
(setq org-startup-indented t) ;; makes org-mode start in a prettier version
(setq org-startup-truncated nil) ;; makes lines shift making it possible to write longer paragraphs
(global-set-key (kbd "C-c C-æ") `org-store-link) ;; copy link to file
(global-set-key (kbd "C-c C-ø") `org-insert-last-stored-link) ;; paste link to file
(setq org-image-actual-width nil) ;; makes images appear smaller
(setq org-startup-with-inline-images t) ;; makes images appear as images and not links
(add-to-list 'load-path "~/.emacs.d/packages/emacs-htmlize") ;; for exporting org to html
(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "WAITING" "|" "DONE" "CANCELED")))
(global-set-key (kbd "C-x C-o") `org-agenda)
(add-hook 'org-agenda-mode-hook (lambda () (linum-mode 0))) ;; removes line-numbers in agenda buffers
(setq org-agenda-window-setup 'current-window)


;; revert buffers without confirmation
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))
(global-set-key (kbd "C-x C-å") `revert-buffer-no-confirm)


;; Dired-modification
(add-to-list 'load-path "~/.emacs.d/packages/dired-details") ;; makes dired look cleaner
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(global-set-key (kbd "C-c C-t") `dired-details-toggle) ;; toggle between clean and "dirty" look
(setq dired-dwim-target t) ;; Makes it possible to move stuff between two dired-buffers fast

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)


;; which-key
(add-to-list 'load-path "~/.emacs.d/packages/emacs-which-key")
(require 'which-key) ;; makes it possible to see keybindings as you type
(which-key-mode)


;; yasnippet
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")
(require 'yasnippet)
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet-snippets")
(require 'yasnippet-snippets)
(add-to-list 'load-path "~/.emacs.d/packages/react-snippets")
(require 'react-snippets)


;; Elpy
;; dependencies first
(add-to-list 'load-path "~/.emacs.d/packages/elpy")
(add-to-list 'load-path "~/.emacs.d/packages/pyenv")
(add-to-list 'load-path "~/.emacs.d/packages/find-file-in-project")
(add-to-list 'load-path "~/.emacs.d/packages/company-mode")
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0) ;; Sets autocompletion delay to 0
(add-to-list 'load-path "~/.emacs.d/packages/highlight-indentation")
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")
(add-to-list 'load-path "~/.emacs.d/packages/emacs-epc")
(add-to-list 'load-path "~/.emacs.d/packages/auto-complete")
(require 'elpy)
(elpy-enable)
(setq shell-file-name "/bin/bash")
(global-set-key (kbd "C-å") `elpy-company-backend) ;; force auto-completion to start

;; Use jupyter for python shells
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")
(setenv "PYTHONIOENCODING" "utf-8") ;; Makes sure python handles unicode characters

;; Django shell doesn´t work with elpy, so here´s a function from stackoverflow instead:
(defun django-shell (&optional argprompt)
  (interactive "P")
  ;; Set the default shell if not already set
  (labels ((read-django-project-dir
    (prompt dir)
    (let* ((dir (read-directory-name prompt dir))
           (manage (expand-file-name (concat dir "manage.py"))))
      (if (file-exists-p manage)
          (expand-file-name dir)
        (progn
          (message "%s is not a Django project directory" manage)
          (sleep-for .5)
          (read-django-project-dir prompt dir))))))
(let* ((dir (read-django-project-dir
         "django project directory: "
         default-directory))
       (project-name (first
              (remove-if (lambda (s) (or (string= "src" s) (string= "" s)))
                 (reverse (split-string dir "/")))))
       (buffer-name (format "django-%s" project-name))
       (manage (concat dir "manage.py")))
  (cd dir)
  (if (not (equal (buffer-name) buffer-name))
      (switch-to-buffer-other-window
       (apply 'make-comint buffer-name manage nil '("shell")))
    (apply 'make-comint buffer-name manage nil '("shell")))
  (make-local-variable 'comint-prompt-regexp)
  (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
                     py-shell-input-prompt-2-regexp "\\|"
                     "^([Pp]db) "))
  (add-hook 'comint-output-filter-functions
        'py-comint-output-filter-function)
  ;; pdbtrack

  (add-hook 'comint-output-filter-functions 'py-pdbtrack-track-stack-file)
  (setq py-pdbtrack-do-tracking-p t)
  (set-syntax-table py-mode-syntax-table)
  (use-local-map py-shell-map)
  (run-hooks 'py-shell-hook))))

(global-set-key (kbd "C-c C-x s") `django-shell) ;; Set shortcut to django-shell


;; browse-kill-ring (instead of M-y M-y M-y...)
(add-to-list 'load-path "~/.emacs.d/packages/browse-kill-ring")
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings) ;; maps browse-kill-ring to M-y


;; Graphviz-dot-mode
(add-to-list 'load-path "~/.emacs.d/packages/graphviz-dot-mode/")
(require 'graphviz-dot-mode)

(defun graphviz-set-dot-program (dot-program)
  "Let user input a dot-program and make this the standard"
  (interactive "sEnter name of the dot-program (dot, neato, twopi, circo, fdp): ")
  (setq graphviz-dot-dot-program dot-program)
  (graphviz-dot-mode)) ;; The mode needs to reload for changes to take place

(setq graphviz-dot-dot-program "dot")
(add-hook 'graphviz-dot-mode-hook (lambda ()
				    (local-set-key (kbd "C-c s") 'graphviz-set-dot-program)))
(setq graphviz-dot-indent-width 4)
(setq graphviz-dot-auto-indent-on-semi nil)


;; julia-mode
(add-to-list 'load-path "~/.emacs.d/packages/julia-emacs")
(require 'julia-mode)


;; julia-repl
(add-to-list 'load-path "~/.emacs.d/packages/julia-repl")
(require 'julia-repl)
(add-hook 'julia-mode-hook 'julia-repl-mode)


;; Magit
(add-to-list 'load-path "~/.emacs.d/packages/dash")
(add-to-list 'load-path "~/.emacs.d/packages/magit-popup")
(add-to-list 'load-path "~/.emacs.d/packages/ghub")
(add-to-list 'load-path "~/.emacs.d/packages/with-editor")
(add-to-list 'load-path "~/.emacs.d/packages/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/packages/magit/Documentation/"))
(global-set-key (kbd "C-x g") 'magit-status)


;; wgrep
(add-to-list 'load-path "~/.emacs.d/packages/wgrep")
(require 'wgrep)
(global-set-key (kbd "M-g g") 'rgrep)
(global-set-key (kbd "M-g w") 'wgrep-change-to-wgrep-mode)
(global-set-key (kbd "M-g s") 'wgrep-save-all-buffers)


;; Helm
(add-to-list 'load-path "~/.emacs.d/packages/emacs-async")
(add-to-list 'load-path "~/.emacs.d/packages/popup-el")
(add-to-list 'load-path "~/.emacs.d/packages/helm")
(require 'helm-config)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)


;; Helm-projectile
(add-to-list 'load-path "~/.emacs.d/packages/projectile")
(add-to-list 'load-path "~/.emacs.d/packages/helm-projectile")
(require 'projectile)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; sets the basic django test to python3 because i can´t get shell aliases to work in ssh shell-commands (They do work in shh shells though...)
(projectile-register-project-type 'django '("manage.py")
                                  :test "python3 manage.py test")

(add-to-list 'load-path "~/.emacs.d/packages/typescript")
(require 'typescript-mode)
(setq js-indent-level 2)


;; js-2 mode for better javascript highlighting
(add-to-list 'load-path "~/.emacs.d/packages/js2")
(require 'js2-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))


;; rjsx-mode
(add-to-list 'load-path "~/.emacs.d/packages/rjsx-mode")
(require 'rjsx-mode)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))


;; tide mode (for typescript/javascript)
(add-to-list 'load-path "~/.emacs.d/packages/flycheck")
(add-to-list 'load-path "~/.emacs.d/packages/tide")
(require 'tide)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (yas-minor-mode))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook #'setup-tide-mode)
(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

(setq tide-completion-ignore-case t)

(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; Removes tabs and spaces before saving

(load "~/.emacs.d/local_stuff" t) ;; loads machine-specific stuff
(pyvenv-activate "~/.emacs.d/emacs-env") ;; runs the global python virtualenv. This needs to be done after the path is changed in local_stuff.el

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

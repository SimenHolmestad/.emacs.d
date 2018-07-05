;; remove mouse stuff
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; start in fullscreen
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

(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/tiny")
(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/other")

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-h") 'delete-backward-char)

(setq backup-directory-alist `(("." . "~/.emacs.d/.backups")))

(require 'linum)
(global-linum-mode t)
(put 'downcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/packages/iy-go-to-char/")
(require 'iy-go-to-char)
(global-set-key (kbd "C-l") 'iy-go-to-char)
(global-set-key (kbd "M-L") 'iy-go-to-char-backward)

;; web-mode for editing html-files, good docs at http://web-mode.org/
(add-to-list 'load-path "~/.emacs.d/packages/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django"    . "\\html\\'")))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; expand-region
(add-to-list 'load-path "~/.emacs.d/packages/expand-region.el/")
(require 'expand-region)
(global-set-key (kbd "C-ø") 'er/expand-region)

;; ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/packages/ace-jump-mode/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-æ") 'ace-jump-mode)

;; multiple-cursors
(add-to-list 'load-path "~/.emacs.d/packages/multiple-cursors.el")
(require 'multiple-cursors)
(global-set-key (kbd "C-@") 'mc/mark-next-like-this)
(global-set-key (kbd "M-@") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-@") 'mc/mark-all-like-this)

;; add the solarized theme
(add-to-list 'load-path "~/.emacs.d/packages/solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized-dark)

;;
;; a way to toggle themes found on stackexchange
;;
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
  (cond ((eq *haba-current-theme* *haba-theme-dark*) (haba/next-theme *haba-theme-light*))
        ((eq *haba-current-theme* *haba-theme-light*) (haba/next-theme 'default))
        ((eq *haba-current-theme* 'default) (haba/next-theme *haba-theme-dark*))))

(global-set-key (kbd "C-x t") 'haba/toggle-theme) ;; bind theme-toggling to c-x t
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; org-mode-modification
(setq org-startup-indented t) ;; makes org-mode start in a prettier version
(setq org-startup-truncated nil) ;; makes lines shift making it possible to write longer paragraphs
(global-set-key (kbd "C-c C-æ") `org-store-link) ;; copy link to file
(global-set-key (kbd "C-c C-ø") `org-insert-last-stored-link) ;; paste link to file

;; MobileOrg-modification for syncing org-files to mobile
(setq org-directory "~/Dropbox/notater")
(setq org-mobile-inbox-for-pull "~/Dropbox/notater/fra-mobil.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(require 'org)
(org-mobile-pull) ;; downloads new data from mobile on startup

(setq org-mobile-files (apply #'list (mapcar (lambda (filename) (concat "~/Dropbox/notater/" filename))(directory-files "~/Dropbox/notater/" nil "\\.org$")))) ;; For some reason this has to be called in order for the function below to work

(defun org-set-mobile-files-and-push ()
  (when (eq major-mode 'org-mode)
    (setq org-mobile-files (apply #'list
				  (mapcar (lambda (filename)
					    (concat "~/Dropbox/notater/" filename))(directory-files "~/Dropbox/notater/" nil "\\.org$")))) ;; add all files from this folder to be synced to mobile
    (org-mobile-push)
    ))

(add-hook 'after-save-hook 'org-set-mobile-files-and-push) ;; pushes data after saving a file while in org-mode

;; dired-modification
(add-to-list 'load-path "~/.emacs.d/packages/dired-details")
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(global-set-key (kbd "C-c C-t") `dired-details-toggle)
(setq dired-dwim-target t) ;; Makes it possible to move stuff between two dired-buffers fast

;;
;; elpy for python autocomplete and such
;;
;; if you wondered what dependencies elpy had, they are all here. Some of them could be cool to check out!
(add-to-list 'load-path "~/.emacs.d/packages/elpy")
(add-to-list 'load-path "~/.emacs.d/packages/s.el")
(add-to-list 'load-path "~/.emacs.d/packages/pyenv")
(add-to-list 'load-path "~/.emacs.d/packages/find-file-in-project")
(add-to-list 'load-path "~/.emacs.d/packages/company-mode")
(add-to-list 'load-path "~/.emacs.d/packages/highlight-indentation")
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")
(add-to-list 'load-path "~/.emacs.d/packages/emacs-epc")
(add-to-list 'load-path "~/.emacs.d/packages/auto-complete")
(require 'elpy)
(elpy-enable)
(pyvenv-activate "~/.emacs.d/emacs-env") ;; runs the global virtualenv
(setq shell-file-name "/bin/bash")
(global-set-key (kbd "C-å") `elpy-company-backend) ;; force auto-completion to start

;; Use jupyter for python shells
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")
(setenv "PYTHONIOENCODING" "utf-8") ;; Makes sure python handles unicode characters

;;
;; Settings for current django project as i didn´t find a better place for them
;;
(elpy-set-test-runner `elpy-test-django-runner) ;; Find other test-runner-names by grepping the name tags
(setenv "DJANGO_SETTINGS_MODULE" "buk.settings") ;; Makes it possible to run manage.py commands

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

;;
;; elpy ends here
;;

;; browse-kill-ring
(add-to-list 'load-path "~/.emacs.d/packages/browse-kill-ring")
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings) ;; maps browse-kill-ring to M-y

;;
;; magit
;;
;; First install dependencies
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

;; Shell-modification
(setenv "PATH" "/Users/simen/.emacs.d/emacs-env/bin:/opt/local/bin:/opt/local/sbin:/Users/simen/.rvm/gems/ruby-2.4.1/bin:/Users/simen/.rvm/gems/ruby-2.4.1@global/bin:/Users/simen/.rvm/rubies/ruby-2.4.1/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/opt/X11/bin:/Users/simen/.rvm/bin")
;; sets the path so system shell commands can be run from the emacs shell

;; start in file
(find-file "~/Dropbox/notater/todo.org") ;; I want emacs to start at the todo-list where i also can put in links to my most used files for easy access

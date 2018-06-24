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
(global-set-key (kbd "C-.") 'iy-go-to-char)
(global-set-key (kbd "M-.") 'iy-go-to-char-backward)

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
  (mapcar #'disable-theme custom-enabled-themes))


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

;; dired-modification
(add-to-list 'load-path "~/.emacs.d/packages/dired-details")
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(global-set-key (kbd "C-c C-t") `dired-details-toggle)
(setq dired-dwim-target t) ;; Makes it possible to move stuff between two dired-buffers fast

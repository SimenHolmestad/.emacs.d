;; remove mouse stuff
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; start in fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/tiny")
(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/other")

(global-set-key (kbd "C-z") 'undo)

(custom-set-variables        
 '(ns-alternate-modifier nil)
 '(ns-command-modifier 'meta)
 '(ns-right-command-modifier 'super)
 '(x-select-enable-clipboard t))

(setq backup-directory-alist `(("." . "~/.emacs.d/.backups")))

(require 'linum)
(global-linum-mode t)
(put 'downcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/packages/iy-go-to-char/")
(require 'iy-go-to-char)
(global-set-key (kbd "C-i") 'iy-go-to-char)
(global-set-key (kbd "M-i") 'iy-go-to-char-backward)

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
(delete-selection-mode 1)

;;
;; ace jump mode major function
;; 
(add-to-list 'load-path "~/.emacs.d/packages/ace-jump-mode/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-æ") 'ace-jump-mode)

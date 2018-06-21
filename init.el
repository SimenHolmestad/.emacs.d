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

(add-hook 'html-mode-hook
          (lambda ()
            (set (make-local-variable 'sgml-basic-offset) 4)))

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

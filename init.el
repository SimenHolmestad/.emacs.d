(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/tiny")
(add-to-list 'load-path "~/.emacs.d/packages/tiny-tools/lisp/other")

(global-set-key (kbd "C-ø") 'undo)

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
(global-set-key (kbd "C-æ") 'iy-go-to-char)
(global-set-key (kbd "C-å") 'iy-go-to-char-backward)
;; we used the precompiled version of emacs 24
(add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/lisp")
(add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/lisp/emacs-lisp")

;; package.el rocks
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; i need my inconsolata
(set-default-font "-apple-Inconsolata-medium-normal-normal-*-16-*-*-*-m-0-iso10646-1")
(custom-set-variables '(make-backup-files nil))

;; shortcuts
(global-set-key [f7] 'split-window-vertically)
(global-set-key [f8] 'split-window-horizontally)

(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(global-set-key [f10] 'select-next-window)

;; colorthemes
(add-to-list 'load-path "~/.emacs.d/ian/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/ian/emacs-colors-solarized")
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-light)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(make-backup-files nil))

(load "~/prismatic/config/emacs/prismatic")

;; (load-theme 'tango-dark)

;; ihat's customizations
(global-linum-mode t)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(cua-mode)
(install-if 'highlight-symbol)
(require 'whitespace)
(whitespace-mode)

(blink-cursor-mode 0)

;; (require 'evil)
;; (evil-mode 1)
;; (set-default-font "Monaco 12")
;; (set-default-font "Inconsolata-g 12")
(set-default-font "Source Code Pro 12")

;; using highlight-symbol
(global-set-key (kbd "<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "C-<f3>") 'highlight-symbol-next)
(global-set-key (kbd "S-<f3>") 'highlight-symbol-prev)
(global-set-key (kbd "M-<f3>") 'highlight-symbol-prev)

;; http://www.emacswiki.org/emacs/SearchAtPoint
;; highlight symbol and jump to next automatically
(load-library "highlight-symbol")
(defun hl-symbol-and-jump ()
    (interactive)
    (let ((symbol (highlight-symbol-get-symbol)))
      (unless symbol (error "No symbol at point"))
      (unless hi-lock-mode (hi-lock-mode 1))
      (if (member symbol highlight-symbol-list)
          (highlight-symbol-next)
        (highlight-symbol-at-point)
        (highlight-symbol-next))))
(defun hl-symbol-cleanup ()
  (interactive)
  (mapc 'hi-lock-unface-buffer highlight-symbol-list)
  (setq highlight-symbol-list ()))

(global-set-key (kbd "C-8") 'hl-symbol-and-jump)
(global-set-key (kbd "C-*") 'hl-symbol-cleanup)

;; some re-keymapping to make emacs less sux0rs
(global-set-key (kbd "M-1") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-2") 'split-window-vertically) ; split pane top/bottom
(global-set-key (kbd "M-3") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-0") 'delete-window) ; close current pane
(global-set-key (kbd "M-o") 'other-window) ; cursor to other pane

(global-set-key (kbd "M-s-<left>") 'windmove-left)
(global-set-key (kbd "M-s-<right>") 'windmove-right)
(global-set-key (kbd "M-s-<up>") 'windmove-up)
(global-set-key (kbd "M-s-<down>") 'windmove-down)
(global-set-key (kbd "C-<next>") 'windmove-right)
(global-set-key (kbd "C-<prior>") 'windmove-left)

(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<left>") 'move-beginning-of-line)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)

(global-set-key (kbd "s-<backspace>") 'kill-whole-line) ;; TODO: make this paredit aware

;; TODO: make tab be smarter

;; TODO: fixup
(defun select-to-end-of-line (arg)
  (interactive "p")
  (set-mark-command)
  (move-end-of-line))
;; (global-set-key (read-kbd-macro "S-s-<right>") 'select-to-end-of-line)

;; Don't backward kill word. Delete instead.
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
   With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
   With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (read-kbd-macro "<M-DEL>") 'backward-delete-word) ;; TODO: the keybinding is overwritten!
(global-set-key (read-kbd-macro "<M-kp-delete>") 'delete-word)
(global-set-key (read-kbd-macro "<M-d>") 'delete-word)

(dolist (cmd '(delete-word backward-delete-word))
  (put cmd 'CUA 'move))


;; TODO: https://github.com/bosko/emacs-customizations/blob/master/init-lisp.el
;; get C-<left> and <right> to move sexp, and move the form slurp and barf to be C-S-<left> and <right>


;; recently used files
(require 'recentf)
(recentf-mode 1)
(global-set-key "\C-xf" 'recentf-open-files)




;; ibuffer to make ush list buffer less sux0rs
(defalias 'list-buffers 'ibuffer)

;; (require 'evil-paredit)
;; (defun override-default-evil-paredit ()
;;   (interactive)
;;   (define-key evil-normal-state-local-map "d" 'evil-paredit-delete)
;;   (define-key evil-normal-state-local-map "c" 'evil-paredit-change)
;;   (define-key evil-normal-state-local-map "y" 'evil-paredit-yank)
;;   (define-key evil-normal-state-local-map "D" 'evil-paredit-delete-line)
;;   (define-key evil-normal-state-local-map "C" 'evil-paredit-change-line)
;;   (define-key evil-normal-state-local-map "Y" 'evil-paredit-yank-line)
;;   (define-key evil-normal-state-local-map "X" 'paredit-backward-delete)
;;   (define-key evil-normal-state-local-map "x" 'paredit-forward-delete)
;;   (define-key evil-normal-state-map (kbd "M-.") 'nrepl-jump)
;;   (define-key evil-normal-state-map (kbd "M-,") 'nrepl-jump-back)
;;   (define-key evil-normal-state-local-map (kbd "M-<up>") 'paredit-splice-sexp-killing-backward)
;;   (define-key evil-normal-state-local-map (kbd "M-<down>") 'paredit-splice-sexp-killing-forward))

;; (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; (add-hook 'clojure-mode-hook
;;           #'(lambda ()
;;               (evil-mode 1)
;;               (override-default-evil-paredit)))


;; save backup files in a separate directory
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "617219c11282b84761477059b9339da78ce392c974d9308535ee4ec8c0770bee" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(speedbar-show-unknown-files t)
 '(tool-bar-mode nil))

(require 'smooth-scrolling)

;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (load-theme 'solarized-light t)
;; (load-theme 'wombat t)

;; (add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
;; (defun my-nrepl-mode-setup ()
;;   (require 'nrepl-ritz))


(require 'sws-mode)
(require 'stylus-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(add-to-list 'auto-mode-alist '("\\.cljx$" . clojure-mode))

(setenv "JVM_OPTS" "-Xmx8g")

(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc) (interactive)
  (text-scale-set 1)
  (kill-local-variable 'text-scale-mode-amount)
  (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
  (global-text-scale-mode 1))

(global-set-key (kbd "M-+")
                '(lambda () (interactive) (global-text-scale-adjust 1)))
(global-set-key (kbd "M--")
                '(lambda () (interactive) (global-text-scale-adjust -1)))

(setq-default fill-column 95)

(load-theme 'solarized-dark t)
;; (load-theme 'solarized-light t)

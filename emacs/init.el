;; This file is a mess

;; Packages
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" .
               "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; Disable backup file
(setq make-backup-files nil)

;; Autosave in .emacs.d/autosave
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; disable autosave
(setq auto-save-default nil)
(setq make-backup-files nil)


;; Highlight the current line
(global-hl-line-mode 0)


;; Change separator color
(set-face-attribute 'vertical-border
                    nil
                    :foreground "#073642")

;; Indent = 4 spaces
(setq standard-indent 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 1)


;; No backups
(setq make-backup-files nil)

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Enable backup files.
(setq-default fill-column 80)
(setq-default auto-fill-function 'do-auto-fill)

(setq initial-scratch-message "\n;; SCRATCH\n\n")

;; Modes

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring cd))

;; Easy moving between windows
(windmove-default-keybindings) ;; Bound to Shift

(require 'web-mode)
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-disable-css-colorization t)
)
(add-hook 'web-mode-hook  'web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.styl?\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; GO
(add-hook 'before-save-hook 'gofmt-before-save)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Lisp
(setq slime-contribs '(slime-fancy))
(show-paren-mode 1)
(setq inferior-lisp-program "/usr/bin/sbcl")

(global-set-key "\M- " 'hippie-expand)
;;(global-set-key [tab] 'tab-to-tab-stop)

;; C
(setq c-default-style "linux"
      c-basic-offset 4)

;; Org mode
(add-hook 'org-mode-hook (lambda ()
                           "Increase text size in org mode buffers"
                           (interactive)
                           (text-scale-set 1)))


;; setup files ending in “.js” to open in js2-mode
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; use web-mode instead
;; add globals
(setq js2-global-externs '("require" "module" "process"
                           "it" "expect" "describe" "window"))


;; wrap lines
(auto-fill-mode 1)
(set-fill-column 80)
(setq text-mode-hook 'turn-on-auto-fill)
(setq default-major-mode 'text-mode)

;; Scrolling
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Colors

;; Set emacs background colour

;; UI
;; Make the ui simpler
(tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(scroll-bar-mode 0)


;; Default font
;; Disable syntax highligthing
(add-to-list 'default-frame-alist '(font .  "-adobe-Source Code Pro-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1" ))
;(set-face-attribute  'default nil :font "-adobe-Source Code Pro-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")



;(add-to-list 'default-frame-alist '(font . "Droid Sans Mono-8"))
;(add-to-list 'default-frame-alist '(foreground-color . "#212121"))

;; Syntax
(global-font-lock-mode 1)


(setq-default left-margin-width 1 right-margin-width 1) ; Define new widths.

;; Disable prompts
(fset 'yes-or-no-p 'y-or-n-p)
(ido-mode 1)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

(setq ido-enable-flex-matching t)

;; Hide splash screen
(setq inhibit-startup-message t)

(defun my-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq tab-stop-list (my-generate-tab-stops))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(mode-line ((t (:box nil
                       :underline nil
                       :overline nil
                       :foreground "#002b36"
                       :background "gold"
                       :font "Terminus-8"
                       ))))

 '(mode-line-inactive ((t (:box nil
                                :foreground "#333"
                                :background "#ccc"
                                :font "Terminus-8"
                                :underline nil
                                :overline nil))))

 '(mode-line-buffer-id ((t (:foreground "#002b36"))))


 '(mode-line-highlight ((t (:box nil
                                 :foreground "gray"
                                 :background "#073642"
                                 :overline nil))))


 )

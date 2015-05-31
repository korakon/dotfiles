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

;; Indent = 4 spaces
(setq standard-indent 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 1)

(setq scroll-step 1)

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
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-disable-css-colorization t)
)
(add-hook 'web-mode-hook  'web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.styl?\\'" . css-mode))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Editing

;; GO

(add-hook 'before-save-hook 'gofmt-before-save)

;; Haskell

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(show-paren-mode 1)

(global-set-key "\M- " 'hippie-expand)
;;(global-set-key [tab] 'tab-to-tab-stop)

(setq c-default-style "linux"
      c-basic-offset 4)

;; setup files ending in “.js” to open in js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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

;; Set emacs background colour/

;; UI
;; Make the ui simpler
(tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(scroll-bar-mode 0)

(set-background-color "white")

;; Default font
;;(set-face-attribute  'default nil :font "Droid Sans Mono-8")

(add-to-list 'default-frame-alist '(font . "Droid Sans Mono-8"))
(add-to-list 'default-frame-alist '(foreground-color . "#212121"))

;; Syntax
;; Disable syntax highligthing
(global-font-lock-mode 1)

;; Modeline
;; Hide it completly
;;(setq-default mode-line-format nil)


;; Remove vertical border
(set-face-attribute 'vertical-border
                    nil
                    :foreground "#cccccc")

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

;; Sort lines by length


;; Hide splash screen
(setq inhibit-startup-message t)
(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-auto-raise t)
 '(minibuffer-prompt-properties (quote (read-only t face minibuffer-prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:foreground "retrogreen" :height 1.0 :family "Terminus"))))
 '(mode-line ((t (:background "#38A876" :foreground "white" :box nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "xos4" :family "Terminus"))))
 '(mode-line-highlight ((t (:background "gray32" :foreground "white"))))
 '(mode-line-inactive ((t (:background "gray" :foreground "dim gray" :weight light))))
 '(modeline-inactive ((t (:background "gainsboro" :foreground "dim gray" :weight light :family "Terminus"))) t))

;(set-face-attribute 'mode-line nil
;   :foreground "white"
;    :background "#38A876"
;    :overline nil
;    :box nil
;    ;;:font "Terminus-9"
;    :underline nil)


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

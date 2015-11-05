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
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Backups
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Autosave in .emacs.d/autosave
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Instant access to init file

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-<f1>") 'find-user-init-file)

;; disable autosave
(setq auto-save-default nil)
(setq make-backup-files nil)

;; time display mode
(display-time-mode 1)

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
;; (setq make-backup-files nil)

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Enable backup files.
(setq-default fill-column 80)
(setq-default auto-fill-function 'do-auto-fill)

(setq initial-scratch-message "\n;; SCRATCH\n\n")

;; Modes

;; History
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring
                                                cd))
(setq savehist-save-minibuffer-history 1)

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

;; C
(setq c-default-style "linux"
      c-basic-offset 4)

;; Org mode
;; Add now.org file to the agenda files
(setq org-directory "~/org/")
(setq org-agenda-files (list (concat org-directory "now.org")))
(setq org-default-notes-file (concat org-directory "now.org"))
(setq org-refile-targets '((nil :maxlevel . 4)))

;; Todos
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; Clocking
(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)
(setq org-clock-persist 'history)
(setq org-clock-in-switch-to-state "STARTED")
(setq org-show-notification-handler 'message)
(setq org-clock-report-include-clocking-task t)
(org-clock-persistence-insinuate)

;; Org-habits
(setq org-habit-show-habits-only-for-today nil)

;; Org modules
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "C-<f12>") '(lambda ()
                                 (interactive)
                                 (find-file "~/org/now.org")))
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-completion-use-ido t)
(setq org-hide-leading-starts t)
;(setq org-log-done 'time)
(setq org-log-done 'note)
(setq org-refile-use-outline-path t)
(setq org-use-speed-commands t)

;; Don't inherit :project: tag
(setq org-tags-exclude-from-inheritance '("project"))

;; Org tags
(setq org-tag-alist '(("practice" . ?p)
                      ("yoga" . ?y)
                      ("writing" . ?w)
                      ("drawing" . ?d)
                      ("coding" . ?c)
                      ("reading" . ?r)))


;; TODO: move those to ~/org/templates/

(defvar korakon/org-task-template "* TODO %?
  :PROPERTIES:
  :Creation-Time: %U
  :END:
")

(defvar korakon/org-journal-template "* %?
  :PROPERTIES:
  :Creation-Time: %U
  :END:
")

(defvar korakon/org-dream-template "* STARTED %^{Title}
  %?
  :LOGBOOK:
  :END:
  :PROPERTIES:
  :Creation-Time: %U
  :END:
")

(setq org-capture-templates
      `(("t" "Todo" entry (file+headline "~/org/now.org" "Tasks")
         ,korakon/org-task-template)

        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         ,korakon/org-journal-template :clock-in t :clock-resume t)

        ("d" "Dream" entry (file+datetree "~/org/dream.org")
         ,korakon/org-dream-template :clock-in t :clock-resume t)))


(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "STARTED(s)" "NEXT(n!)" "|" "DONE(d!)" "CANCELLED(c@)"))))

(setq org-todo-keyword-faces
      (quote (
              ("TODO" :foreground "#dc322f" :weight bold)
              ("STARTED" :foreground "#d33682" :weight bold)
              ("NEXT" :foreground "#2aa198" :weight bold)
              ("DONE" :foreground "#859900" :weight bold)
              ("CANCELLED" :foreground "#b58900" :weight bold))))

(defun korakon/org-clock-in-if-starting ()
  "Clock in when the task is marked STARTED."
  (when (and (string= org-state "STARTED")
             (not (string= org-last-state org-state)))
    (org-clock-in)))

(defun korakon/org-change-state-to-done-if-clock-out ()
  "Prompt the user to change state after clock-out"
  (org-todo))

(add-hook 'org-clock-out-hook
          'korakon/org-change-state-to-done-if-clock-out)

(add-hook 'org-after-todo-state-change-hook
          'korakon/org-clock-in-if-starting)


;; Ace jumb
(global-set-key (kbd "H-j") 'ace-jump-mode)

;; setup files ending in “.js” to open in js2-mode
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; use web-mode instead
;; add globals
(setq js2-global-externs '("require" "module" "process"
                           "it" "expect" "describe" "window"))
;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

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
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))
;; Ido
(ido-mode 1)
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
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(org-agenda-files (quote ("~/org/now.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:box nil :underline nil :overline nil :foreground "#002b36" :background "gold" :font "Terminus-8"))))
 '(mode-line-buffer-id ((t (:foreground "#002b36"))))
 '(mode-line-highlight ((t (:box nil :foreground "gray" :background "#073642" :overline nil))))
 '(mode-line-inactive ((t (:box nil :foreground "#333" :background "#ccc" :font "Terminus-8" :underline nil :overline nil)))))

;;; init.el --- Main emacs config file

;;; Commentary:

;; The multiple declare-function and defvars are not really needed,
;; but used to avoid byte-compile warnings.

;;; Code:

;; Package repositories:
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)
(setq-default solarized-termcolors 256)
(setq-default solarized-contrast 'high)
(setq-default solarized-visibility 'high)
(set-frame-parameter nil 'background-mode 'light)
(set-terminal-parameter nil 'background-mode 'light)

;; List of sensible defaults
(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/backup-to-temp-directory)
(declare-function sensible-defaults/use-all-settings sensible-defaults)
(declare-function sensible-defaults/backup-to-temp-directory sensible-defaults)

;; Launches session server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Set default font
(set-frame-font "Roboto Mono-10")

;; Move customize interface to another file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Help window selected when open
(setq help-window-select t)

;; Save last position
(save-place-mode)

;; Save command history
(savehist-mode)

;; Disable gui
(defun my-frame-behaviours-gui (&optional frame)
  "Make FRAME and/or terminal local change for gui elements."
  (with-selected-frame (or frame (selected-frame))
    (menu-bar-mode -1)
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)))
(declare-function my-frame-behaviours-gui init.el)
(my-frame-behaviours-gui)
(add-hook 'after-make-frame-functions 'my-frame-behaviours-gui)

;; Use xclip to copy/paste in emacs-nox
(unless window-system
  (when (getenv "DISPLAY")
    (defun xclip-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region
	 (point-min) (point-max)
	 "xclip" nil 0 nil "-i" "-selection" "clipboard")))
    (defun xclip-paste-function()
      (let ((xclip-output
	     (shell-command-to-string "xclip -o -selection clipboard")))
        (unless (string= (car kill-ring) xclip-output)
          xclip-output )))
    (setq interprogram-cut-function 'xclip-cut-function)
    (setq interprogram-paste-function 'xclip-paste-function)))

;; Xterm mouse support
(require 'mouse)
(xterm-mouse-mode t)

;; Smooth scrolling:
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

;; Open files as root:
(require 'tramp)
(setq tramp-default-method "scp")

;; Remap return with auto-indent
(add-hook 'lisp-mode-hook '(lambda ()
			    (local-set-key (kbd "RET") 'newline-and-indent)))

;; Nice auto indenation
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Load use-package at start
(eval-when-compile
  (require 'use-package))

;; Load packages:

(use-package auto-indent-mode
  :ensure t
  :config
  (auto-indent-global-mode)
  (declare-function auto-indent-global-mode auto-indent-mode))

(use-package all-the-icons
  :ensure t)

(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package cdlatex
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex))

(use-package centered-cursor-mode
  :ensure t
  :config
  (global-centered-cursor-mode)
  (declare-function global-centered-cursor-mode centered-cursor-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  ;; Add yasnippet support for all company backends
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (declare-function company-mode/backend-with-yas company)
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas)
	    (and (listp backend) (member 'company-yasnippet backend)))
	backend
      (append (if (consp backend) backend (list backend))
	      '(:with company-yasnippet))))
  (setq company-backends
	(mapcar #'company-mode/backend-with-yas company-backends)))

(use-package company-auctex
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'company-auctex-init))

(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda ()
			     (tern-mode)
			     (company-mode)))
  ;; disable completion keybindings, as we use xref-js2 instead
  (defvar tern-mode-keymap)
  (define-key tern-mode-keymap (kbd "M-.") nil)
  (define-key tern-mode-keymap (kbd "M-,") nil))

(use-package dim
  :ensure t)

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (declare-function evil-delay evil)
  (defun my-frame-behaviours-cursor (&optional frame)
    "Make FRAME and/or terminal local change for evil cursors."
    (with-selected-frame (or frame (selected-frame))
      (when (display-graphic-p frame)
	(setq evil-emacs-state-cursor '("#dc322f" box))
	(setq evil-motion-state-cursor '("#cb4b16" box))
	(setq evil-normal-state-cursor '("#2aa198" box))
	(setq evil-visual-state-cursor '("#cb4b16" box))
	(setq evil-insert-state-cursor '("#dc322f" (bar . 2 )))
	(setq evil-replace-state-cursor '("#dc322f" hbar))
	(setq evil-operator-state-cursor '("#dc322f" hollow)))
      (unless (display-graphic-p frame)
	(setq evil-emacs-state-cursor '("red" box))
	(setq evil-motion-state-cursor '("brightred" box))
	(setq evil-normal-state-cursor '("cyan" box))
	(setq evil-visual-state-cursor '("brightred" box))
	(setq evil-insert-state-cursor '("red" (bar . 2 )))
	(setq evil-replace-state-cursor '("red" hbar))
	(setq evil-operator-state-cursor '("red" hollow)))))
  (declare-function my-frame-behaviours-cursor init.el)
  (my-frame-behaviours-cursor)
  (add-hook 'after-make-frame-functions 'my-frame-behaviours-cursor)
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)

  ;; Buffer and window navigation with evil bindings
  (define-key evil-normal-state-map (kbd "C-j") 'next-buffer)
  (define-key evil-normal-state-map (kbd "C-k") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "C-S-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-S-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-S-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-S-l") 'evil-window-right)

  ;; Esc quits everything
  (defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
	(setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

  ;; Fold using hideshow
  (add-hook 'prog-mode-hook #'hs-minor-mode)
  (defun toggle-fold ()
    (interactive)
    (save-excursion
      (end-of-line)
      (hs-toggle-hiding)))
  (declare-function hs-toggle-hiding hideshow)
  (add-to-list 'evil-fold-list
	'((hs-minor-mode)
	  :open-all hs-show-all
	  :close-all hs-hide-all
	  :toggle toggle-fold
	  :open hs-show-block
	  :open-rec nil
	  :close hs-hide-block)))

(use-package evil-ediff
  :ensure t)

(use-package evil-leader
  :ensure t
  :requires evil
  :config
  (global-evil-leader-mode)
  (declare-function evil-leader/set-leader evil-leader)
  (evil-leader/set-leader ",")

  ;; Describe object behind point
  (defun describe-foo-at-point ()
    "Show the documentation of the Elisp function and variable near point.
  This checks in turn:
  -- for a function name where point is
  -- for a variable name where point is
  -- for a surrounding function call"
    (interactive)
    (declare-function function-at-point thingatpt)
    (let (sym)
      ;; sigh, function-at-point is too clever.	 we want only the first half.
      (cond ((setq sym (ignore-errors
			 (with-syntax-table emacs-lisp-mode-syntax-table
			   (save-excursion
			     (or (not (zerop (skip-syntax-backward "_w")))
				 (eq (char-syntax (char-after (point))) ?w)
				 (eq (char-syntax (char-after (point))) ?_)
				 (forward-sexp -1))
			     (skip-chars-forward "`'")
			     (let ((obj (read (current-buffer))))
			       (and (symbolp obj) (fboundp obj) obj))))))
	     (describe-function sym))
	    ((setq sym (variable-at-point)) (describe-variable sym))
	    ((setq sym (function-at-point)) (describe-function sym)))));
  (evil-leader/set-key-for-mode 'emacs-lisp-mode "h" 'describe-foo-at-point))

(use-package evil-magit
  :ensure t)

(use-package evil-surround
  :ensure t
  :requires evil
  :config
  (global-evil-surround-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (setq-default flycheck-temp-prefix ".flycheck")
  ;; Javascript
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (declare-function flycheck-add-mode flycheck)
  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
	(let ((web-mode-enable-part-face nil))
	  ad-do-it)
      ad-do-it))
  ;; Markdown
  (add-to-ordered-list 'flycheck-checkers 'markdown-markdownlint-cli 0)
  (setq flycheck-markdown-markdownlint-cli-config ".markdownlintrc"))

(use-package flycheck-color-mode-line
  :ensure t
  :config
  (eval-after-load "flycheck"
    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (set-face-attribute 'flycheck-color-mode-line-error-face nil
		      :foreground "#dc322f"
		      :background "#fdf6e3")
  (set-face-attribute 'flycheck-color-mode-line-warning-face nil
		      :foreground "#b58900"
		      :background "#fdf6e3")
  (set-face-attribute 'flycheck-color-mode-line-info-face nil
		      :foreground "#6c71c4"
		      :background "#fdf6e3")
  (set-face-attribute 'flycheck-color-mode-line-success-face nil
		      :foreground "#2aa198"
		      :background "#fdf6e3")
  (set-face-attribute 'flycheck-color-mode-line-running-face nil
		      :inherit nil))

(use-package fontawesome
  :ensure t)

(use-package ivy
  :ensure t)

(use-package js-comint
  :ensure t
  :config
  (defun inferior-js-mode-hook-setup ()
    (add-hook 'comint-output-filter-functions 'js-comint-process-output))
  (add-hook 'inferior-js-mode-hook 'inferior-js-mode-hook-setup t)
  (add-hook 'js2-mode-hook
	    (lambda ()
	      (local-set-key (kbd "C-x C-e") 'js-send-last-sexp)
	      (local-set-key (kbd "C-M-x") 'js-send-last-sexp-and-go)
	      (local-set-key (kbd "C-c b") 'js-send-buffer)
	      (local-set-key (kbd "C-c C-b") 'js-send-buffer-and-go)
	      (local-set-key (kbd "C-c l") 'js-load-file-and-go))))

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  ;; better imenu
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode))

(use-package js2-refactor
  :ensure t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
  (declare-function js2r-kill js2-refactor))

(use-package json-mode
  :ensure t
  :config
  (defvar json-mode-indent-level)
  (add-hook 'json-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil)
	      (setq json-mode-indent-level 4))))

(use-package latex-pretty-symbols
  :ensure t)

(use-package linum
  :disabled
  :ensure t
  :config
  (global-linum-mode 1)
  (set-face-attribute 'linum nil
		      :background (face-attribute 'default :background)
		      :foreground (face-attribute 'font-lock-comment-face
						  :foreground))
  (defun my-frame-behaviours-linum (&optional frame)
    "Make FRAME and/or terminal local change for linum."
    (with-selected-frame (or frame (selected-frame))
      (defface linum-current-line-face
	(if (display-graphic-p frame)
	    (progn '((t :background "#93a1a1" :foreground "#fdf6e3")))
	  '((t :background "brightcyan" :foreground "brightwhite")))
	"Face for the currently active Line number"
	:group 'basic-faces)))
  (declare-function my-frame-behaviours-linum init.el)
  (my-frame-behaviours-linum)
  (add-hook 'after-make-frame-functions 'my-frame-behaviours-linum)
  (defvar my-linum-format-string)
  (defvar my-linum-current-line-number 0)
  (defun get-linum-format-string ()
    (setq-local my-linum-format-string
		(let ((w (length (number-to-string
				  (count-lines (point-min) (point-max))))))
		  (concat " %" (number-to-string w) "d "))))
  (add-hook 'linum-before-numbering-hook 'get-linum-format-string)
  (defun my-linum-format (line-number)
    (propertize (format my-linum-format-string line-number) 'face
		(if (eq line-number my-linum-current-line-number)
		    'linum-current-line-face
		  'linum)))
  (setq linum-format 'my-linum-format)
  (defadvice linum-update (around my-linum-update)
    (let ((my-linum-current-line-number (line-number-at-pos)))
      ad-do-it))
  (ad-activate 'linum-update))

(use-package magit
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :config
  (add-hook 'markdown-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil)
	      (turn-on-auto-fill))))

(use-package neotree
  :ensure t
  :config
  (setq neo-smart-open t)
  (when (require 'evil nil 'noerror)
    (evil-leader/set-key
      "m"  'neotree-toggle
      "n"  'neotree-project-dir))
  (declare-function neo-global--window-exists-p neotree)
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
	  (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
	  (if (neo-global--window-exists-p)
	      (progn
		(neotree-dir project-dir) (neotree-find file-name))
	    (message "Could not find git project root.")))))
  (defvar projectile-switch-project-action)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (defun my-frame-behaviours-neoface (&optional frame)
    "Make FRAME and/or terminal-local change for neoface."
    (with-selected-frame (or frame (selected-frame))
      (setq neo-theme (if (display-graphic-p frame) 'icons 'nerd))))
  (declare-function my-frame-behaviours-neoface init.el)
  (my-frame-behaviours-neoface)
  (add-hook 'after-make-frame-functions 'my-frame-behaviours-neoface)
  (when (require 'evil nil 'noerror)
    (add-hook 'neotree-mode-hook
	      (lambda ()
		(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
		(define-key evil-normal-state-local-map (kbd "I")
		  'neotree-hidden-file-toggle)
		(define-key evil-normal-state-local-map (kbd "z")
		  'neotree-stretch-toggle)
		(define-key evil-normal-state-local-map (kbd "r")
		  'neotree-refresh)
		(define-key evil-normal-state-local-map (kbd "R")
		  'neotree-change-root)
		(define-key evil-normal-state-local-map (kbd "m")
		  'neotree-rename-node)
		(define-key evil-normal-state-local-map (kbd "c")
		  'neotree-create-node)
		(define-key evil-normal-state-local-map (kbd "d")
		  'neotree-delete-node)
		(define-key evil-normal-state-local-map (kbd "s")
		  'neotree-enter-vertical-split)
		(define-key evil-normal-state-local-map (kbd "S")
		  'neotree-enter-horizontal-split)
		(define-key evil-normal-state-local-map (kbd "RET")
		  'neotree-enter)))))

(use-package org-journal
  :ensure t
  :config
  (defun my-open-journal-main ()
    "Open main journal location using org-journal.el"
    (interactive)
    (setq org-journal-dir "~/journal/")
    (org-journal-new-entry nil))
  (defun my-open-journal-nape ()
    "Open main journal location using org-journal.el"
    (interactive)
    (setq org-journal-dir "~/nape/journal/")
    (org-journal-new-entry nil))
  (when (require 'evil nil 'noerror)
    (evil-leader/set-key
      "jj" 'my-open-journal-main
      "jn" 'my-open-journal-nape)))

(use-package powerline
  :ensure t)

(use-package powerline-evil
  :ensure t
  :requires powerline
  :config
  (setq-default mode-line-format
        '("%e"
          (:eval
	   (let* ((active (powerline-selected-window-active))
                  (mode-line (if active 'mode-line 'mode-line-inactive))
                  (face0 (if active 'powerline-active0 'powerline-inactive0))
                  (face1 (if active 'powerline-active1 'powerline-inactive1))
                  (face2 (if active 'powerline-active2 'powerline-inactive2))
                  (separator-left (intern (format "powerline-%s-%s"
						  (setq powerline-current-separator 'nil)
                                    (car powerline-default-separator-dir))))
                  (separator-right (intern (format "powerline-%s-%s"
                                     (setq powerline-current-separator 'nil)
                                     (cdr powerline-default-separator-dir))))
                  (lhs (list (powerline-raw " " mode-line)
			     (powerline-raw "%*" mode-line)
			     (powerline-buffer-id
			      `(mode-line-buffer-id, mode-line))
			     (when (and (boundp 'which-func-mode)
					which-func-mode)
			       (powerline-raw which-func-format mode-line))
			     (powerline-vc face0)
			     (powerline-raw " " face0)
			     (powerline-major-mode face2 'l)
			     (powerline-process face2)
			     (powerline-raw " " face2)))
                  (rhs (list (powerline-raw global-mode-string face2 'r)
			     (powerline-raw " " face2)
                             (powerline-raw "%l:%c" face2)
			     (powerline-raw " " face2)
                             (funcall separator-right face2 face0)
                             (powerline-raw " " face0)
                             (powerline-raw "%9p" face0 'r)))
		  (center (list (funcall separator-left face2 face1)
				(powerline-minor-modes face1 'l)
				(powerline-raw " " face1)
				(funcall separator-right face1 face2))))
             (concat (powerline-render lhs)
		     (if (> (window-width)
			    (+ (powerline-width lhs)
			       (powerline-width rhs)
			       (powerline-width center)))
		       (powerline-render center))
                     (powerline-fill face1 (powerline-width rhs))
                     (powerline-render rhs)))))))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (declare-function projectile-project-root projectile))

(use-package quickrun
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :config
  (outline-minor-mode nil))

(use-package rainbow-mode
  :ensure t
  :config
  (rainbow-mode))

(use-package spaceline
  :ensure t)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (declare-function global-undo-tree-mode undo-tree))

(use-package whitespace
  :ensure t
  :config
  (global-whitespace-mode t)
  (setq whitespace-style
	'(face empty tabs lines-tail space-before-tabs trailing))
  (dolist (face '(whitespace-space
		  whitespace-space-before-tab
		  whitespace-empty
		  whitespace-trailing))
    (set-face-attribute face
			nil :background "#white" :foreground "#white")))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode)))

(use-package xref-js2
  :ensure t
  :config
  (define-key js-mode-map (kbd "M-.") nil)
  (add-hook 'js2-mode-hook (lambda () (add-hook 'xref-backend-functions
				       #'xref-js2-xref-backend nil t))))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (declare-function yas-global-mode yasnippet)
  ;; Some evil bindings
  (when (require 'evil nil 'noerror)
    (evil-leader/set-key "yt" 'yas-describe-tables)))

(use-package yasnippet-snippets
  :ensure t
  :requires yasnippet)

;; Latex configuration
(load "auctex.el" nil t t)
(require 'tex-mik)
(require 'reftex)
(require 'tex)
(require 'tex-buf)
(add-hook 'LaTex-mode-hook
	  (lambda ()
	    (visual-line-mode)
	    (turn-on-reftex)
	    (turn-on-cdlatex)
	    (flyspell-mode)
	    (flyspell-buffer)
	    (TeX-fold-mode 1)))
(defvar tex-tree-roots)
(defvar ispell-program-name)
(defvar ispell-dictionary)
(defvar LaTeX-section-hook)
(defvar reftex-plug-into-AUCTeX)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq TeX-newline-function 'reindent-then-newline-and-indent)
(setq reftex-plug-into-AUCTeX t)
(setq LaTeX-item-indent 0)
(setq LaTeX-command-section-level t)
(setq TeX-clean-confirm nil)
(setq tex-tree-roots t)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")
(custom-set-variables
 '(TeX-view-program-list (quote (("Zathura" "zathura %o"))))
 '(TeX-view-program-selection
  (quote
   (((output-dvi style-pstricks) "dvips and gv")
   (output-dvi "xdvi")
   (output-pdf "Zathura")
   (output-html "xdg-open")))))
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
(define-key cdlatex-mode-map "\C-c?" nil)

(provide 'init)
;;; init.el ends here

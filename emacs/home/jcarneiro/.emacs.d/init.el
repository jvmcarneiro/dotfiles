;;; init.el --- Main emacs config file

;;; Commentary:

;; The multiple declare-function are not really needed
;; but used to avoid byte-compile warnings

;;; Code:

;; Package repositories:

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'light)
(set-terminal-parameter nil 'background-mode 'light)

;; List of sensible defaults
(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/backup-to-temp-directory)
(declare-function sensible-defaults/use-all-settings sensible-defaults)
(declare-function sensible-defaults/backup-to-temp-directory sensible-defaults)

;; Disable gui
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Load use-package at start
(eval-when-compile
  (require 'use-package))
;; Load packages
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (declare-function evil-delay evil))

(use-package evil-leader
  :ensure t
  :requires evil
  :config
  (global-evil-leader-mode)
  (declare-function evil-leader/set-leader evil-leader))

(use-package evil-surround
  :ensure t
  :requires evil
  :config
  (global-evil-surround-mode))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (declare-function global-undo-tree-mode undo-tree)
  (setq undo-tree-auto-save-history t))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (declare-function projectile-project-root projectile))

(use-package neotree
  :ensure t
  :config
  (evil-leader/set-key
    "m"  'neotree-toggle
    "n"  'neotree-project-dir)
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
                (neotree-dir project-dir)
                (neotree-find file-name))
            (message "Could not find git project root.")))))
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "I")
                'neotree-hidden-file-toggle)
              (define-key evil-normal-state-local-map (kbd "z")
                'neotree-stretch-toggle)
              (define-key evil-normal-state-local-map (kbd "R")
                'neotree-refresh)
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
                'neotree-enter))))

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :config
  (outline-minor-mode t)
  (outline-minor-mode nil))

(use-package whitespace
  :ensure t
  :config
  (global-whitespace-mode t)
  (setq whitespace-style '(face empty lines-tail space-before-tabs trailing)))

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml))

(use-package guess-style
  :load-path "~/.emacs.d/guess-style/"
  :init
  (add-hook 'prog-mode-hook 'guess-style-guess-all))

(use-package linum
  :ensure t
  :config
  (global-linum-mode 1)
  (set-face-attribute 'linum nil
		      :background (face-attribute 'default :background)
		      :foreground (face-attribute 'font-lock-comment-face
						  :foreground))
  (defface linum-current-line-face
    `((t :background "#93a1a1" :foreground "#fdf6e3"))
    "Face for the currently active Line number"
    :group 'basic-faces)
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

(use-package rainbow-mode
  :ensure t
  :config
  (rainbow-mode))

(use-package cdlatex
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex))

(use-package company-auctex
  :ensure t
  :config
  (company-auctex-init))

(use-package latex-pretty-symbols
  :ensure t)

;; Set default font
(set-frame-font "Roboto Mono-10")

;; Set new evil <leader>
(evil-leader/set-leader ",")

;; Add evil movements to occur-mode
(add-hook 'occur-mode-hook
          (lambda()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              (kbd "C-d")     'evil-scroll-down
              (kbd "C-u")     'evil-scroll-up
              (kbd "C-w C-w") 'other-window)))

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
    ;; sigh, function-at-point is too clever.  we want only the first half.
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
          ;; now let it operate fully -- i.e. also check the
          ;; surrounding sexp for a function call.
          ((setq sym (function-at-point)) (describe-function sym)))));
(define-key emacs-lisp-mode-map [(f1)] 'describe-foo-at-point)
(define-key emacs-lisp-mode-map [(control f1)] 'describe-function)
(define-key emacs-lisp-mode-map [(shift f1)] 'describe-variable)

;; Move customize interface to another file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Help window selected when open
(setq help-window-select t)

;; Save last position
(save-place-mode)

;; Save command history
(savehist-mode)

;; Latex configuration
(load "auctex.el" nil t t)
(require 'tex-mik)
(require 'reftex)
(require 'tex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-newline-function 'reindent-then-newline-and-indent)
(setq reftex-plug-into-AUCTeX t)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")
(setq LaTeX-section-hook
      '(LaTeX-section-heading
	LaTeX-section-title
	LaTeX-section-toc
	LaTeX-section-section
	LaTeX-section-label))
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(TeX-global-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)


(provide 'init)
;;; init.el ends here

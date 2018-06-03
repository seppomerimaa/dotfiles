(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d6bc59c56cd8a41c8d9a848fd1c5c5746423c428b677fd6387681789721fe7d8" "83db918b06f0b1df1153f21c0d47250556c7ffb5b5e6906d21749f41737babb7" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8bb8a5b27776c39b3c7bf9da1e711ac794e4dc9d43e32a075d8aa72d6b5b3f59" "d36e851fab767ad68cdabbae5784dbe88d090b011dd721eee8e527e21f5422af" default)))
 '(package-selected-packages
   (quote
    (adaptive-wrap visual-fill-column ace-popup-menu flycheck-rust racer company-mode exec-path-from-shell cargo elpy paredit rainbow-delimiters cider clojure-mode helm-ag rust-mode sourcerer-theme arjen-grey-theme solarized-theme org-bullets helm-projectile projectile auctex intero magit markdown-mode neotree neo-tree ensime scala-mode helm use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Get use-package package (!?) ready to...
;; uh...use? Yay.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; File backup settings ... or rather, lack thereof. YOLO
;; from https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq make-backup-files nil
      ;;backup-directory-alist '(("." "~/.emacs-backups"))
      ;;kept-new-versions 2
      ;;kept-old-versions 2
      ;;version-control t
      ;;delete-old-versions t
      )

;; Maximize emacs on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Add /usr/local/bin to path so that we can get homebrew stuffs easily
(setq exec-path (append exec-path '("/usr/local/bin")))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Set up a full-height window on the left, and a bar on the right with a tall window
;; and a short window below it with eshell opened in the short one.
(defun setup-windows ()
  ; Need interactive so that you can bind it to a key chord
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (split-window-below -20)
  (other-window 1)
  (eshell)
  (other-window 1))
(global-set-key (kbd "C-c w") 'setup-windows)
;; wants to run command on setup but doesn't happen before the resize :-/
;;(add-hook 'window-setup-hook 'setup-windows)

(global-visual-line-mode 1)
(setq fill-column 100)
;; Wrap at fill-column or window edge without modifying underlying text.
(use-package visual-fill-column
  :ensure t
  :config
  (add-hook 'visual-line-mode-hook #'visual-fill-column-mode))
;; Keep indent levels across wraps without modifying underlying text.
(use-package adaptive-wrap
  :ensure t
  :config
  (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode))

(use-package evil
  :ensure t
  :config
  (evil-mode t)
  (setq sentence-end-double-space nil)
  (evil-set-initial-state 'repl-mode 'emacs)
  (evil-set-initial-state 'cider-repl-mode 'emacs)
  (evil-set-initial-state 'cider-stacktrace-mode 'emacs))



(use-package neotree
  :ensure t
  :config
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  ;; These only work in normal mode for now...maybe remove that?
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


(use-package magit
  :ensure t
  :config
  (require 'magit)
  (global-set-key (kbd "C-x g") 'magit-status))


;; Scala stuffs
(use-package ensime
  :ensure t
  :pin melpa-stable)
(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq scala-indent:use-javadoc-style t))


;; Haskell stuffs
(use-package intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))


;; Rust Rust Rust
(use-package rust-mode
  :ensure t)
(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))
(use-package racer
  :ensure t
  :config
  (setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
  (setq racer-rust-src-path "/Users/McFly/workspace/lang/rust/src") ;; Rust source code PATH

  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))
(use-package flycheck-rust
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Clojure
(use-package clojure-mode
  :ensure t)
(use-package cider
  :ensure t)
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

(use-package paredit
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'paredit-mode))


;; Python
;; NB this requires some pip-installed things to work right.
;; M-x elpy-config to see which dependencies are missing.
(use-package elpy
  :ensure t
  :commands elpy-enable
  :config
  (setq elpy-rpc-python-command "python3"))

;; Text
(setenv "DICTIONARY" "en_US2")
(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(markdown-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
;; Got en_US.dic and en_US.dic from https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en
;; Put them in ~/Library/Spelling
;; brew install hunspell
;; Check OK with `hunspell -D`
;; Now make ispell use hunspell
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))
(use-package ace-popup-menu
  :ensure t
  :config
  (ace-popup-menu-mode 1))

(load "~/.emacs.d/init/orgmode.el")
(load "~/.emacs.d/init/search.el")
;;(load "~/.emacs.d/init/latex.el")

;; Custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(use-package solarized-theme
  :ensure t)
(use-package arjen-grey-theme
  :ensure t)
(use-package sourcerer-theme
  :ensure t)
(load-theme 'acme)

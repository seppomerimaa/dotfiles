(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
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
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8bb8a5b27776c39b3c7bf9da1e711ac794e4dc9d43e32a075d8aa72d6b5b3f59" "d36e851fab767ad68cdabbae5784dbe88d090b011dd721eee8e527e21f5422af" default)))
 '(package-selected-packages
   (quote
    (sourcerer-theme arjen-grey-theme solarized-theme org-bullets helm-projectile projectile auctex intero magit markdown-mode neotree neo-tree ensime scala-mode helm use-package evil-visual-mark-mode))))
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


(use-package evil
  :ensure t
  :config
  (evil-mode t))



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



(load "~/.emacs.d/init/orgmode.el")
(load "~/.emacs.d/init/search.el")
(load "~/.emacs.d/init/latex.el")

;; Custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(use-package solarized-theme
  :ensure t)
(use-package arjen-grey-theme
  :ensure t)
(use-package sourcerer-theme
  :ensure t)
(load-theme 'solarized-light t)

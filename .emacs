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


(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (helm-mode 1))
;; Use helm for finding files and M-x
;; instead of the defaults
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)


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


;; Helm + Projectile
(use-package projectile
  :ensure t)
(use-package helm-projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))


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


;; Latex
(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq Tex-parse-self t)
  (setq TeX-save-query nil)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; macros for creating references
  (setq reftex-plug-into-AUCTeX t) 
  (setq Tex-PDF-mode t) ; automatically compile to PDF
  (add-hook 'LaTeX-mode-hook 'flyspell-mode); Enable Flyspell mode for TeX modes such as AUCTeX. Highlights all misspelled words.
  (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode); Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
  (setq ispell-dictionary "english"); Default dictionary. To change do M-x ispell-change-dictionary RET.
  ;; tip: if you get an error about no such file or directory ispell do `brew install ispell`
  )

;; Orgmode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/Dropbox/org/"))
;; theoretically restore window state after quitting agenda...
(setq org-agenda-restore-windows-after-quit t)
;; Prettier bullets for lists. Can customize bullet chars if you like.
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(use-package solarized-theme
  :ensure t)
(use-package arjen-grey-theme
  :ensure t)
(use-package sourcerer-theme
  :ensure t)
(load-theme 'sourcerer t)

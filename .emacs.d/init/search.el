;; helm and projectile configs for better searching / finding

(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (helm-mode 1))

;; Use helm for finding files and M-x
;; instead of the defaults
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(use-package projectile
  :ensure t)

(use-package helm-projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

;; Hack around https://github.com/bbatsov/projectile/issues/1183
(setq projectile-mode-line
      '(:eval (format " Projectile[%s]"
		      (projectile-project-name))))

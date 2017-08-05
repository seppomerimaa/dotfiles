;; Orgmode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/Dropbox/org/"))
(setq org-agenda-show-all-dates t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)

;; Define the different states that a task can be in. "|" separates the done state from everything else.
;; (t) etc. are for fast selection -- C-c C-t will prompt for a keycode instead of cycling.
;; Use C-u C-c C-t to cycle instead.
;; NB: for some reason you have to restart emacs (to restart orgmode?) to get changes here to take effect :-\
(setq org-todo-keywords '((sequence "TODO(t)" "CANCELLED(x)" "|" "DONE(d)" )))

;; Set up agenda range so that it's always -3 days to + 7 days relative to now
(setq org-agenda-start-day "-3d")
(setq org-agenda-span 10)
(setq org-agenda-start-on-weekday nil)

;; Wrap lines
;; (setq org-startup-truncated nil)
;; theoretically restore window state after quitting agenda...
(setq org-agenda-restore-windows-after-quit t)
;; Prettier bullets for lists. Can customize bullet chars if you like.
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;; org-capture configs
(define-key global-map "\C-cc" 'org-capture)
(setq org-default-notes-file "~/Dropbox/org/captures.org")
;; See the org-capture-templates documentation for help deciphering the templates
(setq org-capture-templates
      (quote
       ;; Capture links using 2 prompts and then optional tags
       (("l" "Links" entry (file "~/Dropbox/notes/links.org")
	 "* [[%^{Link}][%^{Description}]]  %^g\n  %t")
	;; Capture TODOs
	("t" "TODO" entry (file+headline "~/Dropbox/org/work.org" "Tasks")
	 "** TODO %?\n   %t")
	)))
;; org-refile configs
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))

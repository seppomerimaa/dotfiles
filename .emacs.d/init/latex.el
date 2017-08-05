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

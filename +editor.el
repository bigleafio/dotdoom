;;; +editor.el --- description -*- lexical-binding: t; -*-

(setq-default fill-column 70)

(setq-default whitespace-line-column 70)
(setq-default whitespace-style '(face indentation tabs tab-mark spaces space-mark newline newline-mark trailing lines-tail))

(when (display-graphic-p)
  (add-hook   'find-file-hook #'whitespace-mode)
  (add-hook 'before-save-hook #'whitespace-cleanup))

(global-prettify-symbols-mode +1)

(provide '+editor)

;;; +editor.el ends here

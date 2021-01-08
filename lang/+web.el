;;; lang/+web.el -*- lexical-binding: t; -*-

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

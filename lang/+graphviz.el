;;; lang/+graphviz.el -*- lexical-binding: t; -*-


(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))

(use-package company-graphviz-dot)

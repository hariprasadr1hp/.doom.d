;;; modes/+basic.el -*- lexical-binding: t; -*-

;; setting the language for ispell
(setq ispell-dictionary "en")


;; Workaround for the error "Don't know how to format fundamental-mode"
(setq +format-on-save-enabled-modes
  '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
        sql-mode         ; sqlformat is currently broken
        tex-mode         ; latexindent is broken
        org-mode
        org-journal-mode
        fundamental-mode
        latex-mode))

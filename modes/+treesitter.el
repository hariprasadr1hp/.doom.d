;;; modes/+treesitter.el -*- lexical-binding: t; -*-

(use-package! tree-sitter
  :hook ((prog-mode . tree-sitter-mode)
         (tree-sitter-after-on . tree-sitter-hl-mode)))

(use-package! tree-sitter-langs
  :after tree-sitter)

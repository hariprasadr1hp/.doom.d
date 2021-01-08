;;; modes/+elisp.el -*- lexical-binding: t; -*-

;; | COMMAND         | DESCRIPTION                                    | KEYBINDING |
;; | --------------- | ---------------------------------------------- | ---------- |
;; | eval-buffer     | /Evaluate elisp in buffer/                     | SPC e b    |
;; | eval-defun      | /Evaluate the defun containing or after point/ | SPC e d    |
;; | eval-expression | /Evaluate an elisp expression/                 | SPC e e    |
;; | eval-last-sexp  | /Evaluate elisp expression before point/       | SPC e l    |
;; | eval-region     | /Evaluate elisp in region/                     | SPC e r    |
;; | --------------- | ---------------------------------------------- | ---------- |



(map!
	:leader
	:desc "Evaluate elisp in buffer" "e b" #'eval-buffer

	:leader
	:desc "Evaluate defun" "e d" #'eval-defun

	:leader
	:desc "Evaluate elisp expression" "e e" #'eval-expression

	:leader
	:desc "Evaluate last sexpression" "e x" #'eval-last-sexp

	:leader
	:desc "Evaluate elisp in region" "e r" #'eval-region
)

;;; modes/org-mode/+org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org
;;-------------------------------------------------------------

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/my/org/")

(setq org-support-shift-select t)

(setq org-ellipsis " ▾ ")

(setq org-adapt-indentation nil)

(setq org-bullets-bullet-list '("◉" "⋆" "○" "‣"))

(setq
 org-tags-column -80
 org-log-done 'time
 org-refile-targets (quote ((nil :maxlevel . 1))))

;; add a blank link by default when adding a new item
(setf org-blank-before-new-entry '((heading . always) (plain-list-item . always)))


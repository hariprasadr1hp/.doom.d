;;; modes/org-mode/+org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org
;;-------------------------------------------------------------

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/my/org/")
;;(global-company-mode '(not org-mode))

;;shift select
(setq org-support-shift-select t)

;; org-ellipsis
(setq org-ellipsis " ▾ ")

;; indentation to outline mode
(setq org-adapt-indentation nil)

;; show habites

;; org-bullets
(setq org-bullets-bullet-list '("◉" "⋆" "○" "‣"))

(setq
 org-tags-column -80
 org-log-done 'time
 org-refile-targets (quote ((nil :maxlevel . 1))))

(setf org-blank-before-new-entry '((heading . always) (plain-list-item . always)))

(add-hook 'org-mode-hook(lambda() (company-mode -1)))

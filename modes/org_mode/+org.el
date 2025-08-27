;;; modes/org-mode/+org.el -*- lexical-binding: t; -*-

(setq org-directory "~/my/org/")

;; add a blank link by default when adding a new item
(setf org-blank-before-new-entry '((heading . always) (plain-list-item . always)))

(after! org
  (setq org-support-shift-select t          ; allow S-<arrow> selection in Org
        org-ellipsis " …↯"                  ; folded indicator
        org-adapt-indentation nil           ; keep body text flush-left
        org-tags-column -80                 ; right-align tags at col 80
        org-log-done 'time                  ; timestamp when DONE
        org-refile-targets '((nil :maxlevel . 1)) ; refile to top-level of current file
        org-blank-before-new-entry '((heading . always)
                                     (plain-list-item . always))) ; blank line before new items
  (setq org-list-indent-offset 0))

(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿"))
  (setq org-superstar-item-bullet-alist '((?- . ?–) (?+ . ?➤) (?* . ?•))))

;; (add-hook 'org-mode-hook #'org-indent-mode)

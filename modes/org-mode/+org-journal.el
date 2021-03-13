;;; modes/org-mode/+journal.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org-journal
;;-------------------------------------------------------------
(use-package org-journal
      :bind
      ("C-c n j" . org-journal-new-entry)
      :custom
      (org-journal-date-prefix "#+TITLE: ")
      (org-journal-time-prefix "* ")
      (org-journal-file-format "%Y-%m-%d.org")
      (org-journal-date-format "%a, %d-%m-%Y"))

(setq org-journal-enable-agenda-integration t)

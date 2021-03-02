;;; modes/org.el -*- lexical-binding: t; -*-


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/my/org/")

(global-company-mode '(not org-mode))

;; org setup
;; org-ellipsis
(setq org-ellipsis " ▾ ")

;; org-bullets
(setq org-bullets-bullet-list '("◉" "⋆" "○" "‣"))

(setq
 org-tags-column -80
 org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
 org-log-done 'time
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-capture-templates '(("x" "Note" entry
                          (file+olp+datetree "journal.org")
                          "**** [ ] %U %?" :prepend t :kill-buffer t)
                         ("t" "Task" entry
                          (file+headline "tasks.org" "Inbox")
                          "* [ ] %?\n%i" :prepend t :kill-buffer t))
 +org-capture-todo-file "tasks.org"
 org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Important"
                                  :priority "A")
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Big Outcomes"
                                  :tag "bo")))

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)

(map! :ne "SPC n b" #'org-brain-visualize)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)


;;org-journal
(use-package org-journal
      :bind
      ("C-c n j" . org-journal-new-entry)
      :custom
      (org-journal-date-prefix "#+TITLE: ")
      (org-journal-time-prefix "* ")
      (org-journal-file-format "%Y-%m-%d.org")
      (org-journal-date-format "%a, %d-%m-%Y"))
(setq org-journal-enable-agenda-integration t)




;; org-roam
(setq org-roam-directory "~/my/org/roam")
        
;; Interactive org-roam server graph
(require 'simple-httpd)
(setq httpd-root "/var/www")

                  
(use-package org-roam-server
  :ensure nil
  :load-path "~/my/org/org-roam-server"
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 6535
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))      
      
      
      


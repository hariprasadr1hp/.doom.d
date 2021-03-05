;;; modes/org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org
;;-------------------------------------------------------------

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/my/org/")
;;(global-company-mode '(not org-mode))

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


;;-------------------------------------------------------------
;; org-brain
;;-------------------------------------------------------------
(map! :ne "SPC n b" #'org-brain-visualize)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)


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


;;-------------------------------------------------------------
;; org-roam
;;-------------------------------------------------------------
;;(setq org-roam-directory "~/my/org/roam")

(use-package org-roam
  :load-path
  ("~/my/org/roam/")
  :ensure t
  :hook
    ((after-init . org-roam-mode))
  :custom
    (org-roam-directory "~/my/org/roam")
    (org-roam-index-file "index.org")
    (org-roam-dailies-directory "scratch/")
  :bind
    (:map org-roam-mode-map
      (("C-c m l" . org-roam)
      ("C-c m F" . org-roam-find-file)
      ("C-c m r" . org-roam-find-ref)
      ("C-c m ." . org-roam-find-directory)
      ("C-c m >" . hp/org-roam-find-directory-testing)
      ("C-c m d" . org-roam-dailies-map)
      ("C-c m j" . org-roam-jump-to-index)
      ("C-c m b" . org-roam-switch-to-buffer)
      ("C-c m g" . org-roam-graph))
    :map org-mode-map
      (("C-c m i" . org-roam-insert)))
  :config
    (setq 
      org-roam-capture-templates
        '(("d" "default" plain
        (function org-roam-capture--get-point)
        "%?"
        :file-name "%<%Y%m%d%H%M%S>-${slug}"
        :head "#+title: ${title}\n#+created: %u\n#+last_modified: %U\n#+roam_alias: "${title}"\n"
        :unnarrowed t))
      org-roam-capture-ref-templates
        '(("r" "ref" plain
          (function org-roam-capture--get-point)
          ""
          :file-name "web/${slug}"
          :head "#+title: ${title}\n#+roam_key: ${ref}\n#+created: %u\n#+last_modified: %U\n\n%(hp/org-protocol-insert-selection-dwim \"%i\")"
          :unnarrowed t)
          ("i" "incremental" plain
            (function org-roam-capture--get-point)
             "* %?\n%(hp/org-protocol-insert-selection-dwim \"%i\")"
             :file-name "web/${slug}"
             :head "#+title: ${title}\n#+roam_key: ${ref}\n#+created: %u\n#+last_modified: %U\n\n"
             :unnarrowed t
             :empty-lines-before 1))
      org-roam-dailies-capture-templates
        '(("d" "default" entry
          #'org-roam-capture--get-point
          "* %?"
          :file-name "scratch/%<%Y-%m-%d>"
          :head "#+title: %<%Y-%m-%d>\n\n"
          :add-created t)))

  (defvar hp/org-roam-directory-testing "~/org/slip-box-testing")

  (defun hp/org-roam-find-directory-testing ()
    (interactive)
    (find-file hp/org-roam-directory-testing)))


(setq org-roam-title-sources '((title headline) alias))

;;-------------------------------------------------------------
;; org-roam-server
;;-------------------------------------------------------------        
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
      
;;-------------------------------------------------------------
;; 
;;-------------------------------------------------------------
      
      


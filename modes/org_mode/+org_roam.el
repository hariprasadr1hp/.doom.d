;;; modes/org-mode/+org_roam.el -*- lexical-binding: t; -*-

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)

  :custom
  (org-roam-directory "~/my/org/roam")
  (org-roam-index-file "index.org") ;; --
  (org-roam-dailies-directory "~/my/org/scratch/") ;; --
  (org-roam-completion-everywhere t)
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s)" "HOLD(h)" "|" "DONE(d)" "CNCL(c)")))
  (org-todo-keyword-faces '(("STRT" . +org-todo-active)
                            ("HOLD" . +org-todo-onhold)
                            ("CNCL" . +org-todo-cancel)))
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n")
      ;; :file-name "web/${slug}"
      ;; :head "#+title: ${title}\n"
      :unnarrowed t)))


  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))

  :config
  (org-roam-db-autosync-enable))

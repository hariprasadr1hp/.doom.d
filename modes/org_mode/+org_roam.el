;;; modes/org-mode/+org_roam.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org-roam
;;-------------------------------------------------------------

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  
  :custom
  (org-roam-directory "~/my/org/roam")
  (org-roam-index-file "index.org") ;; --
  (org-roam-dailies-directory "~/my/org/scratch/") ;; --
  (org-roam-completion-everywhere t)
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
  (org-roam-setup))


(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil))

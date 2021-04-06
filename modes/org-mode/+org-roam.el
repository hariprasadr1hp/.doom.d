;;; modes/org-mode/+org-roam.el -*- lexical-binding: t; -*-

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
  (org-roam-dailies-directory "~/my/org/scratch/")

  :bind
  (:map org-roam-mode-map
   (("C-c m l" . org-roam)
    ("C-c m F" . org-roam-find-file)
    ("C-c m r" . org-roam-find-ref)
    ("C-c m ." . org-roam-find-directory)
    ("C-c m >" . hp/org-roam-find-directory-testing)
    ("C-c m d" . org-roam-dailies-map)
    ("C-c m j" . org-roam-jump-to-index)
    ("C-c m b" . org-roam-switch-to-buffer))
    ("C-c m g" . org-roam-graph))

    (:map org-mode-map
    (("C-c m i" . org-roam-insert)))

  :config
  (setq
   org-roam-capture-templates
   (quote
    (("d" "default" plain
      (function org-roam-capture--get-point)
      "%?"
      :file-name "%<%Y%m%d%H%M%S>-${slug}"
      :head "#+title: ${title}\n#+created: %u\n#+last_modified: %U\n#+roam_alias: "${title}"\n"
      :unnarrowed t)))

   org-roam-capture-ref-templates
   (quote
    (("r" "ref" plain
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
      :empty-lines-before 1)))

   org-roam-dailies-capture-templates
   (quote
    (("d" "default" entry
      #'org-roam-capture--get-point
      "* %?"
      :file-name "scratch/%<%Y-%m-%d>"
      :head "#+title: %<%Y-%m-%d>\n\n"
      :add-created t))))

  (defvar hp/org-roam-directory-testing "~/my/org/slip-box-testing")

  (defun hp/org-roam-find-directory-testing ()
    (interactive)
    (find-file hp/org-roam-directory-testing)))


(setq org-roam-title-sources '((title headline) alias))


(require 'company-org-roam)
    (use-package company-org-roam
      :when (featurep! :completion company)
      :after org-roam
      :config
      (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

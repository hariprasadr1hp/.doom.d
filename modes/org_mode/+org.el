;;; modes/org-mode/+org.el -*- lexical-binding: t; -*-

(setq org-directory "~/my/org/")

;; Add a blank line before new Org entries.
(setq org-blank-before-new-entry
      '((heading . always)
        (plain-list-item . always)))

(after! org
  (setq
   org-preview-latex-default-process 'dvipng
   org-support-shift-select t
   org-ellipsis " …↯"
   org-adapt-indentation nil
   org-tags-column -80
   org-log-done 'time
   org-refile-targets '((nil :maxlevel . 1))
   org-list-indent-offset 0
   org-blank-before-new-entry
   '((heading . always)
     (plain-list-item . always)))

  ;; LaTeX preview scaling ----------------------------------------------------

  (defun hp-org-monitor-pixel-width ()
    "Return the pixel width of the monitor containing the selected frame."
    (let* ((monitor-attrs (frame-monitor-attributes))
           (geometry (alist-get 'geometry monitor-attrs)))
      (nth 2 geometry)))

  (defun hp-org-latex-preview-scale-for-width (pixel-width)
    "Return an Org LaTeX preview scale suitable for PIXEL-WIDTH."
    (cond
     ((>= pixel-width 5000) 2.2)  ; 5K / Retina-like
     ((>= pixel-width 3800) 1.8)  ; 4K
     ((>= pixel-width 2500) 1.5)  ; QHD / 1440p
     (t 1.15)))                  ; 1080p-ish

  (defun hp-org-update-latex-preview-scale ()
    "Update `org-format-latex-options' based on the current monitor."
    (let* ((pixel-width (hp-org-monitor-pixel-width))
           (scale (hp-org-latex-preview-scale-for-width pixel-width)))
      (plist-put org-format-latex-options :scale scale)))

  ;; Set once when Org loads.
  (hp-org-update-latex-preview-scale)

  (defun hp-org-update-latex-preview-colors ()
    "Update LaTeX preview colors from the current theme."
    (let ((foreground (face-attribute 'default :foreground nil t))
          (background (face-attribute 'default :background nil t)))
      (plist-put org-format-latex-options :foreground foreground)
      (plist-put org-format-latex-options :background background)))

  (defun hp-org-update-latex-preview-appearance ()
    "Update LaTeX preview size and colors."
    (hp-org-update-latex-preview-scale)
    (hp-org-update-latex-preview-colors))

  (hp-org-update-latex-preview-appearance)

  ;; Recalculate if the frame/window size changes or frame moves monitors.
  (add-hook 'window-size-change-functions
            (lambda (&rest _)
              (hp-org-update-latex-preview-scale)))

  ;; Re-run after changing Doom themes.
  (add-hook 'doom-load-theme-hook
            #'hp-org-update-latex-preview-appearance)

  (defun hp-org-latex-previews-enabled-p ()
    "Return non-nil if LaTeX previews are enabled in this buffer."
    (bound-and-true-p hp-org-latex-previews-enabled))

  (defun hp-org-toggle-latex-previews ()
    "Toggle LaTeX previews for the whole current Org buffer."
    (interactive)
    (if (hp-org-latex-previews-enabled-p)
        (progn
          (org-clear-latex-preview (point-min) (point-max))
          (setq-local hp-org-latex-previews-enabled nil)
          (message "LaTeX previews hidden"))
      (org-latex-preview '(64))
      (setq-local hp-org-latex-previews-enabled t)
      (message "LaTeX previews shown")))

  (defun hp-org-clear-latex-preview-cache ()
    "Delete all Org LaTeX preview cache files."
    (interactive)

    (when (and org-preview-latex-image-directory
               (file-directory-p org-preview-latex-image-directory))
      (delete-directory org-preview-latex-image-directory t)
      (message "Cleared Org LaTeX preview cache.")))

  )

(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list
        '("◉" "○" "✸" "✿"))
  (setq org-superstar-item-bullet-alist
        '((?- . ?–)
          (?+ . ?➤)
          (?* . ?•))))

;; (add-hook 'org-mode-hook #'org-indent-mode)

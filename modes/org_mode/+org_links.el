;;; modes/org-mode/+org_links.el -*- lexical-binding: t; -*-

(defun hp-org-open-link-in-firefox ()
  "open the link at point in firefox (only https)"
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "firefox" nil hp-firefox-path link)
      (message "No valid HTTPS link at point"))))


(defun hp-org-open-link-in-brave ()
  "open link at point in brave (only https)"
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "brave" nil hp-brave-path link)
      (message "No valid HTTPS link at point"))))


(defun hp-org-open-link-in-chrome ()
  "open link at point in chrome (only https)"
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "chrome" nil hp-chrome-path link)
      (message "No valid HTTPS link at point"))))


(defun hp-eww-open-link-at-point-no-split ()
  "open link at point in a new eww buffer without a window-split"
  (interactive)
  (let ((url (thing-at-point 'url t))
        (buffer (get-buffer-create "*eww*"))
        (display-buffer-alist nil))  ;; Disable splitting rules temporarily
    (if url
        (progn
          (with-current-buffer buffer
            (eww-mode)
            (eww url))
          (switch-to-buffer buffer))
      (message "No URL found at point."))))


(map! :leader :desc "open-link-in-[B]rave" "m l b" #'hp-org-open-link-in-brave)
(map! :leader :desc "open-link-in-[C]hrome" "m l c" #'hp-org-open-link-in-chrome)
(map! :leader :desc "open-link-in-[E]ww" "m l e" #'hp-eww-open-link-at-point-no-split)
(map! :leader :desc "open-link-in-[F]irefox" "m l f" #'hp-org-open-link-in-firefox)
(map! :leader :desc "link-hint-copy-link-at-point" "m l y" #'link-hint-copy-link-at-point)

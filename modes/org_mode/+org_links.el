;;; modes/org-mode/+org_links.el -*- lexical-binding: t; -*-

(defun get-firefox-path ()
  "Return the path to the Firefox executable based on the OS."
  (cond
   ((string-equal system-type "gnu/linux") "firefox")
   ((string-equal system-type "darwin") "/Applications/Firefox.app/Contents/MacOS/firefox")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\Mozilla Firefox\\firefox.exe")
   (t (error "Unsupported OS"))))

(defun open-https-in-firefox (url)
  "Open a HTTPS URL in Firefox."
  (interactive "sEnter HTTPS URL: ")
  (let ((firefox-path (get-firefox-path)))
    (if (string-prefix-p "https://" url)
        (start-process "firefox" nil firefox-path url)
      (message "URL must start with 'https://'"))))

;; Custom function to read URLs from Org mode links
(defun get-url-at-point ()
  "Get the URL at point in an Org mode buffer."
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if link
        (message "Link: %s" link)
      (message "No link at point"))))



(map! :leader
      :desc "Open HTTPS URL in Firefox" "m l f" #'open-https-in-firefox)

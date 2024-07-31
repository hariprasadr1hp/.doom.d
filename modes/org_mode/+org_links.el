;;; modes/org-mode/+org_links.el -*- lexical-binding: t; -*-

(defun get-firefox-path ()
  "Return the path to the Firefox executable based on the OS."
  (cond
   ((string-equal system-type "gnu/linux") "firefox")
   ((string-equal system-type "darwin") "/Applications/Firefox.app/Contents/MacOS/firefox")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\Mozilla Firefox\\firefox.exe")
   (t (error "Unsupported OS"))))


(defun get-brave-path ()
  "Return the path to the Brave Browser executable based on the OS."
  (cond
   ((string-equal system-type "gnu/linux") "brave-browser")
   ((string-equal system-type "darwin") "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\BraveSoftware\\Brave-Browser\\Application\\brave.exe")
   (t (error "Unsupported OS for Brave Browser"))))


(defun get-chrome-path ()
  "Return the path to the Google Chrome executable based on the OS."
  (cond
   ((string-equal system-type "gnu/linux") "google-chrome")
   ((string-equal system-type "darwin") "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")
   (t (error "Unsupported OS for Google Chrome"))))


(defvar firefox-path (get-firefox-path)
  "Path to the Firefox executable.")


(defvar brave-path (get-brave-path)
  "Path to the Firefox executable.")


(defvar chrome-path (get-chrome-path)
  "Path to the Firefox executable.")


(defun open-link-in-firefox ()
  "Open the link at point in Firefox if it starts with 'https://'."
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "firefox" nil firefox-path link)
      (message "No valid HTTPS link at point"))))


(defun open-link-in-brave ()
  "Open the link at point in Brave if it starts with 'https://'."
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "brave" nil brave-path link)
      (message "No valid HTTPS link at point"))))


(defun open-link-in-chrome ()
  "Open the link at point in Chrome if it starts with 'https://'."
  (interactive)
  (let* ((element (org-element-context))
         (type (org-element-type element))
         (link (when (eq type 'link)
                 (org-element-property :raw-link element))))
    (if (and link (string-prefix-p "https://" link))
        (start-process "chrome" nil chrome-path link)
      (message "No valid HTTPS link at point"))))


(map! :leader :desc "link-hint-copy-link-at-point" "m l y" #'link-hint-copy-link-at-point)
(map! :leader :desc "open-link-in-[F]irefox" "m l f" #'open-link-in-firefox)
(map! :leader :desc "open-link-in-[B]rave" "m l b" #'open-link-in-brave)
(map! :leader :desc "open-link-in-chro[M]e" "m l m" #'open-link-in-chrome)

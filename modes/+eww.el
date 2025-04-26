;;; modes/+eww.el -*- lexical-binding: t; -*-

;; Emacs Web Wowser

(setq browse-url-browser-function 'eww-browse-url)
(setq eww-download-directory "~/my/org/eww/")
(setq eww-search-prefix "https://duckduckgo.com/html/?q=")
;; open links in the same buffer (by default)
(setq eww-use-external-browser-for-content-type nil)
;; disable images by default for speed
(setq shr-inhibit-images t)
;; render tables better
(setq shr-use-fonts nil)
;; preferred width to make text easier to read
(setq shr-width 80)
(setq eww-history-limit 200)


(defun hp-eww-link-at-point ()
  "returns the link (URL) at point, if exists"
  (get-text-property (point) 'shr-url))


(defun hp-eww-show-link-at-point ()
  "prints the link (URL) at point, if exists"
  (interactive)
  (let ((url (hp-eww-link-at-point)))
    (if url
        (message "%s" url)
      (message "No link at point."))))


(defun hp-eww-copy-link-at-point ()
  "copies the link at point, if exists"
  (interactive)
  (let ((url (hp-eww-link-at-point)))
    (if url
        (progn
          (kill-new url)
          (message "Copied: %s" url))
      (message "No link at point."))))


(defun hp-eww-open-link-in-firefox ()
  "open link at point in brave (only https)"
  (interactive)
  (let ((url (get-text-property (point) 'shr-url)))
    (if (and url (string-prefix-p "https://" url))
        (start-process "firefox" nil hp-firefox-path url)
      (message "No valid HTTPS link at point"))))


(defun hp-eww-open-link-in-brave ()
  "open link at point in brave (only https)"
  (interactive)
  (let ((url (get-text-property (point) 'shr-url)))
    (if (and url (string-prefix-p "https://" url))
        (start-process "brave" nil hp-brave-path url)
      (message "No valid HTTPS link at point"))))


(defun hp-eww-open-link-in-chrome ()
  "open link at point in chrome (only https)"
  (interactive)
  (let ((url (get-text-property (point) 'shr-url)))
    (if (and url (string-prefix-p "https://" url))
        (start-process "chrome" nil hp-chrome-path url)
      (message "No valid HTTPS link at point"))))


(defvar hp-eww-script-path
  (expand-file-name "scripts/eww_link_handler.py" doom-user-dir))

(require 'json)

(defun hp-eww-hijack-link-handler (url &optional _new-window)
  "delegate link handling to an external script"
  (interactive (list (get-text-property (point) 'shr-url)))
  (let* ((raw (shell-command-to-string (format "%s '%s'" hp-eww-script-path url)))
         (result (ignore-errors (json-parse-string raw :object-type 'alist)))
         (decision (alist-get 'decision result))
         (reason (alist-get 'reason result)))
    (cond
     ((equal decision "BLOCK")
      (message "Blocked link: %s (%s)" url reason))
     ((equal decision "OPEN_EXTERNALLY")
      (message "Opening externally: %s (%s)" url reason)
      (browse-url url))
     ((equal decision "OPEN_IN_EWW")
      (message "Opening in EWW: %s (%s)" url reason)
      (eww url))
     (t
      (message "Unknown or invalid response from handler: %s" raw)))))

(advice-add 'shr-browse-url :override #'hp-eww-hijack-link-handler)


(after! eww
  (setq eww-mode-map (make-sparse-keymap))

  (evil-define-key 'normal eww-mode-map
    (kbd "C-j") #'shr-next-link
    (kbd "C-k") #'shr-previous-link
    (kbd "K") #'hp-eww-show-link-at-point
    (kbd "gA") #'eww-add-bookmark
    (kbd "gB") #'hp-eww-open-link-in-brave
    (kbd "gC") #'hp-eww-open-link-in-chrome
    (kbd "gF") #'hp-eww-open-link-in-firefox
    (kbd "gb") #'eww-list-bookmarks
    (kbd "gc") #'eww-copy-page-url
    (kbd "gd") #'shr-browse-url
    (kbd "gh") #'eww-list-histories
    (kbd "gr") #'eww-reload
    (kbd "gx") #'eww-browse-with-external-browser
    (kbd "gy") #'hp-eww-copy-link-at-point
    (kbd "]l") #'shr-next-link
    (kbd "[l") #'shr-previous-link
    (kbd "[p") #'eww-back-url
    (kbd "]p") #'eww-forward-url))

(map! :map eww-mode-map
      :n "q" #'quit-window
      :n "r" #'eww-reload)

(map!
 :leader
 :desc "eww-browser-external" "k b" #'eww-browse-with-external-browser

 :leader
 :desc "eww-copy-url" "k c" #'eww-copy-page-url

 :leader
 :desc "eww-copy-url" "k d" #'eww-download

 :leader
 :desc "eww-prev-page" "k h" #'eww-back-url

 :leader
 :desc "eww-images-toggle" "k i" #'eww-toggle-images

 :leader
 :desc "eww-mode-activate" "k K" #'eww-mode

 :leader
 :desc "eww-next-page" "k l" #'eww-forward-url

 :leader
 :desc "eww-web-browser" "k k" #'eww

 :leader
 :desc "eww-reload-page" "k r" #'eww-reload

 :leader
 :desc "Search web for text between BEG/END" "k s" #'eww-search-words

 :leader
 :desc "eww-text-readable" "k t" #'eww-readable

 :leader
 :desc "eww-inspect-source" "k u" #'eww-view-source

 :leader
 :desc "eww-yank-url" "k y" #'eww-copy-page-url
 )

;;; modes/+eww.el -*- lexical-binding: t; -*-

;; Emacs Web Wowser


;; | COMMAND          | DESCRIPTION                             | KEYBINDING |
;; | ---------------- | --------------------------------------- | ---------- |
;; | eww              | /Fetch URL and render the page/         | SPC k q    |
;; | eww-reload       | /Reload the current page/               | SPC k r    |
;; | eww-search-words | /Search the web for text/               | SPC k s    |
;; | eww-search-words | /Search the web for text/               | SPC s w    |
;; | eww-back-url     | /Go to the previously displayed page/   | SPC k b    |
;; | eww-forward-url  | /Go to the next displayed page/         | SPC k f    |
;; | eww-view-source  | /View the HTML source code of the page/ | SPC k i    |
;; | ---------------- | --------------------------------------- | ---------- |


(setq browse-url-browser-function 'eww-browse-url)

(setq eww-download-directory "~/my/org/eww/")

(defun hp-eww-open-link-at-point-no-split ()
  "Open the link at point in a new buffer with eww without splitting the window."
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


(map!
 :leader
 :desc "eww-browser-external" "k b" #'eww-browse-with-external-browser

 :leader
 :desc "eww-copy-url" "k c" #'eww-copy-page-url

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

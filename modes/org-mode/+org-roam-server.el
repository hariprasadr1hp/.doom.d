;;; modes/org-mode/+org-roam-server.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org-roam-server
;;-------------------------------------------------------------

;; Interactive org-roam server graph
(require 'simple-httpd)
(setq httpd-root "/var/www")


(use-package org-roam-server
  :ensure t
  :after (org-roam server)
  :load-path "~/my/org/org-roam-server"

  :config
  (setq
   org-roam-server-host "127.0.0.1"
   org-roam-server-port 6535
   org-roam-server-authenticate nil
   org-roam-server-export-inline-images t
   org-roam-server-serve-files nil
   org-roam-server-served-file-extensions '("pdf" "mp4" "ogv" "svg")
   org-roam-server-network-poll t
   org-roam-server-network-arrows t
   org-roam-server-network-label-truncate t
   org-roam-server-network-label-truncate-length 60
   org-roam-server-network-label-wrap-length 20)

  (defun hp/org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (org-roam-server-mode 1)
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))))

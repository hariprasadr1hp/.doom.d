;;; modes/org-mode/+roam-server.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org-roam-server
;;-------------------------------------------------------------
;; Interactive org-roam server graph
(require 'simple-httpd)
(setq httpd-root "/var/www")


(use-package org-roam-server
  :ensure nil
  :load-path "~/my/org/org-roam-server"
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 6535
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;;; modes/+preload.el -*- lexical-binding: t; -*-

(defun hp-get-firefox-path ()
  "returns executable path for firefox, based on os"
  (cond
   ((string-equal system-type "gnu/linux") "firefox")
   ((string-equal system-type "darwin") "/Applications/Firefox.app/Contents/MacOS/firefox")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\Mozilla Firefox\\firefox.exe")
   (t (error "Unsupported OS for Firefox"))))


(defun hp-get-brave-path ()
  "returns executable path for brave, based on os"
  (cond
   ((string-equal system-type "gnu/linux") "brave-browser")
   ((string-equal system-type "darwin") "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\BraveSoftware\\Brave-Browser\\Application\\brave.exe")
   (t (error "Unsupported OS for Brave Browser"))))


(defun hp-get-chrome-path ()
  "returns executable path for chrome, based on os"
  (cond
   ((string-equal system-type "gnu/linux") "google-chrome")
   ((string-equal system-type "darwin") "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
   ((string-equal system-type "windows-nt") "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")
   (t (error "Unsupported OS for Google Chrome"))))


(defvar hp-firefox-path (hp-get-firefox-path)
  "path to the firefox executable.")


(defvar hp-brave-path (hp-get-brave-path)
  "path to the brave executable.")


(defvar hp-chrome-path (hp-get-chrome-path)
  "path to the chrome executable.")

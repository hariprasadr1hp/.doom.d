;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; add paths
(add-to-list 'exec-path "/usr/local/bin/")

;; (require 'dotenv-mode) ; unless installed from a package

(defun load-env-file (filepath)
  "Load environment variables from a .env file."
  (when (file-exists-p filepath)
    (with-temp-buffer
      (insert-file-contents filepath)
      (dolist (line (split-string (buffer-string) "\n" t))
        (when (string-match "\\`\\([^#= \t]+\\)=\\(.*\\)\\'" line)
          (setenv (match-string 1 line) (match-string 2 line)))))))

(load-env-file (expand-file-name ".env" doom-user-dir))

;; setting the environment
(load! "+misc")

;; loading modes
(load! "modes/+config")

;; loading custom setup
(load! "hp_modules/+config")

;; loading language setup 
(load! "lang/+config")

;; loading ui setup
(load! "ui/+config")

;; temporary config
(load! "temp")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

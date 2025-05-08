;;; modes/+dictionary.el -*- lexical-binding: t; -*-

;; Use hunspell as the backend
(setq ispell-program-name "hunspell"
      ispell-dictionary "en_US"
      ispell-extra-args '("-d" "en_US,de_DE"))

;; Respect XDG config paths
(unless (getenv "XDG_CONFIG_HOME")
  (setenv "XDG_CONFIG_HOME" (expand-file-name "~/.config")))

(setq ispell-personal-dictionary
      (expand-file-name "hunspell/hunspell_personal"
                        (getenv "XDG_CONFIG_HOME")))

;; Ensure dictionary path is in environment
(setenv "DICPATH" (expand-file-name "hunspell" (getenv "XDG_CONFIG_HOME")))

;; Set up flyspell in text-based modes
(add-hook! 'text-mode-hook
  (lambda ()
    (flyspell-mode 1)
    (ispell-change-dictionary "en_US")))

;; Optional manual switchers
(defun hp-set-dictionary-en ()
  "Switch spell checker to English (en_US)."
  (interactive)
  (ispell-change-dictionary "en_US")
  (message "Switched to English (en_US)"))

(defun hp-set-dictionary-de ()
  "Switch spell checker to German (de_DE)."
  (interactive)
  (ispell-change-dictionary "de_DE")
  (message "Switched to German (de_DE)"))

; (map! :leader
;       (:prefix ("t s" . "spelling")
;        :desc "Set dictionary to English" "e" #'hp-set-dictionary-en
;        :desc "Set dictionary to German" "d" #'hp-set-dictionary-de))

;; Manual fallback to add word if zg fails
(defun hp-add-word-to-hunspell-dict (word)
  "Forcefully add WORD to personal Hunspell dictionary file."
  (interactive (list (thing-at-point 'word)))
  (let ((file ispell-personal-dictionary))
    (unless (and file (file-writable-p file))
      (error "Personal dictionary file not set or not writable: %s" file))
    (with-temp-buffer
      (insert word "\n")
      (append-to-file (point-min) (point-max) file))
    (message "Added '%s' to hunspell personal dictionary." word)))

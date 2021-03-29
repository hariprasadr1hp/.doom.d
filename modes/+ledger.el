;;; modes/+ledger.el -*- lexical-binding: t; -*-

(use-package ledger-mode
  :ensure t
  :init
  (setq leadger-clear-whole-transactions 1)

  :config
  (add-to-list 'evil-emacs-state-modes 'ledger-report-mode)
  :mode ("\\.dat\\'"
         "\\.ledger\\'"))



(defun ledger-add-entry (title in amount out)
  (interactive
   (let ((accounts (mapcar 'list (ledger-accounts))))
     (list (read-string "Entry: " (format-time-string "%Y-%m-%d " (current-time)))
           (let ((completion-regexp-list "^Ausgaben:"))
             (completing-read "What did you pay for? " accounts))
           (read-string "How much did you pay? " "CHF ")
           (let ((completion-regexp-list "^Vermögen:"))
             (completing-read "Where did the money come from? " accounts)))))
  (insert title)
  (newline)
  (indent-to 4)
  (insert in "  " amount)
  (newline)
  (indent-to 4)
  (insert out))

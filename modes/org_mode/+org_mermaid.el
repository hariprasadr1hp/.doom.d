;;; modes/org_mode/+org_mermaid.el -*- lexical-binding: t; -*-

(use-package! ob-mermaid
  :after org-roam
  :config
  ;; Set path to the mmdc executable depending on OS
  (setq ob-mermaid-cli-path
        (cond
         ((eq system-type 'darwin) "/opt/homebrew/bin/mmdc")
         ((eq system-type 'gnu/linux) "/usr/local/bin/mmdc")
         (t "mmdc"))) ;; fallback

  ;; OS-specific cache directory
  (defvar hp-ob-mermaid-cache-dir
    (let ((base (expand-file-name "~/.cache/emacs/ob-mermaid/"))
          (os-name (symbol-name system-type)))
      (expand-file-name os-name base))) ;; e.g., ~/.cache/emacs/ob-mermaid/darwin/

  (unless (file-exists-p hp-ob-mermaid-cache-dir)
    (make-directory hp-ob-mermaid-cache-dir t))

  ;; Generate a stable .png output filename based on the code block hash
  (defun hp-org-babel-mermaid-make-temp-file-name ()
    "Generate a .png file path in the cache dir based on block content hash."
    (let ((hash (format "%x" (sxhash (buffer-substring-no-properties
                                      (org-element-property :begin (org-element-at-point))
                                      (org-element-property :end (org-element-at-point)))))))
      (expand-file-name (format "mermaid-%s.png" hash) hp-ob-mermaid-cache-dir)))

  ;; Extra args for mmdc (for PNG format)
  (defvar hp-ob-mermaid-extra-args "--outputFormat png --backgroundColor white")

  ;; Custom executor
  (defun hp-org-babel-execute:mermaid (body params)
    "Execute Mermaid diagram block and save as PNG."
    (let* ((temp-infile (org-babel-temp-file "mermaid-" ".mmd"))
           (out-file (or (cdr (assoc :file params))
                         (hp-org-babel-mermaid-make-temp-file-name)))
           (cmd (format "%s -i %s -o %s %s"
                        (shell-quote-argument ob-mermaid-cli-path)
                        (shell-quote-argument temp-infile)
                        (shell-quote-argument out-file)
                        hp-ob-mermaid-extra-args)))
      (with-temp-file temp-infile
        (insert body))
      (message "Running Mermaid command: %s" cmd)
      (let ((exit-code (shell-command cmd)))
        (if (and (file-exists-p out-file) (zerop exit-code))
            out-file
          (error "Mermaid CLI failed or output not found: %s" out-file)))))

  ;; Override the default ob-mermaid executor
  (advice-add 'org-babel-execute:mermaid :override #'hp-org-babel-execute:mermaid))

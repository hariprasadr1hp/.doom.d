;;; modes/org-mode/+org_export.el -*- lexical-binding: t; -*-

(require 'org)
(require 'json)

(defun read-org-file-contents ()
  "Read and display the contents of an Org file specified by FILE-PATH."
  (interactive)
  (when (derived-mode-p 'org-mode)
    (message "%s" (buffer-string))))


(defun org-element-to-json (element)
  "Convert an Org element to a JSON-compatible structure."
  (let ((type (org-element-type element))
        (properties (org-element-all-properties element))
        (contents (org-element-contents element)))
    (cons (cons 'type (symbol-name type))
          (append properties
                  (when contents
                    (list (cons 'contents (mapcar #'org-element-to-json contents))))))))


(defun org-element-all-properties (element)
  "Extract all properties from an Org element."
  (let ((properties '()))
    (dolist (property '(raw-value
                        begin
                        end
                        post-blank
                        post-affiliated
                        parent))
      (let ((value (org-element-property property element)))
        (when value
          (push (cons (symbol-name property) value) properties))))
    properties))


(defun org-buffer-to-json ()
  "Parse the current Org buffer and return its JSON representation."
  (interactive)
  (when (derived-mode-p 'org-mode)
    (let ((org-data (org-element-parse-buffer)))
      (let ((json-object-type 'alist) ; Use alist for JSON objects
            (json-array-type 'list)   ; Use list for JSON arrays
            (json-key-type 'string))  ; Use strings for JSON keys
        (json-encode (org-element-to-json org-data))))))


(defun print-org-buffer-json ()
  "Parse the current Org buffer and print its JSON representation in the minibuffer."
  (interactive)
  (when (derived-mode-p 'org-mode)
    (message "%s" (org-buffer-to-json))))


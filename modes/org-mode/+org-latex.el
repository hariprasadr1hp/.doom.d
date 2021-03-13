;;; modes/org-mode/+org-latex.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; latex environment in org-mode
;;-------------------------------------------------------------

;; Continous numbering of org-mode equations
;; reference link https://www.youtube.com/watch?v=pcMuJlUvKCw
(defun org-renumber-environment (orig-func &rest args)
  ((let ((results) '())
    (counter -1)
    (numberp))

   (setq results (loop for (begin . env) in
                       (org-element-map (org-element-parse-buffer) 'latex-environment
                         (lambda (env)
                           (cons
                           (org-element-property :begin env)
                           (org-element-property :value env))))
                       collect
                       (cond
                       ((and (string-match "\\\\begin{equation}" env)
                             (not (string-match "\\\\tag{" env)))
                        (incf counter)
                        (cons begin counter))
                       ((string-match "\\\\begin{align}" env)
                        (prog2
                            (incf counter)
                            (cons begin counter)
                          (with-temp-buffer
                            (insert env)
                            (goto-char (point-min))
                            ;; \\ is used for a new line. Each one leads to a number
                            (incf counter (count-matches "\\\\$"))
                            ;; unless there are no numbers
                            (goto-char (point-min))
                            (decf counter (count-matches "\\nonumber")))))
                       (t
                        (cons begin nil)))))

  (when (setq numberp (cdr (assoc (point) results)))
    (setf (car args)
          (concat
           (format "\\setcounter{equation}{%s}\n" numberp)
           (car args)))))

(apply orig-func args))

(advice-add 'org-create-formula-image :around #'org-renumber-environment)

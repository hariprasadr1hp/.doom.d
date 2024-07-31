;; hp_modules/+insert_datetime.el --- Insert current date and time

(defun insert-current-datetime ()
  "Insert the current date and time at point."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))


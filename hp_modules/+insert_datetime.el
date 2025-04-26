;; hp_modules/+insert_datetime.el

(defun hp-insert-current-datetime ()
  "insert current date and time at point."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))


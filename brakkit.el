(defun brakkit-fill-string (template defns)
  "Fill in a TEMPLATE string using the values from the DEFINITIONS alist."
  (with-temp-buffer
    (insert template)
    (beginning-of-buffer)
    (while (search-forward-regexp
	    "{{[[:space:]]*\\([[:word:]_\\-]+\\)[[:space:]]*}}" nil t )
      (replace-match (alist-get (intern (match-string 1)) defns)))
    (buffer-string)))

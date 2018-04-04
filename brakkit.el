(defun brakkit-fill-string (template defns)
  "Fill in a TEMPLATE string using the values from the DEFNS alist."
  (with-temp-buffer
    (insert template)
    (beginning-of-buffer)
    (while (search-forward-regexp
	    "{{[[:space:]]*\\([[:word:]_\\-]+\\)[[:space:]]*}}" nil t )
      (replace-match (brakkit--get-defn (intern (match-string 1)) defns)))
    (buffer-string)))

(defun brakkit--alistp (list)
  "Return t if LIST is an association list.

For Brakkit, an association list is defined as a list that only
contains cons cells (pairs)."
  (when (listp list)
    (cl-loop for cell in list
	     always (consp cell))))

(defun brakkit--get-defn (key defns)
  "Intelligently extract a value (as a string) from DEFNS given a KEY.

DEFNS can be either an association list or hash table."
  (prin1-to-string (cond ((brakkit--alistp defns) (alist-get key defns))
			 ((hash-table-p defns)    (gethash key defns)))))

(provide 'brakkit)

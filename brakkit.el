(defvar brakkit--variable-regexp
  "{$[[:space:]]*\\([[:word:]_\\-]+\\)[[:space:]]*$}")

(defun brakkit-fill-string (template defns)
  "Fill in a TEMPLATE string using the values from the DEFNS alist."
  (with-temp-buffer
    (insert template)
    (beginning-of-buffer)
    (while (search-forward-regexp
	      brakkit--variable-regexp nil t )
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
  (brakkit--to-string
   (cond ((brakkit--alistp defns) (alist-get key defns))
	 ((hash-table-p defns)    (gethash key defns)))))

(defun brakkit--to-string (item)
  "Intelligently convert things to string."
  (if (stringp item) item
    (prin1-to-string item)))

(provide 'brakkit)

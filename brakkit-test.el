(require 'ert)
(require 'brakkit)

(ert-deftest regexp-whitespace-insignificant ()
  "Keep the regexp for tags where the whitespace is not important."
  (let ((inp1 "Hello, Master {$ name $}.") ; normal
  	(inp2 "I am your butler, {$butler-name$}.") ; compressed
  	(inp3 "Would you care for some {$ drink$}?") ; irregular
	(inp4 "Surely it would {$    verb $} your {$noun  $}.") ; v. irregular
	(inp5 "Deary me your dentist appointment's in {$ time
$} minutes!"))				; newline (please don't do this)
    (should (string= (brakkit-fill-string inp1 '((name . "Rocky")))
		     "Hello, Master Rocky."))
    (should (string= (brakkit-fill-string inp2 '((butler-name . "Jeeves")))
		     "I am your butler, Jeeves."))
    (should (string= (brakkit-fill-string inp3 '((drink . "marmalade")))
		     "Would you care for some marmalade?"))
    (should (string= (brakkit-fill-string inp4 '((verb . "quench")
						 (noun . "thirst")))
		     "Surely it would quench your thirst."))
    (should (string= (brakkit-fill-string inp5 '((time . 5)))
		     "Deary me your dentist appointment's in 5 minutes!"))))

(ert-deftest fill-string-with-alist ()
  "Check on `brakkit-fill-string' using an association list as DEFNS."
  (let ((inp1 "The Ghost of {$ holiday $} Past")
	(inp2 "I would like to {$verb$} {$number$} burgers, please."))
    (should (string= "The Ghost of Decemberween Past"
		     (brakkit-fill-string inp1 '((holiday . "Decemberween")))))
    (should (string= "I would like to order 12 burgers, please."
		     (brakkit-fill-string inp2 '((verb . "order")
						 (number . 12)))))))

(provide 'brakkit-test)

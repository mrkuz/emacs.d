(defun my/create-scratch ()
  "Create a new scratch buffer."
  (interactive)
  (let ((scratch (generate-new-buffer "*scratch*")))
    (switch-to-buffer scratch)
    (funcall initial-major-mode)
    scratch))

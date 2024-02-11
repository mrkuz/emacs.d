(require 'org-protocol)

;; Make capture window the only one
(defun my//org-protocol-capture-hook ()
  (let ((name (cdr (assoc 'name (frame-parameters)))))
    (when (equal name "org-protocol-capture")
      (delete-other-windows)
      (modify-frame-parameters nil '((z-group . above)))
      (select-frame-set-input-focus (selected-frame)))))

(add-hook 'org-capture-mode-hook 'my//org-protocol-capture-hook)

;; Delete frame after done
(defun my//org-protocol-after-capture-hook ()
  (let ((name (cdr (assoc 'name (frame-parameters)))))
    (when (equal name "org-protocol-capture")
      (delete-frame))))

(add-hook 'org-capture-after-finalize-hook 'my//org-protocol-after-capture-hook)

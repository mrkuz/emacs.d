(defvar-local my//symbol-overlay nil)

(defun my//symbol-overlay-timer-fn ()
  (if my//symbol-overlay (delete-overlay my//symbol-overlay))
  (setq symbol (thing-at-point 'symbol nil))
  (if (and symbol (string-match "[[:alnum:]]+" symbol))
      (save-excursion
        (beginning-of-thing 'symbol)
        (let* ((symbol-length (length symbol))
               (symbol-end (+ (point) symbol-length)))
          (setq my//symbol-overlay (make-overlay (point) symbol-end))
          (overlay-put my//symbol-overlay 'face 'bold)))))

(run-with-idle-timer 0 t 'my//symbol-overlay-timer-fn)

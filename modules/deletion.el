;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/hungry-delete-backward ()
  "Collapse the whitespace or the empty lines before point, leaving one."
  (interactive)
  (let* ((space (save-excursion (skip-chars-backward " \t") (point)))
         (line (save-excursion (skip-chars-backward "\n") (point)))
         ;; Point's own line counts when it is empty
         (keep (if (eolp) 1 2)))
    (cond
     ;; Trailing whitespace goes entirely
     ((and (eolp) (> (point) space))
      (delete-region space (point)))
     ((> (- (point) space) 1)
      (delete-region space (1- (point))))
     ((and (bolp) (> (- (point) line) keep))
      (delete-region (+ line keep) (point)))
     (t (call-interactively #'delete-backward-char)))))

(defun my/hungry-delete-forward ()
  "Collapse the whitespace or the empty lines after point, leaving one."
  (interactive)
  (let* ((space (save-excursion (skip-chars-forward " \t") (point)))
         (line (save-excursion (skip-chars-forward "\n") (point)))
         ;; Point's own line counts when it is empty
         (keep (if (bolp) 1 2)))
    (cond
     ;; Trailing whitespace goes entirely
     ((and (> space (point)) (save-excursion (goto-char space) (eolp)))
      (delete-region (point) space))
     ((> (- space (point)) 1)
      (delete-region (1+ (point)) space))
     ((and (eolp) (> (- line (point)) keep))
      (delete-region (point) (- line keep)))
     (t (call-interactively #'delete-forward-char)))))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

;; Filled below, so reloading updates the bindings
(defvar my//hungry-delete-mode-map (make-sparse-keymap)
  "Keymap for `my/hungry-delete-mode'.")

(define-key my//hungry-delete-mode-map (kbd "DEL") #'my/hungry-delete-backward)
(define-key my//hungry-delete-mode-map (kbd "C-d") #'my/hungry-delete-forward)
(define-key my//hungry-delete-mode-map (kbd "<deletechar>") #'my/hungry-delete-forward)

;; A minor mode, because major modes bind DEL and outrank the global map
(define-minor-mode my/hungry-delete-mode
  "Delete whitespace before and after point in one go."
  :global t
  :keymap my//hungry-delete-mode-map)

(my/hungry-delete-mode 1)

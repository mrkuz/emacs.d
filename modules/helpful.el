(defconst my//helpful-buffer "*Helpful*")

;; Re-use one buffer instead of creating new ones
(defun my//helpful-switch-buffer (source)
  (with-help-window my//helpful-buffer
    (with-current-buffer my//helpful-buffer
      (insert-buffer-substring source)
      (kill-buffer source))))

;; Fold some sections
(defun my//helpful-show-hook ()
  (when (string-equal (buffer-name) my//helpful-buffer)
    (goto-char (point-min))
    (setq sections '("References" "Debugging" "Aliases" "Source Code" "Alias Source Code" "Symbol Properties")
          start 0
          end 0)
    ;; Search for beginning of section
    (while (and sections (= start 0))
      (setq current (car sections)
            sections (cdr sections)
            start (search-forward-regexp (concat "^" current) nil t)))
    ;; Fold until next section
    (while sections
      (setq current (car sections)
            sections (cdr sections)
            end (search-forward-regexp (concat "^" current) nil t))
      (when end
        (yafolding-hide-region start (- end (length current) 2))
        (setq start end)))
    ;; Fold rest
    (yafolding-hide-region start (point-max))
    (goto-char (point-min))))

(add-hook 'temp-buffer-window-show-hook 'my//helpful-show-hook)

(use-package helpful
  :demand t
  :config
  (setq helpful-switch-buffer-function 'my//helpful-switch-buffer))


(defconst my/helpful-buffer "*Helpful*")

;; Re-use one buffer instead of creating new ones
(defun my/helpful-switch-buffer (source)
  (with-help-window my/helpful-buffer
    (with-current-buffer my/helpful-buffer
      (insert-buffer-substring source)
      (kill-buffer source))))

(use-package helpful
  :demand t
  :config
  (setq helpful-switch-buffer-function 'my/helpful-switch-buffer))

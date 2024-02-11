(defconst my//helpful-buffer "*Help*")

;; Re-use one buffer instead of creating new ones
(defun my//helpful-switch-buffer (source)
  (with-help-window my//helpful-buffer
    (with-current-buffer my//helpful-buffer
      (insert-buffer-substring source)
      (kill-buffer source))))

(use-package helpful
  :init
  (setq helpful-switch-buffer-function 'my//helpful-switch-buffer)
  (require 'help-fns)
  (defalias 'describe-function 'helpful-function)
  (defalias 'describe-variable 'helpful-variable)
  (defalias 'describe-symbol 'helpful-symbol))


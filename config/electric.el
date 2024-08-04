(use-package electric
  :ensure nil
  :init
  ;; Automatically close parens
  (electric-pair-mode 1)
  ;; Don't insert closing pair before non-whitespace characters and for '<'
  (setq-default electric-pair-inhibit-predicate
                (lambda (c)
                  (cond
                   ((char-equal c ?<) t)
                   ((eq (char-after) nil) nil)
                   ((eq (char-syntax (char-after)) ?w) t)))))

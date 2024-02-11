(use-package embark
  :init
  ;; Select action with completion-read
  (setq embark-prompter 'embark-completing-read-prompter)
  ;; Switch from completion-read to keymap prompt
  (setq embark-keymap-prompter-key ";")
  ;; Only highlight target on act
  (setq embark-indicators '(embark-highlight-indicator)))
(use-package embark-consult)

;; See: https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-height 28
        doom-modeline-bar-width 1
        doom-modeline-project-detection 'project
        doom-modeline-buffer-file-name-style 'auto
        doom-modeline-highlight-modified-buffer-name t
        doom-modeline-time-icon nil
        doom-modeline-position-column-line-format '("C%c L%l")
        doom-modeline-minor-modes t
        doom-modeline-indent-info t
        doom-modeline-total-line-number t
        doom-modeline-modal nil
        doom-modeline-modal-icon nil
        doom-modeline-gnus nil
        doom-modeline-irc nil
        doom-modeline-battery nil
        doom-modeline-env-version nil)
  ;; Use same background color for active and inactive mode-line
  (add-hook 'doom-modeline-mode-hook (lambda()
                                       (set-face-attribute 'mode-line-inactive nil :background (face-background 'mode-line))
                                       (set-face-attribute 'mode-line nil :box (list :line-width 5 :color (face-background 'default)))
                                       (set-face-attribute 'mode-line-inactive nil :box (list :line-width 5 :color (face-background 'default))))))


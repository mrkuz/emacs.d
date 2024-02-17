;; See: https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-height 28
        doom-modeline-bar-width 4
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
  :config
  ;; Avoid cut-off on right side
  ;; See: https://github.com/doomemacs/doomemacs/issues/2967
  ;; And: https://github.com/seagle0128/doom-modeline/blob/master/doom-modeline.el#L90
  (doom-modeline-def-modeline 'main
    '(eldoc bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker time " "))
)

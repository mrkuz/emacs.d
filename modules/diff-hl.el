;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package diff-hl
  :custom
  ;; Capped by the fringe width, the default is 16 pixels
  (diff-hl-bmp-max-width 4)
  ;; Show staged changes separately, as "reference" indicators
  (diff-hl-show-staged-changes nil)
  ;; The default is an empty bitmap, which only shows via a background
  (diff-hl-fringe-flat-bmp 'diff-hl-bmp-middle)
  :config
  (global-diff-hl-mode 1)
  ;; Under a daemon there is no frame yet, so the bitmaps are skipped
  (add-hook 'server-after-make-frame-hook #'diff-hl-maybe-redefine-bitmaps))

(custom-set-faces
 '(diff-hl-insert ((t (:background unspecified))))
 '(diff-hl-delete ((t (:background unspecified))))
 '(diff-hl-change ((t (:background unspecified))))
 ;; Staged changes are greyed out, `shadow' is too dark to make out
 '(diff-hl-reference-insert ((t (:foreground "#767679" :background unspecified))))
 '(diff-hl-reference-delete ((t (:foreground "#767679" :background unspecified))))
 '(diff-hl-reference-change ((t (:foreground "#767679" :background unspecified)))))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-git (:color blue :foreign-keys warn :hint nil)
  "
^Hunk^        ^Move^
----------------------------
_d_ Diff      _n_ Next
_r_ Revert    _p_ Previous
_s_ Stage
"
  ("d" diff-hl-show-hunk)
  ("r" diff-hl-revert-hunk)
  ("s" diff-hl-stage-dwim)
  ("n" diff-hl-next-hunk :color red)
  ("p" diff-hl-previous-hunk :color red)
  ("q" nil))

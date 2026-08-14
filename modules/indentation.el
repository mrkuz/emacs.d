;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Always indent with spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Indent first, then complete once the line is already indented
(setq tab-always-indent 'complete)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/untabify-region-or-buffer (orig-fn &rest args)
  "Call ORIG-FN on the region, or on the whole buffer when there is none."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (apply orig-fn args))
(advice-add 'untabify :around #'my/untabify-region-or-buffer)

;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Needed to answer org-protocol:// URLs
(require 'org-protocol)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-protocol-capture-single-window ()
  "Give the capture buffer the whole dedicated org-protocol frame."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-other-windows)))
(add-hook 'org-capture-mode-hook #'my//org-protocol-capture-single-window)

(defun my//org-protocol-capture-cleanup (&rest _)
  "Delete the dedicated org-protocol capture frame once capture ends."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-frame)))
(add-hook 'org-capture-after-finalize-hook #'my//org-protocol-capture-cleanup)

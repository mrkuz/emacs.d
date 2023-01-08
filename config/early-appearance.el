;;--------------------------------------------------------------------------------------------------
;; Frame
;;--------------------------------------------------------------------------------------------------

;; Set up initial frame position and size
(setq default-frame-alist '(
                            (width . 140)
                            (height . 50)
                            (cursor-color . "#e1e1e0")))
;; Show buffer name in frame title
(setq-default frame-title-format '("Emacs - %b"))

;;--------------------------------------------------------------------------------------------------
;; Theme
;;--------------------------------------------------------------------------------------------------

(load-theme 'misterioso t)

;;--------------------------------------------------------------------------------------------------
;; Miscellaneous
;;--------------------------------------------------------------------------------------------------

;; Disable toolbar
(tool-bar-mode 0)
;; Disable menu bar
(menu-bar-mode 0)
;; Disable scroll bar
(scroll-bar-mode 0)

;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

;; Remap every `undo' binding, so undo never drifts into redo
(global-set-key [remap undo] 'undo-only)
(global-set-key (kbd "C-x U") 'undo-redo)

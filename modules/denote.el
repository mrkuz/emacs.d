;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package denote
  :custom
  ;; Keeps notes beside the journal and archive
  (denote-directory (expand-file-name "notes" org-directory))
  :config
  ;; Shows the note title in the buffer name, instead of the identifier
  (denote-rename-buffer-mode 1))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/denote-search ()
  "Search the notes directory."
  (interactive)
  (consult-ripgrep denote-directory))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-denote (:color blue :foreign-keys warn :hint nil)
  "
^Notes^        ^Links^
----------------------------
_o_ Open       _l_ Link
_s_ Search     _b_ Backlinks
_r_ Rename
"
  ("o" denote-open-or-create)
  ("s" my/denote-search)
  ("r" denote-rename-file)
  ("l" denote-link)
  ("b" denote-backlinks)
  ("q" nil))

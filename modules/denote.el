;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package denote
  :custom
  ;; Keeps notes beside the journal and archive
  (denote-directory (expand-file-name "notes" org-directory))
  ;; Suggests only keywords already used, instead of the stock examples
  (denote-known-keywords nil)
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
_s_ Search     _l_ Link
_r_ Rename     _b_ Backlinks
"
  ("s" my/denote-search)
  ("r" denote-rename-file)
  ("l" denote-link)
  ("b" denote-backlinks)
  ("q" nil))

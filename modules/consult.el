;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package consult
  :bind (([remap goto-line] . consult-goto-line)
         ([remap imenu] . consult-imenu)
         ([remap bookmark-jump] . consult-bookmark)
         ("M-s r" . consult-ripgrep)))

;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

;; Wait for age, needed to decrypt below
(elpaca-wait)

(defun my//age-load-file (encrypted-file)
  "Decrypt and evaluate ENCRYPTED-FILE as Elisp."
  (with-temp-buffer
    (age-file-insert-file-contents encrypted-file)
    ;; The decrypted buffer carries no cookie, which `eval-buffer' warns about
    (setq-local lexical-binding t)
    (eval-buffer)))

(my//age-load-file (expand-file-name "secrets.el.age" user-emacs-directory))

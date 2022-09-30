(defun my/get-menu-alist ()
  (setq items (lacarte-get-overall-menu-item-alist '(global local minor)))
  (seq-remove (lambda (item) (not (symbolp (cdr item)))) items))

(defun my/lacarte ()
  "Execute menu bar command."
  (interactive)
  (let* (
         (items (my/get-menu-alist))
         (selection (completing-read "Menu " items))
         (command (cdr (assoc selection items))))
    (call-interactively command)))

(defun my/menu-annotator (cand)
  (let* (
         (items (my/get-menu-alist))
         (command (cdr (assoc cand items))))
    (marginalia-annotate-command command)))

(add-to-list 'marginalia-prompt-categories '("\\<Menu\\>" . menu))
(add-to-list 'marginalia-annotator-registry '(menu my/menu-annotator))

(use-package lacarte
  :demand t)

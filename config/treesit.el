(setq treesit-language-source-alist
      '((nix "https://github.com/nix-community/tree-sitter-nix")))

(defun my/treesit-install-languages()
  "Install missing grammar libraries"
  (interactive)
  (dolist (lang treesit-language-source-alist)
    (unless (treesit-language-available-p (car lang))
      (treesit-install-language-grammar (car lang)))))


(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
         ("\\.yml\\'" . yaml-mode)))

(use-package dockerfile-mode
  :mode (("Dockerfile\\'" . dockerfile-mode)))

(use-package docker-compose-mode
  :mode (("docker-compose.yaml\\'" . docker-compose-mode)
         ("docker-compose.yml\\'" . docker-compose-mode)))

(use-package nix-mode
  :mode (("\\.nix\\'" . nix-mode)))

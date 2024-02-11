(defun my//file-to-string (file)
  "File to string function"
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(use-package chatgpt-shell
  :init
  (setq chatgpt-shell-openai-key (my//file-to-string "~/etc/openai/api.key"))
  (setq chatgpt-shell-model-version "gpt-3.5-turbo-16k"))

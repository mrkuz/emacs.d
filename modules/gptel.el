(defvar my//gptel-default-chat "*Chat*")
(defvar my//gptel-code-directive
  "
Role:
- You are a senior software engineer

Instructions:
- Focus on correctness and readability

Output:
- Return only code
- Include comments if applicable
- Do NOT use markdown code fences
")
(defvar my//gptel-history nil)

;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package gptel
  :demand t
  ;; :hook ((gptel-mode . markdown-toggle-markup-hiding))
  :bind (:map gptel-mode-map
              ("C-c C-c" . gptel-send))
  :config
  (require 'gptel-rewrite)
  (add-hook 'gptel-post-response-functions 'my/gptel-clean-blank-lines)
  (gptel-make-preset 'code
    :system my//gptel-code-directive)
  (setq my//gptel-minimax-backend (gptel-make-anthropic my//gptel-default-chat
                              :stream t
                              :protocol "https"
                              :host "api.minimax.io"
                              :endpoint "/anthropic/v1/messages"
                              :models '("MiniMax-M2.7")
                              :key my//secrets-minimax-api-key))
  (setq my//gptel-copilot-backend (gptel-make-gh-copilot my//gptel-default-chat))
  ;; (setq gptel-backend my//gptel-minimax-backend)
  (setq gptel-backend my//gptel-copilot-backend)
  :custom
  (gptel-model 'gpt-4.1)
  (gptel-prompt-prefix-alist
        '((markdown-mode . "### ")
          (org-mode . "*** ")
          (text-mode . "### ")))
  ;; (gptel-include-reasoning nil)
  (gptel-rewrite-default-action 'merge))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//gptel-process-prompt (prompt)
  "Replace presets from prompt and split into system and user prompts"
  (let ((system-prompts '())
        (user-prompt prompt))
    (while (string-match "@\\([a-z]+\\)" user-prompt)
      (let* ((preset-name (match-string 1 user-prompt))
             (preset-plist (alist-get preset-name gptel--known-presets nil nil #'string=))
             (system-prompt (plist-get preset-plist :system)))
        (when system-prompt
          (push system-prompt system-prompts))
        (setq user-prompt (replace-match "" nil nil user-prompt))))
    (setq user-prompt (string-trim user-prompt))
    (list :system (when system-prompts
                    (string-join (nreverse system-prompts) "\n\n"))
          :user (unless (string-empty-p user-prompt)
                  user-prompt))))

(defun my/gptel-chat ()
  "Open gptel chat"
  (interactive)
  (pop-to-buffer (gptel my//gptel-default-chat)))

(defun my/gptel-send-to-chat (prompt region)
  "Send prompt to gptel chat"
  (interactive (list (read-string "Prompt: " nil my//gptel-history)
                     (when (use-region-p)
                       (filter-buffer-substring (region-beginning) (region-end)))))
  (gptel my//gptel-default-chat)
  (with-current-buffer my//gptel-default-chat
    (insert prompt)
    (when region
      (insert "\n" region))
    (gptel-send)
    (pop-to-buffer (current-buffer))))

(defun my/gptel-ask (prompt region)
  "Ask gptel"
  (interactive (list (read-string "Prompt: " nil my//gptel-history)
                     (when (use-region-p)
                       (filter-buffer-substring (region-beginning) (region-end)))))
  (let* ((prompts (my//gptel-process-prompt prompt))
         (user-prompt (plist-get prompts :user))
         (full-prompt (if region (concat user-prompt "\n" region) user-prompt)))
    (gptel-request full-prompt
      :system (plist-get prompts :system)
      :callback (lambda (response info)
                  (when response
                    (let ((buf (get-buffer-create "*gptel-response*")))
                      (with-current-buffer buf
                        (read-only-mode -1)
                        (erase-buffer)
                        (insert response)
                        (goto-char (point-min))
                        (markdown-view-mode))
                      (pop-to-buffer buf)))))))

(defun my/gptel-insert (prompt)
  "Ask gptel to generate content"
  (interactive (list (read-string "Insert: " nil my//gptel-history)))
  (let* ((prompts (my//gptel-process-prompt prompt))
         (user-prompt (plist-get prompts :user)))
    (gptel-request user-prompt
      :system (plist-get prompts :system)
      :callback (lambda (response info)
                  (when response
                    (insert response))))))

(defun my/gptel-rewrite (prompt)
  "Ask gptel to rewrite"
  (interactive (list (read-string "Rewrite: " nil my//gptel-history)))
  (gptel--suffix-rewrite prompt))

(defun my/gptel-clean-blank-lines (&rest _)
  "Collapse multiple blank lines into one."
  (while (re-search-forward "^\\s-*\n\\s-*\n" nil t)
    (replace-match "\n"))
  (goto-char (point-max)))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-gptel (:color blue :hint nil)
  "
 ^Chat^                ^Edit^
 ----------------------------------
 _o_: Open chat        _a_: Ask
 _s_: Send to chat     _i_: Insert
 ^ ^                   _r_: Rewrite
 "
  ("o" my/gptel-chat)
  ("s" my/gptel-send-to-chat)
  ("r" my/gptel-rewrite)
  ("i" my/gptel-insert)
  ("a" my/gptel-ask)
  ("q" nil))

(defvar my//gptel-default-chat "*Chat*")
(defvar my//gptel-code-directive
  "
Role:
- You are a senior software engineer

Instructions:
- Focus on correctness and readability
- Match the conventions, style, and indentation of the surrounding code
- Infer the language from context

Output:
- Output only the code — no prose, no explanation, no preamble or closing remarks
- Do NOT wrap the code in markdown fences
- Add comments only for non-obvious logic
- If the task cannot be completed, return a short code comment saying why
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
  ;; Loads `gptel-rewrite' so its command and `gptel-rewrite-default-action' are available
  (require 'gptel-rewrite)
  (add-hook 'gptel-post-response-functions 'my//gptel-clean-blank-lines)
  (gptel-make-preset 'code
    :system my//gptel-code-directive)
  (setq my//gptel-minimax-backend (gptel-make-anthropic "MiniMax"
                              :stream t
                              :protocol "https"
                              :host "api.minimax.io"
                              :endpoint "/anthropic/v1/messages"
                              :models '("MiniMax-M2.7")
                              :key my//secrets-minimax-api-key))
  (setq my//gptel-copilot-backend (gptel-make-gh-copilot "Copilot"))
  ;; Active backend; comment this line and uncomment the other to switch providers
  ;; (setq gptel-backend my//gptel-minimax-backend)
  (setq gptel-backend my//gptel-copilot-backend)
  :custom
  ;; Default model to send with the active backend
  (gptel-model 'gpt-4.1)
  (gptel-prompt-prefix-alist
        '((markdown-mode . "### ")
          (org-mode . "*** ")
          (text-mode . "### ")))
  ;; (gptel-include-reasoning nil)
  ;; Merge rewrites into the buffer automatically instead of opening the action menu
  (gptel-rewrite-default-action 'merge))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//gptel-process-prompt (prompt)
  "Extract @preset tokens from PROMPT; return a plist of combined :system text and the remaining :user text."
  (let ((system-prompts '())
        (user-prompt prompt)
        (pos 0))
    (while (string-match "@\\([a-z]+\\)" user-prompt pos)
      (let* ((preset-name (match-string 1 user-prompt))
             (preset-plist (alist-get preset-name gptel--known-presets nil nil #'string=))
             (system-prompt (plist-get preset-plist :system)))
        (if system-prompt
            ;; Known preset: collect its directive and drop the token, then
            ;; keep scanning from the same spot (the text shrank).
            (progn
              (push system-prompt system-prompts)
              (setq user-prompt (replace-match "" nil nil user-prompt)))
          ;; Unknown token (e.g. a handle): leave it and scan past it.
          (setq pos (match-end 0)))))
    (setq user-prompt (string-trim user-prompt))
    (list :system (when system-prompts
                    (string-join (nreverse system-prompts) "\n\n"))
          :user (unless (string-empty-p user-prompt)
                  user-prompt))))

(defun my/gptel-chat ()
  "Open (or switch to) the persistent gptel chat buffer."
  (interactive)
  (pop-to-buffer (gptel my//gptel-default-chat)))

(defun my/gptel-send-to-chat (prompt region)
  "Insert PROMPT and any active region into the chat buffer and send it."
  (interactive (list (read-string "Prompt: " nil my//gptel-history)
                     (when (use-region-p)
                       (filter-buffer-substring (region-beginning) (region-end)))))
  (gptel my//gptel-default-chat)
  (with-current-buffer my//gptel-default-chat
    ;; Append to the end of the conversation, wherever point currently is
    (goto-char (point-max))
    (insert prompt)
    (when region
      (insert "\n" region))
    (gptel-send)
    (pop-to-buffer (current-buffer))))

(defun my/gptel-ask (prompt region)
  "Ask a one-off question (expanding @presets, including any region); show the answer in a separate buffer."
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
  "Generate text for PROMPT (expanding @presets) and insert it at point."
  (interactive (list (read-string "Insert: " nil my//gptel-history)))
  (let* ((prompts (my//gptel-process-prompt prompt))
         (user-prompt (plist-get prompts :user)))
    (gptel-request user-prompt
      :system (plist-get prompts :system)
      :callback (lambda (response info)
                  ;; Insert at the buffer/position captured by gptel when the
                  ;; request was sent, not wherever point drifted to since.
                  (when (stringp response)
                    (let ((buffer (plist-get info :buffer))
                          (pos (plist-get info :position)))
                      (when (buffer-live-p buffer)
                        (with-current-buffer buffer
                          (save-excursion
                            (goto-char pos)
                            (insert response))))))))))

(defun my//gptel-clean-blank-lines (beg end)
  "Collapse multiple blank lines into one within the response (BEG..END)."
  (let ((end-marker (copy-marker end)))
    (goto-char beg)
    (while (re-search-forward "^\\s-*\n\\s-*\n" end-marker t)
      (replace-match "\n"))
    (set-marker end-marker nil))
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
 "
  ("o" my/gptel-chat)
  ("s" my/gptel-send-to-chat)
  ("i" my/gptel-insert)
  ("a" my/gptel-ask)
  ("q" nil))

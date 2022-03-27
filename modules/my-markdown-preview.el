(use-package simple-httpd
  :straight (simple-httpd :type git :host github :repo "skeeto/emacs-web-server")
  :config
  (setq httpd-port 7070))

(use-package impatient-mode)

(defun my/markdown-filter (buffer)
  (princ
   (with-temp-buffer
     (let ((tmp (buffer-name)))
       (set-buffer buffer)
       (set-buffer (markdown tmp))
       (format
        "<!DOCTYPE html>\
          <html>\
            <title>Markdown preview</title>\
            <link rel=\"stylesheet\" href = \"%s\"/>\
            <body>\
              <article class=\"markdown-body\"
                       style=\"box-sizing: border-box; min-width: 200px ;max-width: 980px; margin: 0 auto; padding: 45px;\">\
                %s\
              </article>\
            </body>\
          </html>"
        "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown-light.css"
        (buffer-string))))
   (current-buffer)))

(defun my/markdown-preview ()
  "Preview markdown."
  (interactive)
  (unless (process-status "httpd")
    (httpd-start))
  (impatient-mode)
  (imp-set-user-filter 'my/markdown-filter)
  (imp-visit-buffer))

(use-package simple-httpd
  :config
  (setq httpd-port 7070))

(use-package impatient-mode)

;; Render GitHub-style
(defun my//markdown-filter (buffer)
  (princ (with-current-buffer buffer
           (format
            "<!DOCTYPE html>\
             <html>\
               <head>\
                 <title>Markdown preview</title>\
                 <link rel=\"stylesheet\" type=\"text/css\" href=\"%s\"/>\
                 <script src=\"%s\"></script>\
               </head>\
               <body>\
                 <div id=\"content\"\
                   class=\"markdown-body\"
                   style=\"box-sizing: border-box; min-width: 200px ;max-width: 980px; margin: 0 auto; padding: 45px;\">%s\
                 </div>\
                 <script>\
                 var converter = new showdown.Converter();\
                 var markdown = document.getElementById('content').innerHTML;\
                 document.getElementById('content').innerHTML = converter.makeHtml(markdown);\
                 </script>\
              </body>\
            </html>"
            "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown-light.css"
            "https://cdnjs.cloudflare.com/ajax/libs/showdown/2.1.0/showdown.min.js"
            (buffer-substring-no-properties (point-min) (point-max))))
         (current-buffer)))

(defun my/markdown-preview ()
  "Preview markdown."
  (interactive)
  (unless (process-status "httpd")
    (httpd-start))
  (impatient-mode)
  (imp-set-user-filter 'my//markdown-filter)
  (imp-visit-buffer))


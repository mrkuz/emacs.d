(setq user-full-name "Markus Opitz"
      user-mail-address "markus@bitsandbobs.net"
      smtpmail-smtp-user user-mail-address
      send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465)

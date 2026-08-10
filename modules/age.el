;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package age
  :demand t
  :custom
  (age-default-identity '("~/.age/key.txt"))
  (age-default-recipient '("age12gcuvp4akxut4f7hdemzd90zjh3np58f9l4ze2m304qjfpl00uush30ens"))
  :config
  (age-file-enable))

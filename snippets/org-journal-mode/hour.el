# -*- mode: snippet -*-
# name: hour
# key: -@
# --
- [ ] ${1:$(make-string (max 0 (- 2 (string-width yas-text))) ?0)}${1:0}:${2:$(make-string (max 0 (- 2 (string-width yas-text))) ?0)}${2:0} $0

(use-package undo-fu
  :bind (([remap undo] . undo-fu-only-undo)
         ("C-x U" . undo-fu-only-redo)))

;;; modes/+deft.el -*- lexical-binding: t; -*-


(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-extensions '("org" "txt"))
  (deft-directory "~/my/org"))
  
      
      
      

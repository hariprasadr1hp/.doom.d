;;; modes/org-mode/+org-brain.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------
;; org-brain
;;-------------------------------------------------------------
(map! :ne "SPC n b" #'org-brain-visualize)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

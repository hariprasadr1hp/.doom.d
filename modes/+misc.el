;;; modes/+misc.el -*- lexical-binding: t; -*-

;; The way to indent your selection in Emacs is with the following keybinding:
;; + Use ~Control Shift .~ to indent right
;; + Use ~Control Shift ,~ to indent left
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)



;; commenting lines
(global-set-key (kbd "C-/") 'comment-line)


;; toggle menubar
(map! 
	:leader
	:desc "menu bar mode"
	"t m" #'menu-bar-mode)



;; Doom Emacs uses ~SPC t~ for "toggle" commands, so ~SPC t t~ is chosen for toggle-truncate-lines.
(setq display-line-numbers-type t)
(map!
	:leader
  	:desc "Toggle truncate lines"
	"t t" #'toggle-truncate-lines)




;;; modes/+dired.el -*- lexical-binding: t; -*-

;; Dired - file manager within Emacs


;; | COMMAND                                   | DESCRIPTION                                     | KEYBINDING |
;; | ----------------------------------------- | ----------------------------------------------- | ---------- |
;; | dired                                     | /Open dired file manager/                       | SPC d d    |
;; | dired-jump                                | /Jump to current directory in dired/            | SPC d j    |
;; | (in dired) peep-dired                     | /Toggle image previews within dired/            | SPC d p    |
;; | (in dired) dired-view-file                | /View file in dired/                            | SPC d v    |
;; | (in dired) dired-up-directory             | Go up in the directory tree                     | h          |
;; | (in dired) dired-find-file                | Go down in the directory tree (or open if file) | l          |
;; | (in peep-dired-mode) peep-dired-next-file | /Move to next file in peep-dired-mode/          | j          |
;; | (in peep-dired-mode) peep-dired-prev-file | /Move to previous file in peep-dired-mode/      | k          |
;; | ----------------------------------------- | ----------------------------------------------- | ---------- |


(map!
	:leader
	:desc "Dired" "d d" #'dired

	:leader
	:desc "Dired jump to current" "d j" #'dired-jump

	(:after dired
		(:map dired-mode-map
			:leader
			:desc "Peep-dired image previews" "d p" #'peep-dired

			:leader
			:desc "Dired view file" "d v" #'dired-view-file
		)
	)
)
;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
	(kbd "h") 'dired-up-directory
  	(kbd "l") 'dired-open-file
) ; use dired-find-file instead if not using dired-open package

;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
	(kbd "j") 'peep-dired-next-file
	(kbd "k") 'peep-dired-prev-file
)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions
	'(
		("gif" . "sxiv")
		("jpg" . "sxiv")
		("png" . "sxiv")
		("mkv" . "mpv")
		("mp4" . "mpv")
	)
)

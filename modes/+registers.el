;;; modes/+registers.el -*- lexical-binding: t; -*-

;; compartments/ to save text, rectangles and positions for later use

;; | COMMAND                          | DESCRIPTION                        | KEYBINDING |
;; | -------------------------------- | ---------------------------------- | ---------- |
;; | copy-to-register                 | /Copy to register/                 | SPC r c    |
;; | frameset-to-register             | /Frameset to register/             | SPC r f    |
;; | insert-register                  | /Insert contents of register/      | SPC r i    |
;; | jump-to-register                 | /Jump to register/                 | SPC r j    |
;; | list-registers                   | /List registers/                   | SPC r l    |
;; | number-to-register               | /Number to register/               | SPC r n    |
;; | counsel-register                 | /Interactively choose a register/  | SPC r r    |
;; | view-register                    | /View a register/                  | SPC r v    |
;; | window-configuration-to-register | /Window configuration to register/ | SPC r w    |
;; | increment-register               | /Increment register/               | SPC r +    |
;; | point-to-register                | /Point to register/                | SPC r SPC  |
;; | -------------------------------- | ---------------------------------- | ---------- |


(map!
	:leader
	:desc "Copy to register" "r c" #'copy-to-register

	:leader
	:desc "Frameset to register" "r f" #'frameset-to-register

	:leader
	:desc "Insert contents of register" "r i" #'insert-register

	:leader
	:desc "Jump to register" "r j" #'jump-to-register

	:leader
	:desc "List registers" "r l" #'list-registers

	:leader
	:desc "Number to register" "r n" #'number-to-register

	:leader
	:desc "Interactively choose a register" "r r" #'counsel-register

	:leader
	:desc "View a register" "r v" #'view-register

	:leader
	:desc "Window configuration to register" "r w" #'window-configuration-to-register

	:leader
	:desc "Increment register" "r +" #'increment-register

	:leader
	:desc "Point to register" "r SPC" #'point-to-register
)

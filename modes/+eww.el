;;; modes/+eww.el -*- lexical-binding: t; -*-

;; Emacs Web Wowser


;; | COMMAND          | DESCRIPTION                             | KEYBINDING |
;; | ---------------- | --------------------------------------- | ---------- |
;; | eww              | /Fetch URL and render the page/         | SPC k q    |
;; | eww-reload       | /Reload the current page/               | SPC k r    |
;; | eww-search-words | /Search the web for text/               | SPC k s    |
;; | eww-search-words | /Search the web for text/               | SPC s w    |
;; | eww-back-url     | /Go to the previously displayed page/   | SPC k b    |
;; | eww-forward-url  | /Go to the next displayed page/         | SPC k f    |
;; | eww-view-source  | /View the HTML source code of the page/ | SPC k i    |
;; | ---------------- | --------------------------------------- | ---------- |


(setq browse-url-browser-function 'eww-browse-url)
(map!
	:leader
	:desc "Eww web browser" "k q" #'eww

	:leader
	:desc "Eww reload page" "k r" #'eww-reload

	:leader
	:desc "Search web for text between BEG/END" "k s" #'eww-search-words

	:leader
	:desc "Search web for text between BEG/END" "s w" #'eww-search-words

	:leader
	:desc "Eww previous page" "k h" #'eww-back-url

	:leader
	:desc "Eww next page" "k l" #'eww-forward-url

	:leader
	:desc "Eww view source code" "k i" #'eww-view-source
)


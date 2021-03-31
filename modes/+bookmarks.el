;;; modes/+bookmarks.el -*- lexical-binding: t; -*-

;; | COMMAND        | DESCRIPTION             | KEYBINDING |
;; | -------------- | ----------------------- | ---------- |
;; | list-bookmarks | /List bookmarks/        | SPC b L    |
;; | bookmark-save  | /Save current bookmark/ | SPC b w    |
;; | -------------- | ----------------------- | ---------- |


(map!
 :leader
 :desc "List bookmarks" "b L" #'list-bookmarks

 :leader
 :desc "Save current bookmarks to bookmark file" "b w" #'bookmark-save)

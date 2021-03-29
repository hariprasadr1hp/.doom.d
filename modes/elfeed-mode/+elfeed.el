;;; modes/elfeed-mode/+elfeed.el -*- lexical-binding: t; -*-

(setq elfeed-db-directory "~/my/org/elfeed")

(map!
	:leader
	:desc "elfeed" "j j" #'elfeed

	:leader
	:desc "update all" "j U" #'elfeed-update

	:leader
	:desc "update feed" "j u" #'elfeed-update-feed

	:leader
	:desc "show-next" "j n" #'elfeed-show-next

	:leader
	:desc "show-prev" "j p" #'elfeed-show-prev
)

;;; modes/+emms.el -*- lexical-binding: t; -*-

;;Emacs Multimedia System.

;; | COMMAND                  | DESCRIPTION                                      | KEYBINDING |
;; | ------------------------ | ------------------------------------------------ | ---------- |
;; | emms                     | /Switch to the current emms-playlist buffer/     | SPC a q    |
;; | emms-playlist-mode-go    | /Switch to the playlist buffer/                  | SPC a a    |
;; | emms-pause               | /Pause the track/                                | SPC a s    |
;; | emms-stop                | /Stop the track/                                 | SPC a x    |
;; | emms-previous            | /Play previous track in playlist/                | SPC a p    |
;; | emms-next                | /Play next track in playlist/                    | SPC a n    |
;; | emms-toggle-repeat-track | /Toggles whether emms repeats the current track/ | SPC a r    |
;; | emms-volume-lower        | /Lower the speaker volume/                       | SPC a ,    |
;; | emms-volume-raise        | /Raise the speaker volume/                       | SPC a .    |
;; | emms-volume-backward     | /Seek ten seconds backward/                      | SPC a [    |
;; | emms-volume-forward      | /Seek ten seconds forward/                       | SPC a ]    |
;; | emms-shuffle             | /Shuffle the current playlist/                   | SPC a ~    |
;; | ------------------------ | ------------------------------------------------ | ---------- |


(require 'emms-setup)
(require 'emms-info)
(require 'emms-cue)
(require 'emms-mode-line)
(require 'emms-playing-time)
(emms-all)
(emms-default-players)
(emms-mode-line 1)
(emms-playing-time 1)

(setq
 emms-source-file-default-directory "~/Music/"
 emms-playlist-buffer-name "*Music*"
 emms-info-asynchronously t
 emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)


; (map!
;  :leader
;  :desc "Go to emms current" "a q" #'emms
;
;  :leader
;  :desc "Go to emms playlist" "a a" #'emms-playlist-mode-go
;
;  :leader
;  :desc "Emms pause track" "a s" #'emms-pause
;
;  :leader
;  :desc "Emms stop track" "a x" #'emms-stop
;
;  :leader
;  :desc "Emms stop track" "a X" #'emms-toggle-single-track
;
;  :leader
;  :desc "Emms play previous track" "a p" #'emms-previous
;
;  :leader
;  :desc "Emms play next track" "a n" #'emms-next
;
;  :leader
;  :desc "Emms toggle repeat track" "a r" #'emms-random
;
;  :leader
;  :desc "Emms toggle repeat track" "a R" #'emms-toggle-repeat-track
;
;  :leader
;  :desc "Emms volume lower" "a ," #'emms-volume-lower
;
;  :leader
;  :desc "Emms volume upper" "a ." #'emms-volume-raiseyy
;
;  :leader
;  :desc "Emms seek backward" "a [" #'emms-seek-backward
;
;  :leader
;  :desc "Emms seek forward" "a ]" #'emms-seek-forward
;
;  :leader
;  :desc "Emms shuffle" "a ~" #'emms-shuffle)

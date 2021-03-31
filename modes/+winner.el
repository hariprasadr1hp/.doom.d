;;; modes/+winner.el -*- lexical-binding: t; -*-

(map!
 :leader
 :desc "Winner redo" "w <right>" #'winner-redo

 :leader
 :desc "Winner undo" "w <left>" #'winner-undo)

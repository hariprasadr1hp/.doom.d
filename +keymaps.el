;;; +keymaps.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "Show *Messages* buffer"
      "o n" #'view-echo-area-messages)

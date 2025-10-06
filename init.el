;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they loaind a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input

       :completion
       (corfu +orderless)  ; complete with cap(f), cape and a flying feather!
       vertico           ; the search engine of the future

       :ui
       deft              ; notational velocity for Emacs--
       doom              ; what makes DOOM look the way it does
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)  ; 🙂--
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline            ; snazzy, Atom-inspired modeline, plus API
       neotree           ; a project drawer, like NERDTree for vim
       ophints             ; highlight the region an operation acts on
       (popup              ; tame sudden yet inevitable temporary windows
        +all
        +defaults)
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       (window-select
        +numbers)          ; visually switch windows--
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to

       :emacs
       (dired             ; making dired pretty [functional]
        +icons
        +open)
       electric          ; smarter, keyword-based electric-indent
       (undo
        +tree)         ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (:if (executable-find "aspell") spell)   ; tasing you for misspelling mispelling
       grammar           ; tasing grammar mistake every you make

       :tools
       (eval +overlay)     ; run code, run (also, repls)
       terraform           ; infra as code
       (lookup             ; navigate your code and its documentation
        +devdocs           ; devdocs online
        +dictionary
        +docsets)          ; devdocs locally

       lsp
       (magit +forge)    ; a git porcelain for Emacs

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       tty               ; improve the terminal Emacs experience--

       :lang
       common-lisp       ; if you've seen one lisp, you've seen them all
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       ess               ; emacs speaks statistics
       (haskell +lsp)      ; a language that's lazier than I am--
       json              ; At least it ain't XML--
       (javascript +lsp)        ; all(hope(abandon(ye(who(enter(here))))))--
       (latex             ; writing papers in Emacs has never been so fun--
        +latexmk          ; make for latex
        +cdlatex          ; quick maths symbols
        +fold)            ; fold the clutter away
       (lua +lsp)               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       (org                ; organize your plain life in plain text
        +attach
        +babel
        +capture
        +dragndrop         ; drap and drop files/images into org buffers
        +export
        +fancy-priorities
        +gnuplot           ; gnuplot for orgmode
        +ipython
        +journal
        +pandoc            ; export-with-pandoc support
        +roam2             ; wander around notes
        +present)           ; using org-mode for presentation
       (python            ; beautiful is better than ugly--
        +lsp
        +pyright)
       (ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       web               ; the tubes
       yaml              ; JSON, but readable--
       zig               ; C, but simpler

       :email
       (:if (executable-find "mu")(mu4e +org +gmail))

       :app
       irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader

       :config
       (default +bindings +snippets +evil-commands))

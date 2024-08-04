;;; modes/+corfu.el -*- lexical-binding: t; -*-

(use-package corfu
  ;; Optional customizations
  :custom
    (corfu-cycle t)                         ;; Enable cycling for `corfu-next/previous'
    (corfu-auto t)                          ;; Enable auto completion
    (corfu-auto-prefix 2)                   ;; Set Prefix
    (corfu-auto-delay 0.0)                  ;; Time delay to activate completion
  ;; (corfu-separator ?\s)                  ;; Orderless field separator
    (corfu-quit-at-boundary 'separator)     ;; Never quit at completion boundary
    (corfu-echo-documentation 0.25)         ;; 
    (corfu-preview-current 'insert)         ;; Do not preview current candidate
    (corfu-preselect-first nil)             ;; 
  ;; (corfu-quit-no-match nil)              ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)            ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)              ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)             ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)                ;; Use scroll margin

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :bind (:map corfu-map
              ("M-SPC"      . corfu-insert-separator)
              ("RET"        . nil)
              ("TAB"        . corfu-next)
              ([tab]        . corfu-next)
              ("S-TAB"      . corfu-previous)
              ([backtab]    . corfu-previous)
              ("S-<return>" . corfu-insert))
  :init
  ;; use corfu everywhere
  (global-corfu-mode))
  ;; save completion for better history
  (corfu-history-mode)

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))


(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))


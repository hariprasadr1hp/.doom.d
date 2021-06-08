;;; modes/lsp-mode/+lsp-lua.el -*- lexical-binding: t; -*-

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((lua-mode) . lsp)
  :config)

(use-package company-lsp
  ;;:ensure t
  :after lsp-mode
  :config
  (setq company-lsp-enable-recompletion t)
  ;(push company-lsp company-backends)
  (setq lsp-auto-configure nil))

(defun set-company-backends-for-lua()
  "Set lua company backend."
  (setq-local company-backends
              (quote
               ((company-lsp
                 company-lua
                 company-keywords
                 company-gtags
                 company-yasnippet)
                company-capf
                company-dabbrev-code
                company-files))))

(use-package lua-mode
  ;;:ensure t
  :mode "\\.lua$"
  :interpreter "lua"
  :hook (lua-mode . set-company-backends-for-lua)
  :config
  (setq lua-indent-level 4)
  (setq lua-indent-string-contents t)
  (setq lua-prefix-key nil))

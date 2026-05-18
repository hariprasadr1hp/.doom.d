;;; lang/+python.el -*- lexical-binding: t; -*-

(setq python-indent-level 4)

(let ((pyenv-shims (expand-file-name "~/.pyenv/shims"))
      (pyenv-bin   (expand-file-name "~/.pyenv/bin")))
  (add-to-list 'exec-path pyenv-shims)
  (add-to-list 'exec-path pyenv-bin)
  (setenv "PATH" (concat pyenv-shims ":" pyenv-bin ":" (getenv "PATH"))))

(setq python-shell-interpreter "python3"
      lsp-pyright-python-executable-cmd "python3"
      org-babel-python-command "python3")

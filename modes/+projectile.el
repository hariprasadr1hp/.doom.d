;;; modes/+projectile.el -*- lexical-binding: t; -*-

(after! projectile
  (setq projectile-project-search-path '("~/my/projects/" "~/my/org"))
  (setq projectile-project-root-files-bottom-up (remove ".git"
                                                        projectile-project-root-files-bottom-up)))

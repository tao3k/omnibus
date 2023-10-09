;;; .dir-locals.el --- description -*- lexical-binding: t; -*-
;;;
((nil . ((eval . (setq org-roam-directory (concat (shell-command-to-string
                                                   "git rev-parse --show-toplevel | tr -d '\n'")
                                                  "/docs/org")))
         (eval . (setq org-attach-id-dir (concat (shell-command-to-string
                                                  "git rev-parse --show-toplevel | tr -d '\n'")
                                                 "/docs/org/attach/")))
         (eval . (setq org-roam-db-location (concat (shell-command-to-string
                                                     "git rev-parse --show-toplevel | tr -d '\n'")
                                                    "/.cache/org-roam.db")))))
 (org-mode . ((org-tanglesync-mode . t)))
 )
;;;docs/org-mode-locals.el ends here

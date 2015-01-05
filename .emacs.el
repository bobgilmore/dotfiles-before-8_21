(global-set-key (kbd "C-c C-v") 'shell)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs_backups/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs_backups/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs_backups/autosaves/" t)

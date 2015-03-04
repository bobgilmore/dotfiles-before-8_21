(add-to-list 'load-path "~/.emacs.d/lisp/")

(global-set-key (kbd "C-c C-v") 'shell)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs_backups/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs_backups/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs_backups/autosaves/" t)

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))

(require 'highlight-chars)
(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)

(require 'ws-trim)
(global-ws-trim-mode t)
(set-default 'ws-trim-level 1)

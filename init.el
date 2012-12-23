;; turn off mouse interface
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; turn off splash screen
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

(setq user-emacs-directory "~/.emacs.d")
(add-to-list 'load-path user-emacs-directory)

(setq modules-dir (concat user-emacs-directory "modules"))
(add-to-list 'load-path modules-dir)

(setq themes-dir (concat user-emacs-directory "themes"))
(add-to-list 'load-path themes-dir)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

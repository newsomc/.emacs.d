;; turn off mouse interface
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; turn off splash screen
(setq inhibit-startup-message t)

;; turn off autosave/backup
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

;; path to scheme interpreter
(setq scheme-program-name "/usr/local/bin/stk-simply")

;; set source directory (used for viewing c functions)
(setq source-directory "~/projects/emacs/emacs-24.2")

;; setup load paths
(setq core-dir (concat user-emacs-directory "core"))
(setq defuns-dir (concat user-emacs-directory "defuns"))
(setq modules-dir (concat user-emacs-directory "modules"))
(setq themes-dir (concat user-emacs-directory "themes"))

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path core-dir)
(add-to-list 'load-path modules-dir)
(add-to-list 'load-path themes-dir)

;; load color theme
(require 'tomorrow-night-theme)

;; elpa packages
(require 'setup-package)
(require 'install-packages)

;; list/string libraries
(require 'cl)
(require 'dash)
(require 's)

;; load functions
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file) (load file)))

;; core
(require 'appearance)
(require 'sane-defaults)
(require 'key-bindings)

;; load modules
(dolist (file (directory-files modules-dir t "\\w+"))
  (require (intern (file-name-from-path-no-ext file))))

;; start emacs server
(require 'server)
(unless (server-running-p) (server-start))

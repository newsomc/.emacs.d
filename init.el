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
(setq scheme-program-name "/usr/local/bin/stk")

;; set source directory (used for viewing c functions)
(setq source-directory "~/projects/emacs/emacs-24.2")

;; setup load paths
(setq core-dir (concat user-emacs-directory "core"))
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

(require 'appearance)
(require 'sane-defaults)

(require 'setup-ace-jump-mode)
(require 'setup-saveplace)
(require 'setup-ido)
(require 'setup-smex)
(require 'setup-undo-tree)

(require 'key-bindings)

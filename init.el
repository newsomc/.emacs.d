;; quick defun to check if buffer's exist
(defun buffer-exists (bufname) (not (eq nil (get-buffer bufname))))

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
(setq scheme-program-name
  "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

;; set source directory (used for viewing c functions)
(setq source-directory "~/projects/emacs/emacs-24.2")

(setq is-mac (equal system-type 'darwin))

;; setup load paths
(setq core-dir (concat user-emacs-directory "core"))
(setq defuns-dir (concat user-emacs-directory "defuns"))
(setq elpa-dir (concat user-emacs-directory "elpa"))
(setq modules-dir (concat user-emacs-directory "modules"))
(setq themes-dir (concat user-emacs-directory "themes"))
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(setq vendor-dir (concat user-emacs-directory "vendor"))

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path core-dir)
(add-to-list 'load-path modules-dir)
(add-to-list 'load-path themes-dir)
(add-to-list 'load-path user-settings-dir)
(add-to-list 'load-path vendor-dir)

;; elpa packages
(require 'setup-package)
(require 'install-packages)

;; list/string libraries
(require 'cl)
(require 'dash)
(require 's)

(when is-mac (exec-path-from-shell-initialize))
(when is-mac (require 'mac))

;; load functions
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file) (load file)))

;; load modules
(dolist (file (directory-files modules-dir t "\\w+"))
  (require (intern (file-name-from-path-no-ext file))))

;; load vendor
(dolist (file (directory-files vendor-dir t "\\w+"))
  (require (intern (file-name-from-path-no-ext file))))

;; load color theme
(require 'subatomic-theme)
(powerline-default)

;; core
(require 'appearance)
(require 'sane-defaults)
(require 'key-bindings)

;; diminish
(require 'diminish)

;; customize
(setq custom-file "~/.emacs.d/core/custom.el")
(load custom-file)

;; easily switch windows
(require 'switch-window)

;; start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

;; default perspective
(if (fboundp 'custom-persp/emacs)
  (progn
    (custom-persp/emacs)))

;; Requires https://github.com/rougier/nano-emacs

(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
         '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    flycheck                        ;; Checking
    elpy                            ;; Emacs Lisp Python Environment
    py-autopep8
    ein
    magit
    neotree
    centaur-tabs
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)


;; Path to nano emacs modules (mandatory)
(add-to-list 'load-path "/Users/gswamy/dev/nano-emacs")
(add-to-list 'load-path ".")

;; Window layout (optional)
(require 'nano-layout)

(require 'nano-theme-dark)

;; Customize support for 'emacs -q' (Optional)
;; You can enable customizations by creating the nano-custom.el file
;; with e.g. `touch nano-custom.el` in the folder containing this file.
(let* ((this-file  (or load-file-name (buffer-file-name)))
       (this-dir  (file-name-directory this-file))
       (custom-path  (concat this-dir "nano-custom.el")))
  (when (and (eq nil user-init-file)
	     (eq nil custom-file)
	     (file-exists-p custom-path))
    (setq user-init-file this-file)
    (setq custom-file custom-path)
    (load custom-file)))

;; Theme
(require 'nano-faces)
(nano-faces)

(require 'nano-theme)
(nano-theme)

;; Nano default settings (optional)
(require 'nano-defaults)

;; Nano session saving (optional)
(require 'nano-session)

;; Nano header & mode lines (optional)
(require 'nano-modeline)

;; Nano key bindings modification (optional)
(require 'nano-bindings)

;; Welcome message (optional)
(let ((inhibit-message t))
  (message "Welcome to GNU Emacs / N Λ N O edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

;; Splash (optional)
(add-to-list 'command-switch-alist '("-no-splash" . (lambda (args))))
(unless (member "-no-splash" command-line-args)
  (require 'nano-splash))

;; Help (optional)
(add-to-list 'command-switch-alist '("-no-help" . (lambda (args))))
(unless (member "-no-help" command-line-args)
  (require 'nano-help))

(provide 'nano)

(cua-mode t)

;; Enable elpy
(elpy-enable)

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq neo-theme (if (display-graphic-p) 'arrow))
(custom-set-faces
 '(neo-root-dir-face ((t (:foreground "#8D8D84"))))
 '(neo-dir-link-face ((t (:foreground "#88C0D0")))))

(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(if ( version< "27.0" emacs-version ) ; )
    (set-fontset-font "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)
  (warn "This Emacs version is too old to properly support emoji."))

(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-.") 'centaur-tabs-backward)
(global-set-key (kbd "C-,") 'centaur-tabs-forward)

(global-linum-mode t)               ;; Enable line numbers globally
(setq linum-format "%d ")

(defun ide-setup ()
  "Called by emacs-startup-hook to set up my initial window configuration."
  (split-window-below)
  (other-window 1)
  (ansi-term "/bin/zsh")
  (other-window 1)
  (neotree-toggle))

(add-to-list 'command-switch-alist '("-ide"   . (lambda (args))))

(cond
 ((member "-ide" command-line-args) (add-hook 'after-init-hook #'ide-setup)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elpy flycheck yasnippet s pkg-info nordless-theme nord-theme better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; A basic org-mode config.
(require 'org)
(setq org-agenda-files (list "~/dev/org/agenda.org"))
(setq org-agenda-span 14)
(require 'nano-agenda)

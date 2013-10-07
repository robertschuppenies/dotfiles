;; Style
;; =====

;; show column number
(column-number-mode 1)

;; ;; automatic line break
;; (setq-default auto-fill-function 'do-auto-fill)

;; do not show menu bar
(menu-bar-mode 0)

;; turn on font-lock mode
(global-font-lock-mode t)

; Make shell look pretty
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; ====
;; misc
;; ====

(setq-default fill-column 79)

;; default diff to unified diff
(setq diff-switches "-u")

;; Do without annoying startup msg.
(setq inhibit-startup-message t)

;; Set Tab width to 2.
(setq-default tab-width 2)

;; make "yes or no" "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

; make all backups in a single directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name "~/.emacs-backups"))))

;; show trailing whitespaces
(setq-default show-trailing-whitespace t)

;; remove trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; add newline to end of files
(setq require-final-newline t)

;; Numbered backups
(setq version-control t)
(setq kept-old-versions 3)
(setq kept-new-versions 10)
(setq trim-versions-without-asking t)

;; hungry delete
(setq c-hungry-delete-key t)


;; ============
;; Key Bindings
;; ============

;; custom margin keys (useful for Python indentation)
(global-set-key (kbd "M-+") 'increase-left-margin)
(global-set-key (kbd "M--") 'decrease-left-margin)

;; F6 stores a position in a file, F7 brings you back to this position
(global-set-key (kbd "<f6>") '(lambda () (interactive) (point-to-register ?1)))
(global-set-key (kbd "<f7>") '(lambda () (interactive) (register-to-point ?1)))

;; make commenting easy ;)
(global-set-key (kbd "M-#") 'comment-region)

(defun reload-file ()
  (interactive)
    (find-file (buffer-name)))

(setq-default indent-tabs-mode nil)


;; =============
;; Generic Tools
;; =============

(defvar *emacs-lib-dir* "~/.emacs.d/elisp/")
(add-to-list 'load-path *emacs-lib-dir*)

;; git
(add-to-list 'load-path "/usr/share/doc/git-core/contrib/emacs")

(load-library "~/.emacs.d/elisp/vc-git.el")
(add-to-list 'vc-handled-backends 'GIT)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(js2-cleanup-whitespace t)
 '(safe-local-variable-values (quote ((python-indent . 2) (css-indent-offset . 2) (show-trailing-whitespace . t) (require-final-newline . t))))
 '(vc-follow-symlinks t))
 ;; If not already done

;; unique file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(require 'smooth-scrolling)

(load-file (concat *emacs-lib-dir* "wordcount.el"))

;; Search and replace across files.
(require 'dired-x)


;; =================
;; language-specific
;; =================

;; C
;; =

;; highlight XXX style code tags in source files
(font-lock-add-keywords 'c-mode
			'(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\):?" 1 font-lock-warning-face prepend)))


;; Go
;; ==

(require 'go-mode-load)


;; HTML
;; ====

(setq html-helper-new-buffer-template
  '(html-helper-htmldtd-version
    "<html>\n"
    "  <head>\n"
    "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n"
    "    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>\n"
    "    <script type=\"text/javascript\" charset=\"utf-8\" src=\"\"></script>\n"
    "    <title> </title>\n"
    "  </head>\n\n"
    "  <body>\n"
    "  </body>"
    "\n</html>\n"))


;; JavaScript
;; ==========

(autoload 'js2-mode "js2.elc" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(load "soy-mode")


;; Processing
;; ==========

(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))

;; Python
;; ======

(load-file "~/.emacs.d/elisp/pylint.el")

(font-lock-add-keywords 'python-mode
			'(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\):?" 1 font-lock-warning-face prepend)))

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
   (let* ((temp-file (flymake-init-create-temp-buffer-copy
		      'flymake-create-temp-inplace))
	  (local-file (file-relative-name
		       temp-file
		       (file-name-directory buffer-file-name)))
     (list "pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init))))
(add-hook 'find-file-hook 'flymake-find-file-hook)

(add-hook 'python-mode-hook 'highlight-beyond-fill-column)


;; ===================
;; Local Configuration
;; ===================


(load-file "~/.emacs_local")

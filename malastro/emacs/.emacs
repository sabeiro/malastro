;;(setq debug-on-error t)
;;---------------------------------STYLE--------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#000044" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("43b0db785fc313b52a42f8e5e88d12e6bd6ff9cee5ffb3591acf51bbd465b3f4" "47aaf1021bdd742a2f91448f089ad6fe95028c9557638d4333452ce85da980de" default)))
 '(fringe-mode 0 nil (fringe))
 '(global-ede-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(scroll-bar-mode nil)
 '(semantic-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'default-frame-alist '(foreground-color . "#E0DFDB"))
(add-to-list 'default-frame-alist '(background-color . "#110428"))
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha) '(85 85))


;;(set-face-attribute 'default nil :background "black"
;; :foreground "white" :font "Sans" :height 160)

;; (defun font-big ()
;;  (interactive)
;;  (set-face-attribute 'default nil :height
;;   (+ (face-attribute 'default :height) 10)))

;; (defun font-small ()
;;  (interactive)
;;  (set-face-attribute 'default nil :height
;;   (- (face-attribute 'default :height) 10)))

;;---------------------------binding--------------------------

(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(global-set-key (kbd "M-l") 'goto-line)
;;(global-set-key (kbd "C-;") 'next-multiframe-window)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "") 'text-scale-decrease)
(global-set-key (kbd "") 'text-scale-increase)
(setenv "PATH" (concat "$LAV_DIR/bin" ";"  (getenv "PATH") ) )
;; temporary-file-directory

;;-------------------------environment-------------------------
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

;;----------------------------------PACKAGES---------------------------------------
(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
 
(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; (load-file "~/.emacs.d/nodejs-repl.el")
;; (require 'nodejs-repl)
;; (defun node-repl () (interactive)
;;        (pop-to-buffer (make-comint "node-repl" "node" nil "--interactive"))
;;        (node-repl))

(setq inferior-js-program-command "node --interactive")

(load-file "~/.emacs.d/json.el")
(load-library "json")
(require 'json)
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;; (use-package markdown-mode
;;   :ensure t
;;   :commands (markdown-mode gfm-mode)
;;   :mode (("README\\.md\\'" . gfm-mode)
;;          ("\\.md\\'" . markdown-mode)
;;          ("\\.markdown\\'" . markdown-mode))
;;   :init (setq markdown-command "multimarkdown"))

(load-file "~/.emacs.d/js-comint.el")
(load-file "~/.emacs.d/nodejs-repl.el")
(require 'nodejs-repl)
(require 'js-comint)
(setq inferior-js-program-command "node --interactive")

;;(setq inferior-js-program-command "/usr/bin/java org.mozilla.javascript.tools.shell.Main")
;;(add-hook 'js2-mode-hook '(lambda () 
;;			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;			    (local-set-key "\C-cb" 'js-send-buffer)
;;			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;			    (local-set-key "\C-cl" 'js-load-file-and-go)
;;			    ))

;;(defun my-node-shell ()
;;  (interactive)
;;  (pop-to-buffer (make-comint "Node Shell" "node" nil "~/bin/node-in-node.js")))cd
;;
(load-file "~/.emacs.d/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.api\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))
(setq web-mode-content-types-alist
     '(("json" . "/some/path/.*\\.api\\'")
	("xml"  . "/other/path/.*\\.api\\'")
	("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))
(load-file "~/.emacs.d/web-beautify.el")
(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))
;;(load-file "~/.emacs.d/js-comint.el")
;;(require 'js-comint)
;;(setq inferior-js-program-command "/usr/bin/java org.mozilla.javascript.tools.shell.Main")
;;(add-hook 'js2-mode-hook '(lambda ()
;;			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;			    (local-set-key "\C-cb" 'js-send-buffer)
;;			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;			    (local-set-key "\C-cl" 'js-load-file-and-go)
;;			    ))
;;(setq auto-mode-alist
;;      (append '(
;;		("\\.html$" . two-mode-mode)
;;		("\\.php$" . two-mode-mode)
;;		("\\.php3$" . two-mode-mode) )
;;	      auto-mode-alist) )
(load-file "~/.emacs.d/yaml-mode.el")
(add-hook 'yaml-mode-hook
        (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
;; (load-file "~/.emacs.d/php-mode.el")
;; (load-file "~/.emacs.d/multi-web-mode.el")
;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags 
;;   '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;     (js-mode  "]*>" "")
;;     (css-mode "]*>" "")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)

;; (load-file "~/.emacs.d/f.el")
;; (load-file "~/.emacs.d/s.el")
;; (add-to-list 'load-path "~/.emacs.d/elm-mode/")
;; (load-file "~/.emacs.d/elm-mode/elm-mode.el")
;; (require 'elm-mode)
;; (add-to-list 'auto-mode-alist '("*.elm'" . elm-mode))


;;------------------------------------BACKUP---------------------------------
(desktop-save-mode 1)
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t) 

(setq temporary-file-directory "~/lav/tmp/")
(setq small-temporary-file-directory "~/lav/tmp/")

;;-----------------------------------interactive-----------------------------
;; (autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq python-shell-interpreter "/usr/bin/python3"
      python-shell-interpreter-args "-i")
(setq py-python-command "/usr/bin/python3")

;; (require 'bind-key)
;; (global-set-key (kbd "C-RET") 'python-shell-send-region)
;; (eval-after-load 'python
;;   '(define-key LaTeX-mode-map [(tab)] 'outline-cycle)))
(add-hook 'python-mode-hook '(lambda () (local-set-key (kbd "C-a") #'python-shell-send-region)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-a" 'python-shell-send-region)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "<C-return>" 'python-shell-send-region)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "C-RET" 'python-shell-send-region)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

(defun my-node-compile ()
  (interactive)
  (shell)
  (goto-char (point-max))
  (comint-kill-input)
  (insert "npm run build --prefix .")
  (comint-send-input))

(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-a") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
	    (define-key js-mode-map (kbd "C-c C-c") 'my-node-compile)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))


;; `python-shell-interpreter-interactive-arg' or add regexps
;; matching shell prompts in the directory-local friendly vars:
;;   + `python-shell-prompt-regexp'
;;   + `python-shell-prompt-block-regexp'
;;   + `python-shell-prompt-output-regexp'
;; Or alternatively in:
;;   + `python-shell-prompt-input-regexps'
;;   + `python-shell-prompt-output-regexps'


(ac-config-default)
(defvar ac-source-python
  '((candidates .
		(lambda ()
		  (mapcar '(lambda (completion)
			     (first (last (split-string completion "\\." t))))
			  (python-symbol-completions (python-partial-symbol)))))))
(add-hook 'python-mode-hook
	  (lambda() (setq ac-sources '(ac-source-python))))
(define-key ac-completing-map "\ESC/" 'ac-stop)

;;(define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward)
;;(global-set-key (kbd "<f4>") (lambda () (interactive) (setq current-prefix-arg '(4)) (call-interactively 'compile)))

;;(custom-set-variables
;;  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/saves/\\1" t)))
;;  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;;
;;(setq backup-directory-alist
;;      `((".*" . ,temporary-file-directory)))
;;(setq auto-save-file-name-transforms
;;      `((".*" ,temporary-file-directory t)))
;;
;; (defun join-lines (arg)
;;   (interactive "p")
;;   (end-of-line)
;;   (delete-char 1)
;;   (delete-horizontal-space)
;;   (insert " "))
;; (defun concat-lines ()
;;   (interactive)
;;   (next-line)
;;   (join-line)
;;   (delete-horizontal-space))
(defun  inskcape-test ()
  (let*
    ((desktop (dbus-call-method
               :session "org.inkscape" "/org/inkscape/application"
               "org.inkscape.application" "desktop_new"))
     (rect (dbus-call-method
               :session "org.inkscape" desktop
               "org.inkscape.document" "rectangle" :int32 100 :int32  100 :int32  100 :int32  100))
           )))
			

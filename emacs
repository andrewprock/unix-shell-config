; Andrew Prock's .emacs file.  It is EVIL!!!

;;;;
;;;; Stuff shamelessly culled from https://github.com/codahale/emacs.d
;;;;

;;;; CUSTOM
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;;; PACKAGES
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'cl)1;3C
(defvar prelude-packages '(
                           js2-mode
                           go-mode
;                              ag anzu autopair better-defaults coffee-mode company
;                              company-go company-inf-ruby cpputils-cmake csv-mode direx
;                              discover dockerfile-mode enh-ruby-mode erlang
;                              exec-path-from-shell expand-region fic-mode flx-ido flycheck
;                              flycheck-color-mode-line flycheck-haskell flyspell-lazy gist
;                              git-commit-mode git-rebase-mode git-timemachine go-direx
;                              go-eldoc go-mode go-snippets haskell-mode highlight-symbol
;                              ibuffer-vc ido-vertical-mode idomenu imenu-anywhere inf-ruby
;                              ir-black-theme js2-mode json-mode legalese lua-mode magit
;                              markdown-mode paredit popwin projectile protobuf-mode
;                              puppet-mode rainbow-delimiters rust-mode scala-mode shm
;                              smart-mode-line smex smooth-scrolling thrift toml-mode tuareg
;                              undo-tree web-mode yaml-mode yard-mode yasnippet zenburn-theme
                              )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; don't re-load packages
(setq package-enable-at-startup nil)

;;;; JAVASCRIPT

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;;; GLOBAL

;; use autopair everywhere
;(autopair-global-mode t)

;; rely on electric indents, since they're improving
(electric-indent-mode t)

;; highlight the current line
;(global-hl-line-mode)

;; also fill paragraphs to 80 characters
(setq-default fill-column 80)

;; enable flycheck everywhere
;(add-hook 'after-init-hook #'global-flycheck-mode)
;(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; a tab is 4 spaces wide
(setq-default tab-width 4)

;; always prefer UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;;
;;;; My stuff
;;;;

; cleaner start-up
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
;(when (>= emacs-major-version 21)               ; Get rid of Toolbar
;  (tool-bar-mode -1))

(setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-light t)

(setq vc-handled-backends nil)
(setq next-line-add-newlines nil)
(setq transient-mark-mode t)
(setq view-calendar-holidays-initially t)
(setq search-highlight t)
(setq line-number-mode t)
(setq display-time-day-and-date t)
(display-time)

; colors and stuff
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
;set-background-color        "#FCFCFF") ; Set emacs bg color
;(load "hilit19")

; stop those annoying reloads
(global-auto-revert-mode)

;; C++ development
;(subword-mode 1)
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(setq-default indent-tabs-mode nil) ; Indentation cannot insert tabs
;(setq show-paren-mode t)


;; KEY BINDINGS

;(define-key global-map "\C-." 'delete-char)     ; doesn't work in -nw
;(define-key global-map "\C-;" 'start-kbd-macro) ; doesn't work in -nw
(define-key global-map "\C-\\" 'other-window)	 ; was 'delete-horizontal-space
;(define-key global-map "\C-'" 'recenter)	 ; was 'undefined
;(define-key global-map "\C-/" 'isearch-repeat-forward) ; was 'undo

(define-key global-map "\C-a" 'help-command)	 ; was 'beginning-of-line
(define-key global-map "\C-b" 'beginning-of-line)	 ; was 'backward-char
;(define-key global-map "\C-c" ')		; prefix
;(define-key global-map "\C-d" 'delete-char)	; unchanged
;(define-key global-map "\C-e" ')		; OPEN
;(define-key global-map "\C-f" ')		; OPEN
;(define-key global-map "\C-g" 'keyboard-quit)	; unchanged
(define-key global-map "\C-h" 'backward-char)	; was 'help-command
(define-key global-map (kbd "TAB") 'indent-or-complete); was 'help-command
(define-key global-map "\C-j" 'next-line)	; was 'newline-and-indent
(define-key global-map "\C-k" 'previous-line)	; was 'kill-line ->
(define-key global-map "\C-l" 'forward-char)	; was 'recenter
; RET
(define-key global-map "\C-n" 'end-of-line)	; was 'next-line
;(define-key global-map "\C-o" 'open-line)	; unchanged
(define-key global-map "\C-p" 'yank)		; was 'previous-line
;(define-key global-map "\C-q" ')		; unchanged
(define-key global-map "\C-r" 'call-last-kbd-macro); was 'undefined
;(define-key global-map "\C-s" ')		; unchanged
;(define-key global-map "\C-t" ')		; unchanged
(define-key global-map "\C-u" 'undo)		; was 'universal-argument
;(define-key global-map "\C-v" ')		; OPEN
(define-key global-map "\C-w" 'downcase-word)	; was 'kill-region
;(define-key global-map "\C-x" ')		; prefix
(define-key global-map "\C-y" 'kill-line)	; was 'yank
;(define-key global-map "\C-z" ')		; unchanged

(define-key global-map "\M-," 'repeat-complex-command)	; was 'tags-loop-continue
(define-key global-map "\M--" 'shrink-window)   ; was 'negative-argument
(define-key global-map "\M-." 'kill-word)	; was 'find-tag
(define-key global-map "\M-;" 'end-kbd-macro)	; was 'indent-for-comment
(define-key global-map "\M-=" 'enlarge-window)  ; was 'count-lines-region
(define-key global-map "\M-[" 'scroll-down-in-place)    ; was 'undefined
(define-key global-map "\M-\\" 'delete-other-windows)   ; was 'undefined
(define-key global-map "\M-]" 'scroll-up-in-place)      ; was 'undefined
(define-key global-map "\M-/" 'isearch-repeat-backward); was 'undefined

;(define-key global-map "\M-a" ')		; OPEN
(define-key global-map "\M-b" 'backward-paragraph)      ; was 'backward-word
;(define-key global-map "\M-c" 'indent-or-auto-complete) ; was 'capitalize-word
(define-key global-map "\M-d" '(lambda () (interactive) (bury-buffer nil)))
;(define-key global-map "\M-e" ')		; OPEN
;(define-key global-map "\M-f" ')		; OPEN
(define-key global-map "\M-g" 'goto-line)       ; was 'undefined
(define-key global-map "\M-h" 'backward-word)   ; was 'mark-paragraph
;(define-key global-map "\M-i" 'tab-to-tab-stop); unchanged
(define-key global-map "\M-j" 'scroll-up)       ; was 'indent-new-comment-line
(define-key global-map "\M-k" 'scroll-down)     ; was 'kill-sentence
(define-key global-map "\M-l" 'forward-word)    ; was 'downcase-word
;(define-key global-map "\M-m" 'back-to-indentation)	; unchanged
(define-key global-map "\M-n" 'forward-paragraph); was 'undefined
;(define-key global-map "\M-o" ')		; used for tmux
(define-key global-map "\M-p" 'yank-pop)        ; was 'undefined
;(define-key global-map "\M-q" 'fill-paragraph)	; unchanged
;(define-key global-map "\M-r" 'move-to-window-line-top-bottom)	; unchanged
(define-key global-map "\M-s" 'load-file)       ; was 'undefined
(define-key global-map "\M-t" 'find-tag)	; was 'transpose-words
;(define-key global-map "\M-u" ')		; OPEN
;(define-key global-map "\M-v" ')		; OPEN
(define-key global-map "\M-w" 'upcase-word)     ; was 'kill-ring-save
;(define-key global-map "\M-x" ')		; prefix
(define-key global-map "\M-y" 'kill-region)     ; was 'yank-pop
;(define-key global-map "\M-z" ')		; OPEN


(define-key global-map "\C-\M-j" 'end-of-defun)	      ; was 'kill-sexp
(define-key global-map "\C-\M-k" 'beginning-of-defun) ; was 'indent-new-comment-line

(define-key global-map "\C-\M-l" 'next-buffer)	      ; was 'kill-sexp
(define-key global-map "\C-\M-h" 'previous-buffer) ; was 'indent-new-comment-line

(define-key global-map [f1] 'ff-find-other-file)
(define-key global-map [f2] '(lambda () (interactive) (switch-to-buffer nil)))
(define-key global-map [f3] 'find-file)
(define-key global-map [f4] 'save-buffer)
(define-key global-map [f5] 'kill-buffer)
(define-key global-map [f6] 'ff-find-other-file)
(define-key global-map [f7] 'next-error)
;(define-key global-map [f8] 'ispell-word)
(define-key global-map [f9] 'query-replace)
(define-key global-map [f10] 'font-lock-mode)
(define-key global-map [f11] 'vc-toggle-read-only)   ; RCS check out
(define-key global-map [f12] 'vc-next-action)        ; RCS check in

(define-key global-map [\M-f2] '(lambda () (interactive) (bury-buffer nil)))
(define-key global-map [\M-f3] 'find-file-other-window)
(define-key global-map [\M-f4] 'write-file)
(define-key global-map [\M-f5] 'save-buffers-kill-emacs)
(define-key global-map [\M-f6] 'compile)
(define-key global-map [\M-f7] '(lambda () (interactive) (next-error -1)))
(define-key global-map [\M-f8] 'ispell-buffer)     ; done
(define-key global-map [\M-f9] 'replace-string)    ; done


;; MODE & ABBREV SETTINGS

;; google style guide
(require 'google-c-style)

; Enhance mode-hook
(setq auto-mode-alist
      (append '(("\\.icc$"  . c++-mode)
		("\\.h$"    . c++-mode)
		("\\.C$"    . c++-mode)
		("\\.c$"    . c++-mode)            ; c is c++!!
		("[Mm]akefile$"  . makefile-mode)
		) auto-mode-alist))

; C++ mode settings
; this code doesn't seem to be being called
(add-hook 'c-mode-common-hook
	  (lambda ()
            ;(local-set-key "   " 'indent-or-complete)
            ;(define-key c++-mode-map "TAB" 'indent-or-complete)
            (define-key c++-mode-map "\C-j" 'next-line)
            (define-key c++-mode-map "\C-\M-j" 'end-of-defun)
            (setq
             c-argdecl-indent 4
;			    c-auto-newline nil
;			    c-backslash-column 75
;			    c-brace-imaginary-offset -4
;			    c-brace-offset -4
             c-continued-brace-offset 4
;			    c-continued-statement-offset 4
             c-indent-level 4
             c-label-offset -4
;			    c-tab-always-indent nil
;			    comment-column 45
             fill-column 75)
            (abbrev-mode t)
            (setq tab-width 4)
            (turn-on-auto-fill)
;	    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-abbrev))
            ))

(add-hook 'c-mode-common-hook 'google-set-c-style)

; formatting?
(defconst my-cc-style
  '("bsd"
    (c-offsets-alist . ((innamespace . [0])))))
(c-add-style "my-cc-style" my-cc-style)

(setq c-default-style
      '((java-mode . "java")
        (c++-mode . "my-cc-style")
        (other . "gnu")))
(setq-default c-basic-offset 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Smart Tab
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\<")
      (indent-for-tab-command)
    (if (looking-at "[a-zA-Z]")
        (dabbrev-expand nil)
      (if (looking-at "\\>")
          (dabbrev-expand nil)
        (indent-for-tab-command)
	))))

(defun indent-or-auto-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\<")
      (indent-for-tab-command)
    (if (looking-at "[a-zA-Z_0-9]")
        (auto-complete nil)
      (if (looking-at "\\>")
          (auto-complete nil)
        (indent-for-tab-command)
	))))
(define-key global-map (kbd "C-TAB") 'indent-or-auto-complete)
; hook the smarter tab to c++ modes
;(add-hook 'c-mode-common-hook
;          (function (lambda ()
;                      (local-set-key (kbd "TAB") 'indent-or-auto-complete)
;                      )))
;(add-hook 'c++-mode-common-hook
;          (lambda ()
;            (local-set-key (kbd "TAB") 'indent-or-complete)
;            ))

; Text Mode
(setq text-mode-hook
      '(lambda ()
	 (turn-on-auto-fill)
	 (setq fill-column 65)
	 (abbrev-mode t)))


;; BUNCH OF FUNCTIONS

; Vi like matching of parentheses
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (push-mark) (forward-list 1) (backward-char 1))
	((looking-at "\\s)") (push-mark) (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(define-key global-map "%" 'match-paren)

(defun query-quit ()
  (fboundp 'frame-list)
  (interactive)
  (global-set-key "\C-x\C-c"  'query-kill-emacs))

(defun scroll-down-in-place(n)
  "Like scroll-down, but one line."
  (interactive "p")
  (scroll-down n))

(defun scroll-up-in-place(n)
  "Like scroll-up, but one line."
  (interactive "p")
  (scroll-up n))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
 (filename (buffer-file-name)))
    (if (not filename)
 (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
   (message "A buffer named '%s' already exists!" new-name)
 (progn
   (rename-file name new-name 1)
   (rename-buffer new-name)
   (set-visited-file-name new-name)
   (set-buffer-modified-p nil))))))

;;
;;      PACKAGES
;;

;; ido mode for buffer completion.  use arrows instead of
;; control keys for basic navigation
(require 'ido)
;(add-hook 'ido-define-mode-map-hook 'ido-my-keys)
;(defun ido-my-keys ()
;  "Set up the keymap for `ido'."
;
;  (define-key ido-mode-map [right] 'ido-next-match)
;  (define-key ido-mode-map [left] 'ido-prev-match))
(ido-mode t)
(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
		(push (prin1-to-string x t) tag-names))
	      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

; cedet
;(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
;(global-ede-mode 1)                      ; Enable the Project management system
;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; Semantic
;(global-semantic-idle-completions-mode t)
;(global-semantic-decoration-mode t)
;(global-semantic-highlight-func-mode t)
;(global-semantic-show-unmatched-syntax-mode t)

; core libraries for cedet project
;(ede-cpp-root-project "fcc" :file "~/svn-head/calsvn/teamnuts/linux/Makefile")

;;
;; Autocomplete
;;
;;
;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
;(require 'auto-complete-config)
;(require 'ac-dabbrev)
;(add-to-list 'ac-dictionary-directories (expand-file-name
;             "~/.emacs.d/auto-complete-1.3.1/dict"))
;(setq ac-comphist-file (expand-file-name
;             "~/.emacs.d/ac-comphist.dat"))
;(defun my-ac-c-mode-common ()
;  (setq ac-sources '(ac-source-dabbrev)))
;(ac-config-default)
;(setq-default ac-sources '(ac-source-dabbrev))
;(setq ac-auto-start 5)
;(ac-set-trigger-key "TAB")
;(setq ac-delay 0)
;(setq ac-auto-show-menu 0)
;(define-key ac-complete-mode-map (kbd "C-j") 'ac-next)
;(define-key ac-complete-mode-map (kbd "C-k") 'ac-previous)
;(define-key ac-complete-mode-map (kbd "C-TAB") 'indent-or-auto-complete)
;(define-key ac-completing-map "\r" nil)

; line numbers
;(global-linum-mode 1)


;(set-frame-height (selected-frame) 100)
;(set-frame-width (selected-frame) 100)

; Ultimate Gaming style settings
(setq-default fill-column 120)
;(setq-default indent-tabs-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((t (:foreground "color-33"))))
 '(whitespace-space ((t (:foreground "color-238")))))

(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)


(setq whitespace-line-column 250)


;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )

(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)

;(require 'adoc-mode)
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;==== Groovy/Gradle stuff ====
;;; turn on syntax highlighting
(global-font-lock-mode 1)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))


;; Statabase stuff
(setq js-indent-level 3)
(custom-set-variables
 '(js2-basic-offset 3)
 '(js2-bounce-indent-p nil)
 )

;; culled from coda hale's .emacs.d

;; always delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; always add a trailing newline - POSIX
(setq require-final-newline t)

;;;; SPELLING

(require 'ispell)

;; use aspell instead of ispell
(setq ispell-program-name "aspell")

;; automatically check spelling for text
;(add-hook 'text-mode-hook 'flyspell-mode)

;; spell check comments and strings when programming
;(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; spell check git commit messages
;(add-hook 'git-commit-mode-hook 'flyspell-mode)

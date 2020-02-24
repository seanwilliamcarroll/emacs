

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(put 'erase-buffer 'disabled nil)
;;------------------------------------------------------------------------------
;; eshell
;;------------------------------------------------------------------------------
(defun eshell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))
(defun shell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))

;;------------------------------------------------------------------------------
;; visual
;;------------------------------------------------------------------------------
;; Show line numbers
(global-linum-mode t) 
(menu-bar-mode -1) ; hide menu bar
(setq inhibit-startup-message t)
(tool-bar-mode -1) ; hide tool bar
(scroll-bar-mode -1) ; hide the scroll bar
(setq show-paren-delay 0) ; no delay in highlighting
(show-paren-mode 1) ; highlight matching parentheses
(setq-default indent-tabs-mode nil)
(setq column-number-mode t) ; show columns in mode line as well
(delete-selection-mode t)
;;------------------------------------------------------------------------------
;; My functions
;;------------------------------------------------------------------------------
;; Batten Extend-o
(defun extend-char-to-end ()
 "Extend adjacent character to fill 80 columns"
  (interactive)
  (let ( (end-point (point-at-eol)) (match-char nil) )
    (beginning-of-line)
    (re-search-forward "[^ ][ ]*$" end-point t)
    (setq match-char (string-to-char (match-string 0)))
    (replace-match "")
    (insert-char match-char (- 80 (current-column)))))
(global-set-key (kbd "C-q") 'extend-char-to-end)
;;------------------------------------------------------------------------------
;; Thomas Doge's Tips
;;------------------------------------------------------------------------------
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(delete-selection-mode 1) ;delete highlighted stuff when typing
(setq lazy-highlight-cleanup nil) ; keep search results highlighted
(setq-default frame-title-format "%b (%f)") ;file path in title bar
(require 'uniquify) ; give buffers w/ same name unique name
(setq uniquify-buffer-name-style 'reverse)
(setq-default cursor-type 'box) 
(tool-bar-mode -1)                                ; turn off icon bar
(setq mouse-drag-copy-region nil)

(setq verilog-auto-newline nil) ;; stops newline after semicolon

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(require 'compile)
(setq confirm-kill-emacs 'yes-or-no-p)
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(setq auto-mode-alist (cons '("\\.sva" . verilog-mode) auto-mode-alist))

; Find file at point
(global-set-key (kbd "C-c f") 'find-file-at-point)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 (mapc
  (lambda (face)
    (set-face-attribute face nil :weight 'normal :underline nil))
  (face-list))
(cl-loop for face in (face-list) do
         (unless (eq face 'default)
           (set-face-attribute face nil :height 1.0)))

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(let ((default-directory "~/.emacs.d/qgrep/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(autoload 'qgrep "qgrep" "Quick grep" t)
(autoload 'qgrep-no-confirm "qgrep" "Quick grep" t)
(autoload 'qgrep-confirm "qgrep" "Quick grep" t)
(global-set-key (kbd "\C-c g") 'qgrep-no-confirm)
(global-set-key (kbd "\C-c G") 'qgrep-confirm)
;; Stricter filters
(setq qgrep-default-find "find . \\( -wholename '*/.svn' -o -wholename '*/obj' -o -wholename '*/.git' -o -wholename '*/VCOMP' \\) -prune -o -type f \\( '!' -name '*atdesignerSave.ses' -a \\( '!' -name '*~' \\) -a \\( '!' -name '#*#' \\) -a \\( -name '*' \\) \\) -type f -print0")
(setq qgrep-default-grep "grep -iI -nH -e \"%s\"")

(add-to-list 'auto-mode-alist '("\\.bzl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\WORKSPACE\\'" . python-mode))
(global-set-key [f1] (lambda () (interactive) (shell "*shell*")))
(global-set-key [f2] (lambda () (interactive) (shell "*shell*<2>")))
(global-set-key [f3] (lambda () (interactive) (shell "*shell*<3>")))
(global-set-key [f4] (lambda () (interactive) (shell "*shell*<4>")))

(defun to-underscore () (interactive) (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil (region-beginning) (region-end)) (downcase-region (region-beginning) (region-end))) )

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-diff-options "-w")
(setq ediff-control-frame-upward-shift 40)
(setq ediff-narrow-control-frame-leftward-shift -30)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

(defadvice occur (after rename-buf activate)
  "Rename the occur buffer to be unique."
  (save-excursion
    (when (get-buffer "*Occur*")
      (with-current-buffer "*Occur*"
        (forward-line 0)
        (let ((line (thing-at-point 'line))
              (search)
              (buffer))
          (string-match "for \"\\(.*\\)\" in buffer: \\(.*\\)" line)
          (setq search (match-string 1 line))
          (setq buffer (match-string 2 line))
          (rename-buffer (format "*Occur: %s:\"%s\"*" buffer search)))))))
(ad-activate 'occur)


(require 'desktop)
(setq desktop-path '("/data/proj/scarroll/w5/"))
(desktop-save-mode 1)

(global-unset-key "\C-z")
(fset 'yes-or-no-p 'y-or-n-p)

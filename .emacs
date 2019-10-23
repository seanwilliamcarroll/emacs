

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

(set-language-environment 'Japanese)
(set-default-coding-systems 'euc-jp-unix)
(set-buffer-file-coding-system 'euc-jp-unix)
(set-keyboard-coding-system 'sjis-mac)
(set-clipboard-coding-system 'sjis-mac)
(utf-translate-cjk-mode 1)
(setq-default buffer-file-coding-system 'utf-8)
;(set-file-name-coding-system 'utf-8)

;; $B%3%s%Q%$%k;~$NJ8;z2=$1$r=$@5(B
(setq shell-mode-hook
	  (function (lambda () 
				  (set-buffer-process-coding-system 'euc-jp-unix 
													'euc-jp-unix))))

;; $BA0$HF1$89T$NI}$K%$%s%G%s%H(B
(setq c-tab-always-indent t)
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; $BJd408uJd$r<+F0E*$KI=<((B
;; auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; append elrang-mode
(setq ac-modes
	  (append ac-modes
			  (list 'erlang-mode)))

;; $B%7%U%H(B+$BLp0u$GHO0OA*Br(B
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

;; $B=*N;;~$K%*!<%H%;!<%V%U%!%$%k$r>C$9(B
(setq delete-auto-save-files t)

;; $B%-!<%P%$%s%I(B
(global-set-key "\C-x(J\(BC-i" 'indent-region)	; $BA*BrHO0O$r%$%s%G%s%H(B
(global-set-key "\C-m" 'newline-and-indent) ;$B%j%?!<%s$G2~9T$H%$%s%G%s%H(B

(global-set-key "\C-cc" 'comment-region) ; C-c c$B$rHO0O;XDj%3%a%s%H$K(B
(global-set-key "\C-cu" 'uncomment-region) ; C-c u$B$rHO0O;XDj%3%a%s%H2r=|$K(B

;; $B%9%F!<%?%9%i%$%s$K;~9oI=<((B
(setq display-time-day-and-date t)
(display-time)

(show-paren-mode t)						; $BBP1~$9$k3g8L$r8w$i$;$k(B
(transient-mark-mode t)					; $BA*BrHO0O$N%O%$%i%$%H(B

;;$B%9%?!<%H%"%C%W%Z!<%8$rI=<($7$J$$(B
(setq inhibit-startup-message t)

;;$B%a%K%e!<%P!<$r1#$9(B
(tool-bar-mode -1)

;; $BD9$$9T$N@^$jJV$7I=<($r(B nil:$B$7$J$$!#(B t:$B$9$k!#(B
(setq truncate-lines nil)
(setq truncate-lines-width-windows nil)

;;$B%&%#%s%I%&@_Dj(B
(if window-system
	(set-keyboard-coding-system 'sjis-mac) 
  (progn
	(set-keyboard-coding-system 'utf-8)
	(set-terminal-coding-system 'utf-8)))

;; linum$B@_Dj(B
(require 'linum)
(global-set-key [f5] 'linum-mode)
(add-hook 'lisp-interaction-mode-hook (lambda () (linum-mode t)))
(add-hook 'text-mode-hook (lambda () (linum-mode t)))

;; $BHO0OA*Br$r(BC-@$B$GJ8;zNsA*Br$H6k7AA*Br$K@Z$jBX$($k(B
(autoload 'sense-region-on "sense-region"
  "System to toggle region and rectangle." t nil)
(sense-region-on)

;; Color
(if window-system 
	(progn
	  (setq initial-frame-alist '((width . 80) (height . 30)))
	  (set-background-color "RoyalBlue4")
	  (set-foreground-color "LightGray")
	  (set-cursor-color "Gray")
))

;; $B%G%U%)%k%H$NF)L@EY$r@_Dj$9$k(B (85%)
(add-to-list 'default-frame-alist '(alpha . 85))

;; $B%+%l%s%H%&%#%s%I%&$NF)L@EY$rJQ99$9$k(B (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 85)

;$B%U%k%9%/%j!<%s(B
(set-frame-parameter nil 'fullscreen 'fullboth)
(defun my-toggle-frame-size()
  (if (frame-parameter nil 'fullscreen)
	  (set-frame-parameter nil 'fullscreen nil)
	(set-frame-parameter nil 'fullscreen 'fullboth)
	(message "Full-screen changed")
	))
(global-set-key "\C-cm" 'my-toggle-frame-size)

;; grep$B7k2L%P%C%U%!$G$N%+!<%=%k0\F0$G%@%$%J%_%C%/$K%U%!%$%k$r3+$/(B
(require 'color-grep)
(setq color-grep-sync-kill-buffer t)

;; M-x grep-find$B$G(BPerl$B$N(Back$B%3%^%s%I$r;H$&$h$&$KJQ99(B
(setq grep-find-command "ack --nocolor --nogroup ")

;; M-x grep-by-ack
;; Perl$B$N(Back$B%3%^%s%I$r;H$C$?(Bgrep($B%+!<%=%kIU6a$NC18l$r%G%U%)%k%H$N8!:w8l$K(B)
(defun grep-by-ack()
  "grep the whole directory for something defaults to term at cursor position"
  (interactive)
  (setq default-word (thing-at-point 'symbol))
  (setq needle1 (or (read-string (concat "ack for <" default-word ">: ")) default-word))
  (setq needle1 (if (equal needle1 "") default-word needle1))
  (setq default-dir default-directory)
  (setq needle2 (or (read-string (concat "target directory <" default-dir " >: ")) default-dir))
  (setq needle2 (if (equal needle2 "") default-dir needle2))
  (grep-find (concat "ack --nocolor --nogroup " needle1 " " needle2)))

;;$B%^%&%9$N%[%$!<%k%9%/%m!<%k%9%T!<%I$rD4@a(B
(global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 2)))

;;$B%F%s%W%l!<%H%U%!%$%k$N@_Dj(B
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/Temp/lisp/")
(setq auto-insert-alist
	  (append '(
				("\\.cpp" . "hoge.cpp")
				 ) auto-insert-alist))


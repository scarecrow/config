(set-language-environment 'Japanese)
(set-default-coding-systems 'euc-jp-unix)
(set-buffer-file-coding-system 'euc-jp-unix)
(set-keyboard-coding-system 'sjis-mac)
(set-clipboard-coding-system 'sjis-mac)
(utf-translate-cjk-mode 1)
(setq-default buffer-file-coding-system 'utf-8)
;(set-file-name-coding-system 'utf-8)

;; コンパイル時の文字化けを修正
(setq shell-mode-hook
	  (function (lambda () 
				  (set-buffer-process-coding-system 'euc-jp-unix 
													'euc-jp-unix))))

;; 前と同じ行の幅にインデント
(setq c-tab-always-indent t)
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; 補完候補を自動的に表示
;; auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; append elrang-mode
(setq ac-modes
	  (append ac-modes
			  (list 'erlang-mode)))

;; シフト+矢印で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; キーバインド
(global-set-key "\C-x\C-i" 'indent-region)	; 選択範囲をインデント
(global-set-key "\C-m" 'newline-and-indent) ;リターンで改行とインデント

(global-set-key "\C-cc" 'comment-region) ; C-c cを範囲指定コメントに
(global-set-key "\C-cu" 'uncomment-region) ; C-c uを範囲指定コメント解除に

;; ステータスラインに時刻表示
(setq display-time-day-and-date t)
(display-time)

(show-paren-mode t)						; 対応する括弧を光らせる
(transient-mark-mode t)					; 選択範囲のハイライト

;;スタートアップページを表示しない
(setq inhibit-startup-message t)

;;メニューバーを隠す
(tool-bar-mode -1)

;; 長い行の折り返し表示を nil:しない。 t:する。
(setq truncate-lines nil)
(setq truncate-lines-width-windows nil)

;;ウィンドウ設定
(if window-system
	(set-keyboard-coding-system 'sjis-mac) 
  (progn
	(set-keyboard-coding-system 'utf-8)
	(set-terminal-coding-system 'utf-8)))

;; linum設定
(require 'linum)
(global-set-key [f5] 'linum-mode)
(add-hook 'lisp-interaction-mode-hook (lambda () (linum-mode t)))
(add-hook 'text-mode-hook (lambda () (linum-mode t)))

;; 範囲選択をC-@で文字列選択と矩形選択に切り替える
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

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 85))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 85)

;フルスクリーン
(set-frame-parameter nil 'fullscreen 'fullboth)
(defun my-toggle-frame-size()
  (if (frame-parameter nil 'fullscreen)
	  (set-frame-parameter nil 'fullscreen nil)
	(set-frame-parameter nil 'fullscreen 'fullboth)
	(message "Full-screen changed")
	))
(global-set-key "\C-cm" 'my-toggle-frame-size)

;; grep結果バッファでのカーソル移動でダイナミックにファイルを開く
(require 'color-grep)
(setq color-grep-sync-kill-buffer t)

;; M-x grep-findでPerlのackコマンドを使うように変更
(setq grep-find-command "ack --nocolor --nogroup ")

;; M-x grep-by-ack
;; Perlのackコマンドを使ったgrep(カーソル付近の単語をデフォルトの検索語に)
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

;;マウスのホイールスクロールスピードを調節
(global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 2)))

;;テンプレートファイルの設定
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/Temp/lisp/")
(setq auto-insert-alist
	  (append '(
				("\\.cpp" . "hoge.cpp")
				 ) auto-insert-alist))


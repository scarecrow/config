setopt auto_pushd
setopt auto_cd
setopt correct
setopt cdable_vars

setopt listtypes

unsetopt case_glob
setopt flow_control ignoreeof



#cdコマンドのサーチパス
cdpath=(.. ~ ~/src ~/zsh)

#デフォルトパーミッションの設定
#新規ファイルは644, 新規ディレクトリは755
umask 022

#エイリアス定義
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias j='jobs'
alias h='history'
alias grep=egrep
alias ll='ls -l -F'
alias la='ls -a -F'

alias fcd='source /bin/fcd.sh'
alias here='open .'
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'


#ディレクトリとシンボリックリンクのみ表示するエイリアス
alias lsd='ls -ld *(-/DN)'

#"."で始まるファイルのみを表示するエイリアス
alias lsa='ls -ld .*'

#グローバルエイリアスの設定
alias -g M=' |more'
alias -g H=' |head'
alias -g T=' |tail'
alias -g G=' |grep'
alias -g GI=' |grep -i'

#重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

#プロンプトの設定
PROMPT='%m%# '
RPROMPT=' %~'

#その他の環境変数の定義
HISTSIZE=2000
SAVEHIST=100000
HISTFILE=~/.zhistory
DIRSTACKSIZE=20

#zshオプションの設定
setopt notify globdots correct pushdtohome cdable_vars autolist
setopt correctall auto_cd recexact longlistjobs
setopt autoresume histignoredups noclobber
setopt auto_pushd pushdminus extended_glob

#zshモジュールのロード
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
zmodload zsh/mathfunc

#キーバインドはemacsモードにする
bindkey -e
bindkey "^P" history-beginning-search-backward

#補完機能を有効にする
autoload -U compinit
compinit

#プロンプトに色を付ける
autoload -U colors
colors

#エディタzedを起動
autoload zed
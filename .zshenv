# Japanese setting
export LANG=ja_JP.UTF-8
export SHELL=/bin/zsh
umask 022

# Path Setting
path=($HOME/local/bi $HOME/local/X11R6/bin \
    /bin /usr/local/bin /usr/bin /opt/local/bin \
    /usr/X11R6/bin /usr/local/mysql/bin /sbin)

manpath=(/usr/share/man )
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export LD_RUN_PATH="$HOME/local/lib:$LD_RUN_PATH"

export EDITOR="emacs"
export SVN_EDITOR="emacs"

. /sw/bin/init.sh

### end of file


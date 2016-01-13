# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# We want colorized ls output too with termite!
eval $(dircolors ~/.dircolors)

# Have Java UI's play nice with bspwm.
export _JAVA_AWT_WM_NONREPARENTING=1

# Force qt5 to use the gtk theme
export QT_STYLE_OVERRIDE=GTK+

# Golang
export GOPATH=~/go

# Default editor is vim
export VISUAL=vim
export EDITOR="$VISUAL"

# Expand our path a bit
PATH="$PATH:/opt/gradle-distributions/gradle/bin"
PATH="$PATH:/usr/NX/bin"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:/opt/android-sdk/build-tools/23.0.2"
PATH="$PATH:/opt/android-ndk/"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

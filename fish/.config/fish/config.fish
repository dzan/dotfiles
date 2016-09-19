# OPAM configuration
source /Users/dzan/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# No greeting
set -gx fish_greeting ""

# Keys
set -g fish_key_bindings fish_default_key_bindings
fzf_key_bindings

# Default editor
set -gx EDITOR nvim

# Default less options
set -gx LESS RMX

# Expand path
set -gx PATH /usr/local/php5/bin $PATH
set -gx PATH /opt/arcanist/arcanist/bin $PATH

set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -gx MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH

set -gx PATH /opt/llvm/bin $PATH
set -gx PATH /Library/iXGuard/bin $PATH

# GOLANG configurations in .config/fish/config.fish
set -x GOPATH $HOME/go
set -x GOROOT /usr/local/opt/go/libexec
set PATH $GOPATH/bin $GOROOT/bin $PATH

# Asan
set -gx ASAN_OPTIONS 'detect_container_overflow=0'

# Use ranger to change dirs
function rcd
    set tmpfile "/tmp/pwd-from-ranger"
    ranger --choosedir=$tmpfile $argv
    set rangerpwd (cat $tmpfile)
    if test "$PWD" != $rangerpwd
        cd $rangerpwd
    end
end

# helpers
function objc-dump
    class-dump $argv  | highlight -S objc -O ansi | less
end

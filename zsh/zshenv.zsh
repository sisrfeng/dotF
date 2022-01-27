# if you rely solely on .zshrc, your non-interactive shell scripts won’t work
# if they depend on the $PATH.
# Your $PATH and any other important ENV variable should be set in .zshenv.

export ZDOTDIR="$HOME/dotF/zsh"

# github.com/rafi/.config
# 注意 这是为bash配置的, 可能和zsh不同?

# what defaults values should be used if the environment vars are empty or not set.
# So there is no need to set the values unless you want to change the default ones
# 非也! 设了可以避免$XDG啥啥啥 为空

# user-specific
    # XDG_CONFIG_HOME
        # Where  configurations should be written (analogous to /etc).
        # Should default to $HOME/.config.
    # XDG_CACHE_HOME
        # Where user-specific non-essential (cached) data should be written (analogous to /var/cache).
        # Should default to $HOME/.cache.
    # XDG_DATA_HOME
        # Where user-specific data files should be written (analogous to /usr/share).
        # Should default to $HOME/.local/share.
        # 例子:
            # {XDG_DATA_HOME:-$HOME/.local/share}
            # curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # XDG_STATE_HOME
        # Where user-specific state files should be written (analogous to /var/lib).
        # Should default to $HOME/.local/state


export XDG_CONFIG_HOME="$HOME/.config"
# export  XDG_CACHE_HOME="$HOME/.cache"
export  XDG_CACHE_HOME="$HOME/d/.cache_wf"
export   XDG_DATA_HOME="$HOME/.local/share"

[ -d "$XDG_CONFIG_HOME" ] || mkdir -m 0750 "$XDG_CONFIG_HOME"
[ -d "$XDG_CACHE_HOME" ]  || mkdir -m 0750 "$XDG_CACHE_HOME"
[ -d "$XDG_DATA_HOME" ]   || mkdir -m 0750 "$XDG_DATA_HOME"

# 先别管这些, 最底下export了PATH

            # # export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
            # # export XINITRC="$XDG_CONFIG_HOME"/xorg/xinitrc
            #
            # EDITOR=vim
            # if hash nvim 2>/dev/null; then
            #     export MANPAGER='nvim +Man!'
            #     EDITOR=nvim
            # fi
            # export EDITOR
            # export VISUAL="$EDITOR"
            #
            # export LESSCHARSET="UTF-8"
            #
            # # Set the session ssh-agent socket path (If it's not set)
            # [ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
            #
            # # Look for terminfo files under data and find system collections
            # if [ -d "$XDG_DATA_HOME/terminfo" ]; then
            #     export TERMINFO="$XDG_DATA_HOME/terminfo"
            #     export TERMINFO_DIRS="$TERMINFO"
            #     if [ -d "$PREFIX/share/terminfo" ]; then
            #         export TERMINFO_DIRS="$TERMINFO_DIRS:$PREFIX/share/terminfo"
            #     fi
            #     if [ -d "$PREFIX/opt/ncurses/share/terminfo" ]; then
            #         export TERMINFO_DIRS="$TERMINFO_DIRS:$PREFIX/opt/ncurses/share/terminfo"
            #     fi
            # fi
            #
            # export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/rc"
            # export ZPLUG_REPOS="$XDG_DATA_HOME/zplug/repos"
            # export ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"
            # # export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
            # export PASSWORD_STORE_DIR="$HOME/docs/pass/"
            # export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
            # export LESSKEY="$XDG_CONFIG_HOME/lesskey/output"
            #
            # # ZSHZ_DATA
            # # export _Z_DATA="$XDG_CACHE_HOME/z" 别! cache感觉都是些随时可以清理的文件
            #
            # # hash wget       2>/dev/null && export            WGETRC="$XDG_CONFIG_HOME/wget/config"
            # # hash sshrc      2>/dev/null && export           SSHHOME="$XDG_CONFIG_HOME/sshrc"
            #
            # # if hash fzf 2>/dev/null
            # # then
            # #     export FZF_DEFAULT_OPTS="--bind=ctrl-d:page-down,ctrl-u:page-up,ctrl-y:yank,tab:down,btab:up --inline-info --reverse --height 50%"
            # #     export FZF_DEFAULT_COMMAND='ag -U --hidden --follow --nogroup --nocolor -g ""'
            # # fi
            #
            # # export JQ_COLORS="1;30:0;31:0;32:0;33:0;34:1;35:1;36"
            #
            #
            #
            # # Python
            # # Pending: https://github.com/python/cpython/pull/13208
            # export PYTHONHISTORY="$XDG_CACHE_HOME/python_history"
            # # Python utilities
            # export PYLINTHOME="$XDG_CACHE_HOME/pylint"
            # export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
            # #export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
            #
            # # Go configuration
            # if hash go 2>/dev/null; then
            #     export GOPATH="$XDG_DATA_HOME"/go
            #     PATH="$PATH:$GOPATH/bin"
            # fi
            #
            # # Node NPM tool configuration
            # if hash npm 2>/dev/null; then
            #     export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
            #     export N_PREFIX="${XDG_DATA_HOME}/nodejs"
            #     PATH="${N_PREFIX}/bin:$PATH:${XDG_DATA_HOME}/npm/bin"
            # fi
            #
            # # # Rust Cargo configuration
            # # if [ -d "$XDG_DATA_HOME"/cargo ]; then
            # #     export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
            # #     export CARGO_HOME="$XDG_DATA_HOME"/cargo
            # #     PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
            # # fi
            #
            # # # CPAN configuration
            # # if hash cpan 2>/dev/null; then
            # #     export PERL5LIB="$HOME/.local/lib/perl5${PERL5LIB+:}${PERL5LIB}"
            # #     export PERL_LOCAL_LIB_ROOT="$HOME/.local${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
            # #     export PERL_MB_OPT="--install_base \"$HOME/.local\""
            # #     export PERL_MM_OPT="INSTALL_BASE=$HOME/.local"
            # #     hash cpanm 2>/dev/null && export PERL_CPANM_OPT="-l $HOME/.local"
            # # fi
            #
            # # # Always install ruby gems local to the user
            # # if hash gem 2>/dev/null; then
            # #     if [ -d "$PREFIX/opt/ruby/bin" ]; then
            # #         PATH="$PREFIX/opt/ruby/bin:$PATH"
            # #     fi
            # #     export GEMRC="$XDG_CONFIG_HOME/gemrc/config"
            # #     export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem/specs"
            # #     # export GEM_HOME="$HOME/.local/lib/ruby/gems/$(ruby -e 'puts RbConfig::CONFIG["ruby_version"]')"
            # #     # PATH="$PATH:$GEM_HOME/bin"
            # # fi
            #
            #
            # # # Haskell cabal configuration
            # # if hash cabal 2>/dev/null; then
            # #     PATH="$PATH:$HOME/.cabal/bin"
            # # fi
            # #
            #
            # # # Homebrew token
            # # export GITHUB_TOKEN="{{ GITHUB_TOKEN }}"
            # # export HOMEBREW_GITHUB_API_TOKEN="{{ HOMEBREW_GITHUB_API_TOKEN }}"
            #
            # # Spotify
            # # export TMUX_SPOTIFY_API_KEY="{{ TMUX_SPOTIFY_API_KEY }}"
            #
            # # Export the final PATH

# export PATH
# echo "~/dotF/zshenv跑完了"

# echo "$foo" instead of just echo $foo.
# Without double-quotes the variable's contents get parsed in a somewhat weird way that tends to cause bugs.

# 这3行 解决peco里复制的问题, 很多人都unset这个，（它的功能是防止粘贴多行时，乱执行命令）
unset zle_bracketed_paste


# [[===========================================================================begin
# 为了交互使用zsh时可以 通配, 比如 mv ~/Linux/Old/^Tux.png ~/Linux/New/   (mv除了Tux.png的所有文件)
setopt extended_glob  # 可能导致这些命令出bug, 使用时要注意:   git diff HEAD^
# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
# (An initial unquoted ‘~’ always produces named directory expansion.)
#
#  https://www.techrepublic.com/article/globbing-wildcard-characters-with-zsh/
#
# end==============================================================================]]


# todo 有人说，这样可以避免不明alias干扰
# unalias -a

# 敲`zsh 某.sh`时，这里的东西全都不起作用. 放心覆盖built-in命令

export PYTHONPATH=
export PTPYTHON_CONFIG_HOME=$HOME/dotF/cfg/ptpython
export PTIPYTHON_CONFIG_HOME=$HOME/dotF/cfg/ptpython # ptipython
export PYTHONSTARTUP=$HOME/dotF/py_startup.py
# export ZDOTDIR="$HOME:$HOME/dotF/zsh"  # 不能有多个

# 指定nvim等
    export PAGER='bat'
        # 在~/.config/bat/config里设置所有选项
        # 别给theme名字加双引号
    export PAGER='nvimpager'  # 设了会导致delta(git diff)的高亮没了. 要用PAGER=bat git diff
                # 光标移动不及nvim +Man!好
    export PAGER='nvim +Man!'
        # export MANPAGER='nvim +Man!'
        # # nvim的类似用法:nvim +'echom "hi"'
        #                      # Man!    Display the current buffer contents as a manpage.
        #     # Supports bold/underline/etc
        #     # See https://stackoverflow.com/a/4233818/9782020
        #     man_bold() {
        #         eval "unbuffer man -P cat \"$@\" | $MANPAGER"
        #     }
        #
        #     # 但还是有bold underline. 不过没什么用, 先放着
        #     # No bold/underline/etc
        #     man_nobold() {
        #         eval "command man \"$@\" | $MANPAGER"
        #     }
        #

    export VISUAL=nvim  # less 敲v，先找VIUSAL指定的编辑器，没有再找EDITOR
    export EDITOR=nvim  # pudb 敲ctrl E能用EDITOR打开文件编辑
            # If any application wants to invoke a line editor, it can use EDITOR.
            # If any application wants to invoke a visual editor, it can use VISUAL.
            # If any application wants to invoke a pager, it can use PAGER.
    # 不用加-u 指定init.vim 因为默认就在~/.config/下

    # bindkey -M vicmd v edit-command-line
    # 想用vscode编辑命令行，不行
    # if [[ $HOST != 'redmi14-leo' ]] && [[ -z "$TMUX" ]];then  # 远程服务器且用vscode
    #     export EDITOR=code
    #     export VISUAL=code
    # fi


export LOGURU_FORMAT="{time} | <lvl>{message}</lvl>"
export PYTHON_PRETTY_ERRORS=1
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
export TF_CPP_MIN_LOG_LEVEL=2



# LANGUAGE: 是唯一不会被LC_ALL覆盖的同类环境变量？ 也优先于 LC_MESSAGES, and LANG.
# export LANGUAGE=en_US.UTF-8:zh_CN.UTF-8  #  used only for messages (GNU gettext)
export LANGUAGE=en_US.UTF-8  #  used only for messages (GNU gettext)
export LANG=en_US.UTF-8   # 类似LC_ALL，对各种LC_类型起作用，但会被覆盖
# export LC_MESSAGES=zh_CN.UTF-8 #  determines the language and encoding of messages
export LC_MESSAGES=en_US.UTF-8 #  determines the language and encoding of messages
export LC_CTYPE=en_US.UTF-8 #  defines character classes, a named sets of characters
export LC_COLLATE=en_US.UTF-8 # in ASCII order: A B C … a b c…  有些loal是A a B b排的
export LC_NUMERIC=en_US.UTF-8


PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH


# 交互式模式的初始化脚本, 防止被加载两次
if [ -z "$_INIT_SH_LOADED" ]; then   # test -z returns true, if the parameter is empty
    _INIT_SH_LOADED=1
else
    return  #不再执行剩下的才做，退出.zshrc
fi

# exit for non-interactive shell:
# `$-` : 获取“-”这个变量的值(类似于$PATH  $HOME)。他表示zsh -c 等参数(类似rm -rf中的r和f)，又称flag
# i: 表示interactive，[但自动补全时，显示I h等，不显示i，因为没有意义] --
    # 只敲zsh时，默认就是进了交互式程。
    # 另外，在bash命令行下，敲zsh -i my_echo.sh，echo里面的东西之后，还是回到bash
[[ $- != *i* ]] && return



# https://zsh.sourceforge.io/Intro/intro_6.html
DIRSTACKSIZE=15 # Setup dir stack
setopt autopushd  pushdminus pushdsilent pushdtohome pushdignoredups cdablevars





# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95  :
# 对于tmux:
# The screen-256color in most cases is enough and more portable solution.
# But it does not support any italic font style.

# Unfortunately, The latest (6.2) ncurses version does not work properly:
# set -g default-terminal "tmux-256color"  # 先别用
#
# export TERM="screen-256color"  #之前没在zshrc设TERM，没进tmux就不会用vi-mode。 设了这个，没进tmux也会用vi-mode,
# export TERM="tmux-256color"  #之前没在zshrc设TERM，没进tmux就不会用vi-mode。 设了这个，没进tmux也会用vi-mode,


# case EXPRESSION in
#  (PATTERN_1)
#     STATEMENTS
#     ;;
#  (PATTERN_2)
#     STATEMENTS
#     ;;
#  (PATTERN_N)
#     STATEMENTS
#     ;;
#  (*)
#     STATEMENTS
#     ;;
# esac

# 如果终端支持truecolor, 用之
case $TERM in
    # export TERM="xterm-256color" # Enable 256 color to make auto-suggestions look nice
    (screen-256color |  tmux-256color   |  xterm-256color  )
        # Set the COLORTERM environment variable to 'truecolor' to advertise 24-bit color support
        # COLORTERM 的选项:no|yes|truecolor
        export COLORTERM=truecolor
        ;;           # 一个分号能把2个命令串在一起,所以要2个分号
    (*)              #  (*) :  a final pattern to define the default case  This pattern will always match? 不是啊, 就跟if else差不多
        echo 'TERM是:'
        echo $TERM
        echo '---'
        echo 'COLORTERM是'
        echo ${COLORTERM}
        ;;
esac


# 某工具里教的#  put `fpath=(~/你的zsh函数所在路径 $fpath)` somewhere before `compinit` in your

# FPATH 是scaler, 冒号分隔
# fpath 是个array
# 默认下，二者所含东西相同

# path 和PATH同理。

fpath=(~/.local/bin $fpath)
fpath=(~/dotF/zsh/_zfunc $fpath)  # _zfunc用于存放自动补全命令  要在compinit之前.
autoload -U compinit # -U : suppress alias expansion for functions

compinit -d $XDG_CACHE_HOME/zcompdump-$ZSH_VERSION  # 指定compinit的缓存文件的存放位置
# 不会自动帮你新建文件夹

setopt autocd
setopt globdots
setopt interactivecomments






autoload -U select-word-style
select-word-style bash  # 斜杠 下划线等 会作为单词的分隔
# zplug里面的vim-mode搞鬼，导致放在zplug load后 会不起作用

# [[==================================zsh插件管理：zplug=================================
# 别用等号对齐! zsh的空格是有意义的!
# zplug的环境变量都在这里指定了
export ZPLUG_HOME=$HOME/.zplug && source $ZPLUG_HOME/init.zsh
# 其余的zplug环境变量,统一用默认的.
# 换机器时,  敲这个就好,别同步$ZPLUG_HOME, 权限\缓存啥的有冲突
        # git clone https://github.com/zplug/zplug $ZPLUG_HOME

export PS_PERSONALITY=linux  # Without this setting, ps follows the useless and bad parts
                             # of the Unix98 standard.

# use double quotes
# zplug "modules/prompt", from:prezto
# zplug "soimort/translate-shell"  #  不行
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "srijanshetty/zsh-pip-completion" # 能补全pip包的名字，但没生效
# 这两个插件有点像: 先试着自己配, 参考他们的内容
    # zplug "zsh-users/zsh-completions"
    # zplug "marlonrichert/zsh-autocomplete"

# 避免冲突，顺序： zsh-autosuggestions > zsh-syntax-highlighting > zsh-vim-mode
zplug "zsh-users/zsh-autosuggestions"  # 弹出之前敲过的命令
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888,bg=bold"

# todo
# zplug "agkozak/zsh-z"
zplug "rupa/z", use:z.sh # 这样不行： zplug "rupa/z", as:plugin, use:"*.sh"

# 下面这个插件，must be loaded after:
# 1. executing compinit command (让defer>= 2 )
# 2. sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # 对命令行中的目录 可执行文件等 进行语法高亮

zplug "zsh-users/zsh-history-substring-search"  # 要在syntax-highlighting后面  , 在我建的bindky.zsh里面改快捷键


# zplug "jeffreytse/zsh-vi-mode"  # 有奇怪错误，提issue很繁琐，别用了。


# bindkey -v  # select viins keymap and bind it to main  # 在softmoth/zsh-vim-mode里面已经有这行
zplug "softmoth/zsh-vim-mode"  # 没有这个，也会进vim-mode, 或者vi-mode？用了它，ctrl →和←都能正常在单词间跳转
# todo: 自己配键位
bindkey -M vicmd V edit-command-line

# zplug "hchbaw/zce.zsh"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load     # source plugins and add commands to $PATH
# zplug load --verbose

# zplug update  #需要时，自己敲
# ==================================zsh插件管理：zplug=================================]]


# 关于run-help
# >_>_>===================================================================begin
        # 如果zsh设置了`alias run-help=man才需要：
        # unalias run-help 2> /dev/null  和下面这行一样？
        # unalias run-help &> /dev/null

        # -U  | suppress usual alias expansion for functions, recommended for the use of
        # functions supplied with the zsh distribution  \
            # for functions precompiled with the zcompile builtin command \
                # the flag `-U must be provided` when the `.zwc file is created`
        autoload -Uz run-help   # -z  | mark function for zsh-style autoloading
        autoload -Uz run-help-ip  # 暂时用不着，不过开始开着吧
        run-help-sudo(){
        if [ $# -eq 0 ]; then
            man sudo
        else
            man $1
        fi
        }

        # autoload -Uz run-help-git
        run-help-git(){
        if [ $# -eq 0 ]; then
            man git
            echo 'hi, leo. Just manpage .'
        else
            local al
            if al=$(git config --get "alias.$1"); then
                1=${al%% *}
            fi
            man git-$1
            echo 'hi, leo. Above is help for subcommand'
        fi
        }

        run-help-ssh() {
            emulate -LR zsh
            local -a args
            # Delete the "-l username" option
            zparseopts -D -E -a args l:
            # Delete other options, leaving: host command
            args=(${@:#-*})
            if [[ ${#args} -lt 2 ]]; then
                man ssh
            else
                run-help $args[2]
            fi
        }

        # 之前只能跳到zshbuiltins，是应为没设置 HELPDIR
        [ -d /usr/share/zsh/help ] && HELPDIR=/usr/share/zsh/help
        [ -d /usr/local/share/zsh/help ] && HELPDIR=/usr/local/share/zsh/help

# 放在插件管理后面，避免被别人的配置覆盖

# 不能用\换行
# 不用LESS这个环境变量, 放到alias里? 不，man要用LESS
export LESS='--incsearch --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=2 -X'

    #--RAW-CONTROL-CHARS 就是-R  h
    # Man-db passes extra options to the pager via the `LESS` environment variable,
    # which Less interprets in the same way as command line options.
    # The setting is hard-coded at compile time and starts with -i.
    # (The value is "-ix8RmPm%s$PM%s$" as of Man-db 2.6.2; the P…$ part is the prompt string.)
    # 这又是啥？
    # export LESS='-Dd+r$Du+b'

    # 其中的 "--RAW-CONTROL-CHARS":   Get color support for 'less'
    # --no-init: 即-X,  避免the deinitialization string does something unnecessary, like clearing the screen
    # --HILITE-UNREAD:  highlight first unread line after forward movement

    # https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/


source $HOME/dotF/zsh/color_less_很少用了.zsh
source $HOME/dotF/zsh/color_syntax高亮.zsh
source $HOME/dotF/zsh/tab补全_comp.zsh  #  设置颜色 候选等
source $HOME/dotF/zsh/ls_color.zsh


source $HOME/dotF/zsh/hist_cfg.zsh
# todo: 检查一遍再source
# source /home/wf/dotF/per-dir-history.zsh

source $HOME/dotF/zsh/alias.zsh   # 里面有：chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
source $HOME/dotF/zsh/bindkey_wf.zsh

autoload -Uz chpwd_recent_dirs  cdr add-zsh-hook  # -U: suppress alias expansion for functions
add-zsh-hook chpwd chpwd_recent_dirs


# If you want to preserve (and don't want to alter) the existing definition, you can :
# prmptcmd() { eval "$PROMPT_COMMAND" }
# precmd_functions=(prmptcmd)


# =============================================================================================
# 放到zplug的东西前 会报错
# setopt ignorebraces     #  turns off csh-style brace ({)   expansion.  不知道哪里复制来的
# 设置前后：
#  echo x{y{z,a},{b,c}d}e
            # xyze xyae xbde xcde

#  echo x{y{z,a},{b,c}d}e
            # xyze xyae xbde xcde
# =============================================================================================


# done附近报错：
## 整理 PATH，删除重复路径:
# if [ -n "$PATH" ]; then
#     old_PATH=$PATH:; PATH=
#     while [ -n "$old_PATH" ]; do
#         x=${old_PATH%%:*}
#         case $PATH: in
#            *:"$x":*) ;;
#            *) PATH=$PATH:$x;;
#         esac
#         old_PATH=${old_PATH#*:}
#     done
#     PATH=${PATH#:}
#     unset old_PATH x
# fi


if grep -q WSL2 /proc/version ; then  # set DISPLAY to use X terminal in WSL
    echo '进了wsl'
    # execute route.exe in the windows to determine its IP address
    export PATH="$PATH:/mnt/c/Windows/System32"  # many exe files here, such as curl.exe, route.exe
    # DISPLAY为空，也可以用tmux-yank, 因为是本地 而非远程？
    # DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
    export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0

else # set $DISPLAY  under tmux
    # 用于tmux重新连接_不过真的需要吗

    # if [[ -z "$TMUX" ]]; then
                # -z： 变量为空，记作zero？
                # -v更好？  -v: variable is set
    if [[ -z "$TMUX" ]]; then
        # 前面设了alias tm
        # tm
        # 敲tm, 导致vim进terminal后 弹出
        # echo '非wsl. $TMUX为空'
    else
        session_name=`tmux display-message -p "#S"`
        DIS_file="$XDG_CACHE_HOME/.DISPLAY_for_tmux_$session_name"
               # DIS_file='~/d/.DISPLAY_for_tmux'  别用~, 用$HOME, 而且不能在单引号里
        if [[ -f $DIS_file ]]; then  # 读
            export DISPLAY=`cat ${DIS_file}`
        else
            echo $DISPLAY > ${DIS_file}  # 存
        fi
    fi
fi



# pip zsh completion start
    function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
                COMP_CWORD=$(( cword-1 )) \
                PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
    }
    # compctl -K _pip_completion /data/wf/anaconda3/envs/py38_torch18/bin/python3 -m pip
    compctl -K _pip_completion pip
    compctl -K _pip_completion pip3



export PATH="$PATH:/usr/local/go/bin"

# 别多手把前面的export PATH中的export扔了。万一脚本中途 子shell依赖的变量没export呢？
# time测时间，export耗时太短忽略不计？


# >_>_>===================================================================begin
# fuzzy finder

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
#     export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
# fi

# Auto-completion  # 不灵，因为没严格按照教程按照？
# ---------------
# zsh --interative ？
[[ $- == *i* ]] && source "$HOME/dotF/fuzzyF/shell/completion.zsh" 2> /dev/null

# source "$HOME/dotF/fuzzyF/shell/key-bindings.zsh"
# end=====================================================================<_<_<


# -----------------------conda-----------------------------

        # echo $CONDA_DEFAULT_ENV  # 此时是空白

        # interactive shell的话, 一般都是执行 eval "$__conda_setup"
        #  Contents within this block are managed by 'conda init'
            # __conda_setup="$('/home/wf/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
            # if [ $? -eq 0 ]; then
            #     eval "$__conda_setup"
            # else
            #     if [ -f "/home/wf/anaconda3/etc/profile.d/conda.sh" ]; then
            #         . "/home/wf/anaconda3/etc/profile.d/conda.sh"
            #     else
            #         export PATH="/home/wf/anaconda3/bin:$PATH"
            #     fi
            # fi
            # unset __conda_setup

        # export PATH="/home/wf/anaconda3/bin:$PATH"  无法代替上面一个block
        # eval "$__conda_setup" 其实是干了: (我把最后的conda activate base删了)

            export CONDA_EXE='/data/wf/anaconda3/bin/conda'
            export _CE_M=''
            export _CE_CONDA=''
            export CONDA_PYTHON_EXE='/data/wf/anaconda3/bin/python'

            # Copyright (C) 2012 Anaconda, Inc
            # SPDX-License-Identifier: BSD-3-Clause

            __add_sys_prefix_to_path() {
                # In dev-mode CONDA_EXE is python.exe and on Windows
                # it is in a different relative location to condabin.
                if [ -n "${_CE_CONDA}" ] && [ -n "${WINDIR+x}" ]; then
                    SYSP=$(\dirname "${CONDA_EXE}")
                else
                    SYSP=$(\dirname "${CONDA_EXE}")
                    SYSP=$(\dirname "${SYSP}")
                fi

                if [ -n "${WINDIR+x}" ]; then
                    PATH="${SYSP}/bin:${PATH}"
                    PATH="${SYSP}/Scripts:${PATH}"
                    PATH="${SYSP}/Library/bin:${PATH}"
                    PATH="${SYSP}/Library/usr/bin:${PATH}"
                    PATH="${SYSP}/Library/mingw-w64/bin:${PATH}"
                    PATH="${SYSP}:${PATH}"
                else
                    PATH="${SYSP}/bin:${PATH}"
                fi
                \export PATH
            }

            __conda_exe() (
                __add_sys_prefix_to_path
                "$CONDA_EXE" $_CE_M $_CE_CONDA "$@"
            )

            __conda_hashr() {
                if [ -n "${ZSH_VERSION:+x}" ]; then
                    \rehash
                elif [ -n "${POSH_VERSION:+x}" ]; then
                    :  # pass
                else
                    \hash -r
                fi
            }

            __conda_activate() {
                if [ -n "${CONDA_PS1_BACKUP:+x}" ]; then
                    # Handle transition from shell activated with conda <= 4.3 to a subsequent activation
                    # after conda updated to >= 4.4. See issue #6173.
                    PS1="$CONDA_PS1_BACKUP"
                    \unset CONDA_PS1_BACKUP
                fi
                \local ask_conda
                ask_conda="$(PS1="${PS1:-}" __conda_exe shell.posix "$@")" || \return
                \eval "$ask_conda"
                __conda_hashr
            }

            __conda_reactivate() {
                \local ask_conda
                ask_conda="$(PS1="${PS1:-}" __conda_exe shell.posix reactivate)" || \return
                \eval "$ask_conda"
                __conda_hashr
            }

            conda() {
                \local cmd="${1-__missing__}"
                case "$cmd" in
                    activate|deactivate)
                        __conda_activate "$@"
                        ;;
                    install|update|upgrade|remove|uninstall)
                        __conda_exe "$@" || \return
                        __conda_reactivate
                        ;;
                    *)
                        __conda_exe "$@"
                        ;;
                esac
            }

            if [ -z "${CONDA_SHLVL+x}" ]; then
                \export CONDA_SHLVL=0
                # In dev-mode CONDA_EXE is python.exe and on Windows
                # it is in a different relative location to condabin.
                if [ -n "${_CE_CONDA:+x}" ] && [ -n "${WINDIR+x}" ]; then
                    PATH="$(\dirname "$CONDA_EXE")/condabin${PATH:+":${PATH}"}"
                else
                    PATH="$(\dirname "$(\dirname "$CONDA_EXE")")/condabin${PATH:+":${PATH}"}"
                fi
                \export PATH

                # We're not allowing PS1 to be unbound. It must at least be set.
                # However, we're not exporting it, which can cause problems when starting a second shell
                # via a first shell (i.e. starting zsh from bash).
                if [ -z "${PS1+x}" ]; then
                    PS1=
                fi
            fi

        export CONDA_DEFAULT_ENV
        # todo:
        # 一个session 指定一个conda
        # https://stackoverflow.com/questions/20701757/tmux-setting-environment-variables-for-sessions



#
# prompt  ps1等
    autoload -U promptinit    # -U: suppress alias expansion for functions
    promptinit
    autoload -U colors && colors
        # 定义了fg  bg等环境变量
        # Red, Blue, Green, Cyan, Yellow, Magenta, Black & White


    # https://void-shana.moe/linux/customize-your-zsh-prompt.html

    换行=$'\n'
    上行=$'\e[1A'
    上行=$'\e[1B'


    PS1=
        PS1+="%{${CONDA_PROMPT_MODIFIER}"
                    # export PS1="%{$fg[cyan]%}【82服务器】%~       %T_周%w号"${换行}">%{$reset_color%}"
                    # 放文件开头时，颜色时有时无
                    # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
                    # 不加下面这行，改了conda环境时，才显示（环境名）?
                        # PS1="${换行}%{${CONDA_PROMPT_MODIFIER}"
        PS1+="$fg[cyan]%}%~${换行}"
        PS1+="%{$reset_color%}"
        PS1+=">"
        export PS1

    source ~/dotF/zsh/zsh-git-prompt/zshrc.sh
        function precmd {
            export RPS1='$(git_super_status)'
        }

    export PS2="%{$fg[cyan]%}%_>%{$reset_color%}"
    export RPS2="%{$fg[cyan]%} 换行后继续敲  %{$reset_color%}"
    # 别加$bg[white]:
    # export RPS2="%{$fg[cyan]$bg[white]%} 换行后继续敲  %{$reset_color%}"

export RANGER_LOAD_DEFAULT_RC=FALSE

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi
#
# 之前把PATH拼错成PAHT了
# export PATH="$HOME/dotF/nvim-linux64/bin:$HOME/dotF/mini_FS/bin:$PATH:/snap/bin"
export PATH="$HOME/dotF/mini_FS/bin:$PATH:/snap/bin"
# 找nvim时, 优先找dotF里面的,别用/bin等系统目录
# 这个就不必了:alias nvim='~/dotF/nvim-linux64/bin/nvim'
#


# homebrew
    # 需要更新时自己敲 brew update
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew_wf="/home/linuxbrew/.linuxbrew"

    # hb() {
    #       PATH="$brew_wf/bin:$PATH" \
    #         $brew_wf/bin/brew         \
    #         "$@"
    #     }
    # https://zhuanlan.zhihu.com/p/81840844  #  避免污染系统环境, 不再用下面的 ??

    export HOMEBREW_PREFIX=${brew_wf}
    export HOMEBREW_CELLAR="${brew_wf}/Cellar"
    export HOMEBREW_REPOSITORY="${brew_wf}/Homebrew"
    export PATH="${brew_wf}/bin:${brew_wf}/sbin${PATH+:$PATH}"
        # bash里好像是:+ 下面内容待确认
        # ${PATH+:$PATH}
            # if $PATH exists  and is not null ,  then add :$PATH
                # you don't want to add the leading (or trailing) colon if $PATH is undefined.
                # A zero-length (null) directory name in the path, as in
                # :/usr/local/bin:/usr/bin,
                # /usr/local/bin:/usr/bin:,
                # /usr/local/bin::/usr/bin,
                # means search the current directory.
        # ${wf_var+:$PATH}
    export MANPATH="${brew_wf}/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="${brew_wf}/share/info:${INFOPATH:-}"  # 最后的减号是啥?zsh的文档太难懂了...
    export HOMEBREW_BAT=1

export BROWSER=w3m
source ~/local.zsh

# dl && echo '开了代理'

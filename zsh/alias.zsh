# The shell evaluation order ( POSIX) 优先级递减:
    # aliases
    # variables
    # command substitutions
    # special built-ins
    # functions
    # regular built-ins

    # https://stackoverflow.com/questions/6162903/why-do-backslashes-prevent-alias-expansion
    # `env --ignore-environment`  比`\`更强, 解决了链接中2的缺点


# nn: new name 或者nick name
alias nn='alias'

nn zbk='e ~/dotF/zsh/bindkey_wf.zsh ; zsh'
nn ll='flake8'
nn pl='e ~/dotF/cfg/nvim/plug_wf.vim'

nn con='conda'
nn ci='conda install -y'
# conda create --name new_name --clone old_name
# conda remove --name old_name --all # or its alias: `conda env remove --name old_name`
cda(){
    conda activate $1
    echo "$1" > $XDG_CACHE_HOME/conda_name
        # echo "$foo" instead of just echo $foo.
        # Without double-quotes the variable's contents get parsed in a somewhat weird way that tends to cause bugs.

}
nn c_ac='conda activate'
nn c_de='conda deactivate &&  t $XDG_CACHE_HOME/conda_name'
    # 结合tmux send-keys  'conda activate `cat $XDG_CACHE_HOME/conda_name`' Enter


nn '$'='' # 省去删掉复制来的命令 最前面的$
    # https://stackoverflow.com/questions/58601523/how-do-i-remove-the-head-of-dollar-sign-on-stdin-line-in-shell#comment103516994_58601646



nn w3m='echo "w3m或者ranger显示图片是很难的__等关注的issue的邮件通知吧" ; w3m'
nn u='unset ALL_PROXY'

# 多加一个找manpage的路径
# -M 指定manpath
nn man='man -M "$(manpath -g):~/dotF/man_wf"'

# 在~/dotF/mini_FS/bin 下
nn names='massren'
nn rename='massren'
#  never use normal sudo to start graphical applications as root
# 否则普通用户可能无法登陆（文件变成root的了）
#

nn fzf='~/dotF/fuzzyF/bin/fzf --height 40% --layout=reverse --border'

nn cfg='~/dotF/cfg/'

export CHTSH_CONF='~/dotF/cfg/cht.sh.conf'
# nn ch='echo "搜Stack Overflow还行, tldr别用它" ; cht.sh --shell'
nn ch='echo "tldr找不到的话, 直接上Stack Overflow吧", 不管别人怎么夸这个cheatsheet, 但目前没屁用!!!!!!!!!!!!!'

# todo: bat换成nvimpager?  单页能显示完的就还是用bat?
# cheat website
chw(){
    # curl --silent "cheat.sh/$*""\?T" | bat
    # 要下面这样写才行：
    tmp="cheat.sh/$*"
    curl --silent $tmp\?T | bat
    }
nn chw='echo "tldr找不到的话, 直接上Stack Overflow吧'

nn nvtop='/home/wf/d/fancy_repo_follow_up/nvtop_wf_built/usr/local/bin/nvtop'

aps(){
    apt search $1 | peco
}

# file1=`cat answer.txt` 不及：
# file1 = $(cat answer.txt)  # 能避免特殊字符发挥作用


# nn echo='print "正在用print代替echo" && print -l'
nn ec='print -l && print "正在用print代替echo" '

nn ver='version'

nn grep='grep --color=always'
nn gr='grep'


ht(){
    # 把这个视为“std重定向符”：  >&
    # 2>&1  : stderr > stdout
    # 2>1  1会被当作为文件名
    # https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean

    nohup $* 2>&1 &
    # 例子：
    # ht python train.py > ./mylog.txt
    # 这样就把stderr重定向成stdout，stdout重定向到mylog.txt,  敲完这行，命令行没有输出，继续敲下一个命令
}

alias cle='clear -x'

q(){
    tree -L 2 --filelimit=50 $1 | peco
}

git_rm_sub(){
    sub_name=$1
    git submodule deinit -f $sub_name
    rm -rf .git/modules/$sub_name
    git config -f .gitmodules --remove-section submodule.$sub_name
    git rm --cached $sub_name
    git commit -m "彻底清理submodule: $sub_name"
}

# alias git='LANG=en_GB git' # 不行

# zip
zi(){
    # on the words between the [[ and ]];
        # not performed:
            # Word splitting
            # filename expansion
        # performed.
            # tilde expansion,
            # parameter and variable expansion,
            # arithmetic expansion,
            # command substitution,
            # process substitution,
            # quote removal


        # [[ -a FILE_NAME ]], the "! -a" asks if the file does not exist.
            # https://www.cnblogs.com/itxdm/p/If_in_the_script_determine_the_details.html
            # https://zhuanlan.zhihu.com/p/361667506

        # test 等价于 [ 你的条件 ],
        # 这个更先进： [[ 你的条件 ]]

    # https://unix.stackexchange.com/questions/161905/adding-unzipped-files-to-a-zipped-folder
    if [[ -f ~/tmp_at_home.zip ]]; then
    # if [[ -f '~/zip_folder/' ]]; then   # 用引号包住文件路径，就成了string， -f判断的是file。这里才要加引号(包住的是$加上变量）： if [ "$testv" = '!' ]; then
        t ~/tmp_at_home.zip
    else
        echo "放心, tmp_at_home.zip之前不存在"
    fi

    # todo
    # zip -r foo foo --exclude \*.cpp \*.py
    # if [[ -d $2 ]]   #$2是文件或目录
    # then
        # echo 不收纳"$2" 但貌似会在压缩包里 建立一个同名目录
        # zip -r ~/tmp_at_home.zip "$1"  -x  "$2"
    # else
        # zip -r ~/tmp_at_home.zip $1
    # fi

    zip -r ~/tmp_at_home.zip $1
    # 看多大：
    du --summarize --human-readable ~/tmp_at_home.zip

}

# () 含义：declaring a function.
unzip_multi(){
    #  for 循环不放文件最开头 就报错，奇怪了
    for x in $*
    do
        #${varible:n1:n2}:截取变量varible从n1到n2之间的字符串。 类似python
        dir=${x:0:-4}
        \mkdir --parent --verbose ${dir}
        unzip ${x} -d ${dir} && t ${x}
    done
}
nn -s zip=unzip_multi

# Use [] : if you want your script to be portable across shells.
# Use [[]] : if you want conditional expressions not supported by `[]` and don't need to be portable.
#

nn nls='export chpwd_functions=()'
# nn cd='export chpwd_functions=() ; builtin cd' #  加了这行，就算没敲cd，chpwd_functions也废掉了



# >_>---------------------------------------------------------关于mtime--------------------------------->_>
# -print0: uses a null character to split file names, and
# --null 或者 -0： expect NUL characters as input separators
# stat --format ''
# %y :  time of last data `modification`
# tac  倒着列出  # cat倒过来
# %y表示  `modify time`

mt(){
    # echo '如果在目录下新增内容，该目录的mtime会变。'
    # echo '如果只是修改其下内容，则不变'
                                                        # %y得到的  +0800表示东八区
    find $1 -type f -print0 |                       \
        xargs --null stat --format "%y 改%n"  |     \
        sort --numeric-sort --reverse |             \
        head -50 |                                  \
        cut --delimiter=' ' --fields=1,2,4 |        \
        awk -F " "                                  \
        '{OFMT="%.6f" ; \
        print NR"】", \
        $1,           \
        " ",          \
        $2,           \
        " ",          \
        $3            \
        }'  | $PAGER   # 这里不能用双引号代替单引号
    # date --date="${UglyTime}"  +"%Y年%m月%d日 %X"` | \
    # PrettyTime=`date --date="${UglyTime}"  +"%Y年%-m月%-d日 %X"
}

# access time
# mtime变了，ctime跟着变。ctime变了，atime跟着变
# https://zhuanlan.zhihu.com/p/429228870  # atime不是很可靠
# at(){
#     find $1 -type f -print0 | xargs --null stat --format '%x Acess%n'  | \
#     sort --numeric-sort --reverse | \
#     head -100 | \
#     cut --delimiter=' ' --fields=1,2,4 | \
#     tac | \
#     awk -F " " \
#     '{OFMT="%.6f" ; \
#     print NR"】", \
#     $1,           \
#     " ",          \
#     $2,           \
#     " ",          \
#     $3            \
#     }' | bat    # 这里不能用双引号代替单引号
# }

# ct(){
#     echo 'status （meta data) changed 时间, 当作birth time吧，birth没记录'
#     find $1 -type f -print0 | xargs --null stat --format '%z metadata被改%n'  | \
#     sort --numeric-sort --reverse | \
#     head -100 | \
#     cut --delimiter=' ' --fields=1,2,4 | \
#     tac | \
#     awk -F " " \
#     '{OFMT="%.6f" ; \
#     print NR"】", \
#     $1,           \
#     " ",          \
#     $2,           \
#     " ",          \
#     $3            \
#     }' | bat --language=Python   # 这里不能用双引号代替单引号
# }

# The closest you can get is the file's ctime, which is not the creation time, it is the time that the file's metadata was last changed.

# | cut -d: -f2-
#  百分号加字母，在不同命令有不同含义。表示时间时，有些时候不同命令某些程度上一致
#   Convert a specific date to the Unix timestamp format
# date --date="某个表示时间的字符串" '+%格式代码'
# 例如：
# date --date="1may" '+%m%d'
# date --date="may1" '+%m月%d日  没加百分号的字符 随便写'
#‘-’ : suppress the padding altogether:
# date --date="may1" '+%-m月%-d日'
#
# echo "$(stat -c '%n %A' $filename) $(date -d "1970-01-01 + $(stat -c '%Z' $filename ) secs"  '+%F %X')"
# %Y     time of last data modification, seconds since Epoch

# newer time
nt(){
    # to create a file dated 4 p.m., March 20, give the command:
    # 第一个参数
    touch -t ${1}00 ~/.t/time1  # time ([[CC]YY]MMDDhhmm[.SS])
    # 第2个参数
    touch -t ${2}00 ~/.t/time2
    find .  -type f                    \
            -newer ~/.t/time1          \
            \( \! -newer ~/.t/time2 \) \
            -exec exa {}             \
                    --classify       \
                    --colour=always  \
                    --no-user        \
                    --no-permissions \
                    --sort=time      \
                    --time-style=iso \
                    --long    \;     \
                    | less
    # The line-continuation will fail if you have whitespace (spaces or tab characters¹) after the backslash and before the newline.
    # Using Windows line endings \r\n (CRLF) line endings will break the command line break.
}

# <_<---------------------------------------------------------关于mtime-----------------------------------<_<

#移到垃圾箱
nn tvsc='t'




# 作为函数 不能同名, 无限递归？
# maximum nested function level reached; increase FUNCNEST?
# rg(){
#     \rg --pretty --hidden  \
#     $*
#     # $* | bat  # 导致无法自动补全
# }
#

# 作为nn 可以同名
nn rg='\rg --pretty --hidden --smart-case'



# 还是有点问题：
# copy file content
cfc(){
    if [[ $DISPLAY != '' ]];then
    # Localhost: 本地电脑，x11 server
    cat $* | xsel --input --clipboard
    else
        echo "没有开x11吧"
    fi
}


nn ca='cat'
nn ba='bat'
nn w=$PAGER

# bat read git output
bgit(){git $* | bat}

# /home/wf/dotF/zsh/color_less_很少用了.zsh 里，export LESS='--quit-if-one-screen 一大串.....'
nn le="less  --quit-if-one-screen"
# nn le="less  "

# 方便在命令中间直接敲nvim
nn vim='nvim'
nn vi='nvim'
    # rc.zsh里有:
            # export PATH="$HOME/dotF/nvim-linux64/bin:$HOME/dotF/mini_FS/bin:$PATH:/snap/bin"
    # 这个不必了: nn nvim='~/dotF/nvim-linux64/bin/nvim'
# 不用加-u 指定 因为默认就在~/.config/下
# nn vim='nvim ~/dotF/cfg/nvim/init.vim'



# todo 结合peco
#  a 强行记忆法：at the snippet
#  改了.  还是用r吧，recursively  grep. (ripgrep, 不知道啥意思。)
r(){
     echo '没搜~/.t  ~/d  /d'
     # echo '在vim中用leaderF调用rg会更好? \n'

    # --iglob:  case insensitve  的glob  # 关于大小写 好多说明，先别管
    # 之前的错误用法:
        # --glob=!"$HOME/d" \
        # --iglob=!"./.zsh_history" \

    # 可以自动补全，因为没用pipe？
     # \rg --pretty \  # 用nvim打开 ,没有彩色, 干脆不要--pretty了
     \rg                                       \
         -g '!*.zsh_history'                   \
         -g '!*.lesshst'                       \
         -g '!*.vscode-server'                 \
         -g '!.LfCache'                        \
         -g '!/d'                              \
         -g '!~/d'                             \
         -g '!/data1/weifeng_liu/.large_trash' \
         -g '!~/.t'                            \
         --hidden                              \
         --before-context 1                    \
         --after-context 1                     \
         --smart-case "$*" > ~/.t/rg_result.log
                      # regex来匹配：.表示任意一个字符
    # if [[ `cat ~/.t/rg_result.log | wc -l` > 0 ]] ; then
    if [[ $(cat ~/.t/rg_result.log | wc -l) > 0 ]] ; then
        # The backticks (`...`) is the legacy syntax required by only the very oldest of non-POSIX-compatible bourne-shells
        # and $(...) is POSIX and more preferred

        # bat代替less？ 不行  --quit-if-one-screen \
        # less无法搜中文
        # 尝试most？less的改进版
                # 失败的方法:
                # 会有乱码 nvim -c "/$*"  \
                # nvimpager 打开? 光标不好使
                # cat ~/.t/rg_result.log | $PAGER
        # less   --pattern="$*" \
            # Man!  Display the current buffer contents as a manpage.
        # nvim +10  打开文件 并到第10行,  为什么
        nvim -c "Man!" -c "/$*" \
                ~/.t/rg_result.log
                # +G 跳到最后
                # +某字母  打开时 执行vim式的操作

        echo ' '
        echo 'ps: rg搜到结果了。(less不支持中文搜索，如果看到一个空白页，就手动开less)'


        # nvim  --pattern="$*" ~/.t/rg_result.log  # 不行
        # nvim   ~/.t/rg_result.log  # 如何扔掉控制字符？
            # 内容少时，这会导致内容全在屏幕顶部
            # --smart-case "$*" |  less  --quit-if-one-screen --pattern="$*"
    else
        echo 'rg没搜到东西,不好搜就用VScode吧'
    fi

}


rd(){

     echo '# todo 只搜 ~/d  /d'
}

r4(){
    # read TMP
    # TMP2 ="`print -r ${(q)TMP}`"
    # \rg --pretty --hidden TMP2 | bat # 沿用ag的a
     \rg --pretty \
         --hidden \
         --before-context 4 \
         --after-context 4  \
         --smart-case "$*" |  less --pattern="$*"
                            # nn le="less  --quit-if-one-screen"
}

nn ac='_ack(){ ack "$*";};_ack'

#找到软链接的真实路径
nn rl='readlink -f'
#j for jump
nn j='ln -s --interactive --verbose --logical'
#logical: dereference TARGETs that are symbolic links



#==============================ls相关===================================
# todo 现在exa和ls混用, 最好统一一下
    nn ls='\ls -hrt --color=always'
        # nn ls='ls | awk "{print $4,$5,$6,$7, $3}"'
    nn la='\ls -ACF1GhFtr --color=always --classify'
    nn lc='lt -c'
    nn lla='\ls -gGhtrFA --color=always'
    nn lr='ls -gGhtF --color=always'
    nn lt='ll -tr'
    nn lx='\ls -l'
    nn l.='\ls -d1 .* --color=always --classify | ba'
    # list lean
    nn ll='\ls -1htr --color=always --classify | head -30'

    l(){
        exa                    \
        --long                 \
        --classify             \
        --colour=always        \
        --header               \
        --no-user              \
        --no-permissions       \
        --sort=time            \
        --time-style=iso  $1 | \
        tail -25
        # --group-directories-first    # 不好，

        tmp=$((  $(   \ls -l | wc -l  ) -1  ))   # 圆括号内的空格可以随便加吧
            # https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_10.html
                # (( val = 2 + 1 ))
                # is equivalent to
                # let "val = 2 + 1"
        if [ $tmp   -lt   25 ];  then
            echo "--------------"
        else
            echo "--------文件数：25/${tmp}---------"
        fi
    }

    lf(){
        exa                  \
            --long           \
            --all            \
            --classify       \
            --colour=always  \
            --header         \
            --no-user        \
            --no-permissions \
            --sort=time      \
            --time-style=iso $1 | le
            # --group-directories-first    # 不好，

        tmp=$((  $( \ls -l | wc -l ) -  1  ))  #  圆括号内的空格可以随便加吧
        echo "共：${tmp}"
    }


# [[===========================================================================被替代了,先放这儿
# nn l=leo_func_ls
#写成l()会报错。可能和built-in冲突了
# leo_func_ls(){
#     # --classify:   append indicator (one of */=>@|) to entries
#     #-g  -l时不显示用户名
#     \ls -g -htrF \
#         --no-group \
#         --color=always --classify $* \
#         | cut -c 14- \
#         | tail -25 \
#         | sed 's/月  /月/' \
#         # | sed 's/月 /月_/' \
#         # | ag ':'
#         # | ag ':' --colour=always \
#     tmp=$((`\ls -l | wc -l`-1))
#     if [   $tmp     -lt      25 ]
#     then
#         echo "--------------"
#     else
#         echo "--------文件数：25/${tmp}---------"
#     fi
# }
# [[===========================================================================被替代了,先放这儿

ls_after_cd() {
    emulate -L zsh  # add this to  the body of your script or function
                    # 这样可以 use zsh's `built-in features`,  避免setopt等搞乱默认配置
                    # to get round problems with options being changed in /etc/zshenv:
                        # put `emulate zsh' at the top of the script.
         # -L  | set local_options(activates LOCAL_OPTIONS) and local_traps as well
                    #                         trap命令:   trap 'echo "hi"' SIGINT
         # -R  | reset all options instead of only those needed for script portability
    # emulate: 模拟 csh ksh sh 或者 （没加配置的）zsh

    exa \
        --long \
        --classify \
        --colour=always \
        -F  \
        --group-directories-first  \
        --header  \
        --no-user  \
        --no-filesize   \
        --no-permissions  \
        --sort=time  \
        --time-style=iso  | \
        tail -8

    tmp=$((  `\ls -l | wc -l` - 1 - 8   ))
    #文件总数: `\ls -l | wc -l`-1

    if [ $tmp -lt 0 ]; then
        echo "------no more files--------"
    else
        echo "--------剩余文件数：$tmp---------"
    fi
}
date_leo(){
    print "    时间>_> "`date  +"%d日%H:%M:%S"`"  "
    print " "
}

# $chpwd_functions:  shell parameter (an array of function names.)
# All of these functions are executed `in order` when changing the current working directory.
# 类似PATH=$PATH:某目录，  我猜这么append函数名
# chpwd_functions=(${chpwd_functions[@]} "函数1")
#

# 没看错，中文能当变量
换行=$'\n'
上行=$'\e[1A'
上行=$'\e[1B'
autoload -U colors
colors
PS1_leo(){
# https://void-shana.moe/linux/customize-your-zsh-prompt.html
# 放文件开头时，颜色时有时无
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
# PS1="%{$fg[cyan]%}【82服务器】%~       %T_周%w号"${换行}">%{$reset_color%}"
# myPS+="${换行}"

print ${fg[cyan]}`pwd`${reset_color}
}


# /usr/share/zsh/functions/Chpwd  下有chpwd_recent_dirs等
# 默认的 chpwd_functions 只含chpwd_recent_dirs一个函数
# @表示取array里的所有东西，类似于python的list[:], 但冒号不能换成具体数字?
chpwd_functions=(${chpwd_functions[@]} "PS1_leo")
chpwd_functions=(${chpwd_functions[@]} "date_leo")
chpwd_functions=(${chpwd_functions[@]} "ls_after_cd")

# 加了这行，就算没敲cd，chpwd_functions也废掉了:
# nn cd='export chpwd_functions=() ; builtin cd'



#==============================ls相关===================================]]


# >_>_>edit want python trash=============================================begin
# w: want
# e: edit (nvim或code)
# p: python
# b: pudb
# t: trash


# nn e='nvim'
nn e='nvr'
# edit diff
nn ed='nvim -d'
# if [[ $HOST != 'redmi14-leo' ]] && [[ -z "$TMUX" ]];then  # 远程服务器且用vscode
# if [[ -z "$TMUX" ]];then
      # -z string :  true if length of string is zero.
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    nn e='code'
    nn ed='code -d'
fi

nn -s {cpp,txt,zsh,vim,py,toml,conf.cfg,s,json}=e
    # zsh默认用vim打开，导致无法执行？有其他bug？但是很多人都这么写
                                    # 后缀名s表示seting,简洁,代替conf
    # nn -s py=vim  # 要是想 让python被zsh自动补全,注释掉这行

# ed是一个没啥用的系统bin
nn vd='nvim -d'

nn ep='e'
nn eb='e'
# nn epe='e'  # 太复杂了，先不搞


t() {
    for my_file in $*
    do
        ori=`basename ${my_file}`
        trash=`basename ${my_file}`_$(date  +"%m月%d日%H:%M:%S")
        mv ${my_file} ~/.t/${trash} && echo "${ori}扔到了~/.t"
    done
}

nn tw=t
nn te=t
nn tp=t
nn tb=t

# 第一次用才需要
# nn p='python3 -W ignore -m pretty_errors'
p(){
    chpwd_functions=()
    \python3 -W ignore $*  # 打断后就不再执行下面几行
    chpwd_functions=(${chpwd_functions[@]} "ls_after_cd")
}
nn python='p'
nn python3='p'

nn pb='p'
nn pe='p'
nn pw='p'

nn b='pudb3'

nn bp='b'
nn be='b'
nn bw='b'

nn ee='p'
# ahk has set:
    # insert & v::
    # send, ^a
    # send,v
    # return

# want python pudb edit===================================================<_<_<

# ~/.antigen/bundles/sorin-ionescu/prezto/modules/utility
md(){
    for x in $*
    do
        if [ -d "${x}" ]; then
            echo "已存在:$x"
            # mkdir 不会覆盖已有目录
            # 只是想echo一下，提醒自己 尽量回忆起 之前为什么创建了目录
        else
            \mkdir --parent --verbose "$x"
        fi
    done
}

cl(){
    echo $(( `\ls -l | wc -l` - 1 ))
    }




# gpustat and grep wf
nn g='echo "gpu序号记得减1";  gpustat  --show-user --no-header  | cut --delimiter="," -f2 | bat  --number --language=py3'
nn gw='g --your-name wf '
nn gwf='g --your-name wf '

nn gi='gpustat  --show-user --no-header --show-pid'
nn giw='gi --your-name wf'
nn giwf='gi --your-name wf'

nn au='apt update'

nn nv='nvidia-smi'

# count line number
#$ echo "$((20+5))"
#25
#$ echo "$((20+5/2))"
#22

# edit tempt
nn et='e ~/d/tmp.py'
# try tempt
nn tt='python ~/d/tmp.py'
# bd : 本地
nn bd='e ~/local.zsh ; zsh'
# nn jn='jupyter notebook'


nn snp='~/dotF/snippetS'


# tmux:
#   3.0升到3.2后, 老是说server too old
#   暂时用nvim的terminal吧  懒得配tmux.conf了
    # Sometimes it is convenient to create separate tmux servers,
    # perhaps to ensure an important process is completely isolated or to test a tmux configuration.
    # S socket-path:  Specify a full alternative path to the server socket.
    # If -S is specified, the default socket directory is not  used and any -L flag is ignored
    nn tmux='\tmux -S $XDG_CACHE_HOME/tmux_socket'
                # -f ~/dotF/cfg/tmux/tmux.conf'
                # tmux 3.1开始: add  ~/.config/tmux/tmux.conf to the default search path for configuration  files.

    # tm() {
    #     # https://stackoverflow.com/a/29369681/14972148
    #     # export MY_VAR="some value"
    #     if [ "$1" != "" ]
    #     then
    #         tmux  new -s s_$1 || tmux attach -t s_$1  -d
    #     else
    #         tmux  new -s s_初代 || tmux attach -t s_初代 -d
    #     fi
    # }

    tm(){
        if [ "$1" != "" ]
        then
            abduco -A Nvim_S_1 nvim ~/dotF/cfg/nvim/init.vim
        else
            abduco -A Nvim_S_$* nvim ~/dotF/cfg/nvim/init.vim
        fi
    }


    nn con='conda'
    nn ci='conda install -y'
    # conda create --name new_name --clone old_name
    # conda remove --name old_name --all # or its alias: `conda env remove --name old_name`
    cda(){
        conda activate $1
        echo "$1" > $XDG_CACHE_HOME/conda_name
            # echo "$foo" instead of just echo $foo.
            # Without double-quotes the variable's contents get parsed in a somewhat weird way that tends to cause bugs.

    }
    nn c_ac='conda activate'
    nn c_de='conda deactivate &&  t $XDG_CACHE_HOME/conda_name'
        # 结合tmux send-keys  'conda activate `cat $XDG_CACHE_HOME/conda_name`' Enter
    nn tc='e ~/dotF/cfg/tmux/tmux.conf'

bk(){
    for my_file in $*
    do
        echo ${my_file}
        mv ${my_file} .bk_${my_file}_`date  +"%m月%d日%H时%M分"`
    done
    }

# if you used git commit -m "${1:-update}" (a parameter expansion with a default provided), then you wouldn't need the if statement at all
# gitall() {
    # git add .
    # if [ "$1" != "" ] # or better, if [ -n "$1" ]
    # then
        # git commit -m "$1"
    # else
        # git commit -m update
    # fi
    # git push
# }



#find . -maxdepth 1 -printf '%Cm月%Cd日   %CH:%CM:%CS    %s         %f \n'
#要传参，比如用$,要用函数，不能直接用别名
# http://blog.tangzhixiong.com/post-0035-pkg-config.html

# if $1 expands to demo , then ${1%.wf_run} 把传进来的文件名的后缀wf_run扔掉
# if $1 expands to demo , then ${1%.*} expands to demo  ??
nn oc='_oc(){ g++ -g $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# oc demo.cpp draw.h draw.cpp
# ./demo

# 用autohotkey敲\ec吧
# ech(){
#   涉及到变量替换, 搞了很久没成功
    # printf $$1  # 输出3290431
    # printf ${$1}
    # echo $1>$HOME/.t/ec_leo_short_for_echo.txt

    # cat $HOME/.t/ec_leo_short_for_echo.txt | echo ${}
    # echo  ${"echo $1"}

    # if (( ${+$(VAR)} ))   #  看 VAR是否未设置
    # then
        # echo $(VAR)
    # else
        # echo "$1 未设置"
    # fi
# }

nn sc='scp'
nn scp='scp -r'
# nn scp='sshpass -p "你的密码" scp -r '
# tr本来是linux的builtin
# 最近15个文件
# printf 命令 指定格式


#都说别改动或者覆盖linux的builtin!
# 最规范的语法 nn custom-alias='command'  command 里面没空格就不用引号
# {后一定要有空格
# []  和{}内侧左右都留一个空格 不然可能报错
# [ your_code ]才对  [your_code]少了空格
# 需要vim的语法检查时，改后缀名.sh再打开
# 双引号换成单引号就不行
# nn vj='_j(){ jq -C '' $1 ; }; _j'
# 最外层用双引号也不行
# nn vj="_j(){ jq -C "" $1 |bat -R;};_j"

# 还可以用:
# x


nn sa='chmod -R 777'  #share to all
nn t_a='t *'
nn sc='noglob scp -r'
nn scp='noglob scp -r'
# tac:
# Print and concatenate files in reverse (last line first)


# 冒号变换行
# print /l "${PATH//:/\n }"


nn pt='ptpython --vi'
#nn pt='ptpython --vi --config-dir=~/dotF/cfg/ptpython'
nn pti='ptipython --vi'
nn matlab='matlab -nosplash -nodesktop'
# nn ml='matlab -nosplash -nodesktop'
# 避免sudo后的nn失效？
# nn sudo=''

nn s='e ~/dotF/zsh/rc.zsh ; zsh'

# az: 安装an zhuang
nn az='e ~/dotF/auto_install/auto_install.sh'
# al: alias
nn al='e ~/dotF/zsh/alias.zsh; zsh'

# i for init.vim
nn in='e ~/dotF/cfg/nvim/init.vim'  # init.vim


nn x='PAGER=bat git'
nn lg='lazygit'


# get github
gg(){
    chpwd_functions=()  # 别显示 所去目录下的文件
    cd ~/dotF
    # echo "\n-----------1. stash，藏起本地修改（但忽略新增文件）------------"
    git stash --include-untracked --message="【stash的message_`date  +"%m月%d日%H:%M"`】"
    # echo "\n-----------------2. pull, 拉远程的新代码-----------------"
    git pull  # Update the branch to the latest code   = fetch + merge? 还是只fetch?
    # echo "\n如果giithub上领先于本地，那么 此时本地的修改还被藏着，现在打开本地文件和github上一样"
    # echo "\n---------------------3. stashed的东西并到 本地的当前代码 ---------------------"
    git stash pop  # Merge your local changes into the latest code, 并且在没有conflict时，删掉stash里的这个东西
    # 貌似比git stash apply好
    # echo '会报：Dropped refs/stash@{0}'
    # echo "\n 【亲，检查一下有没有冲突】 "
    zsh
}


# 我最新的配置 真是yyds


yy(){
    # echo "\n--------------------------------4. add commit push三连-----------------------------------------------"
    cd ~/dotF
    git stash clear  # 避免pull后有冲突，合并完后，再敲gg，死循环地有冲突
    echo "\n--------------------------------add commit push三连-----------------------------------------------"
    git add --verbose  --all .
    if [[ "$1" != "" ]]  # if [[ "$1" == "" ]] 容易出bug？一般都不这么写
        # string = pattern
        # string == pattern
        #        true if string matches pattern.  The two forms are exactly equivalent.  The `=' form is the traditional shell
        #        syntax (and hence the only one generally used with the test and [ builtins); the `==' form provides  compati‐
        #        bility with other sorts of computer language.
        #
        # string != pattern
        #        true if string does not match pattern.
    then
        # 不加--all时，如过github有些文件，而本地删掉了，则github上不想要的文件 还在
        git commit --all --message "$1"
    else
        git commit --all --message "我是commit名__`date  +"%m月%d日%H:%M"`"
    fi
    git push --quiet  #  只在出错时有输出
    # git push 2>&1 >~/.t/git_push的stdout  # 不行
    cd -
    zsh
}



# todo  # alt left 搞成和windows一样的体验
# }

# Shell functions are defined with the function reserved word or the special syntax ‘funcname ()’.
# function d () {

d() {
    dirs -lv | head -10  > ~/.t/.leo_path_stack_dirs.log
    # -v 带上序号
    # -l  代表long？ full path
    bat ~/.t/.leo_path_stack_dirs.log
}
compdef _dirs d  # compdef: 一个函数，定义自动补全。让函数d能被自动补全

# /usr/share/zsh/functions/Completion/Zsh/_dirs  里面有：
# #compdef dirs


#   `#compdef <names ...>'
#     If the first line looks like this, the file is autoloaded as a
#     function,
#     and that function will be called to generate the matches
#     when completing for one of the commands whose <names> are given.


# _dirs is an autoload shell function
#
#  dirs输出：
# _dirs () {
#         # undefined
#         builtin autoload -XUz
# }
#
# /usr/share/zsh/functions/Completion/Zsh/_dirs 的完整内容:
#compdef dirs
# _arguments -s \
#   '(-)-c[clear the directory stack]' \
#   '(* -c)-l[display directory names in full]' \
#   '(* -c)-v[display numbered list of directory stack]' \
#   '(* -c)-p[display directory entries one per line]' \
#   '(-)*:directory:_directories'

# global nn，有点危险， 别用
# nn -g ...='../..'
#
# 什么特殊语法？
nn _='待用'
nn -- -='cd -'  # 和下面这行一样？
nn -- -='cd -1'

nn ..='cd ..'
nn ...='cd ../..'
nn ....='cd ../../..'

nn 2='cd -2'
nn 3='cd -3'
nn 4='cd -4'
nn 5='cd -5'
nn 6='cd -6'

# 光标
nn gb='echo -e "\033[?25h"'
#加了这行导致./build_ops.sh等执行不了
#nn nn -s sh=vi
#大小写不敏感  If you want to ignore .gitignore and .hgignore, but still take .ignore into account, use -U
nn c=cp
nn cp='cp -ivr'
nn c.='cp -ivr -t `pwd`'
nn df='df -h | bat'
# bie dai li，别代理
nn bdl='unset ALL_PROXY; pqi use tuna; conda conf'

nn dkr='docker'
nn dkrps='docker ps -a --format "table {{.Names}} 我是分隔符 {{.Image}}  "'
# zsh启动不了时, 并不会启动bash, 搁置

dk(){
docker start $1 ; docker exec -it $1 zsh
# docker exec -it $1 zsh 在退出时不返回1  ?
#  这样会一直卡着: echo `docker exec -it $1 zsh`
}


nn peco='peco --rcfile $HOME/.config/peco/config.json'




# 我自己的回答
# https://unix.stackexchange.com/a/680293/457327

pid(){
    # echo "pid |  开始于  在跑吗  %CPU  %MEM   |  CPU占用 [DD-]hh:mm:ss |  程序  |   完整路径"
    echo '状态：
    R    running or runnable (on run queue)
    S    interruptible sleep (waiting for an event to complete)
    s    a session leader
    l    multi-threaded
    +    foreground process
    '

    # TIME: amount of CPU in minutes and seconds that the process has been running

    # 加了循环报错，错了done啥的
    # for pidN in $*
    # do
        echo '------'
        # ps --headers --pid=$pidN --format=pid,start_time,stat,comm,command
        # ps --headers  --pid=$pidN --format=pid,start_time,cputime,stat,comm,command
        ps --headers  --pid=$* --format=pid,start_time,cputime,stat,comm,command


        # TIME::accumulated cpu time, user + system 比真实世界的运行时间长？
        # bsdtime      The display format is usually "MMM:SS",
                    # but can be `shifted to the right` if the process used more
                    # than 999 minutes of cpu time??
        # time      "[天数-]时:分:秒" format.  (nn cputime).


        # START::time the command started.-- 下面两种情况，只有细微差异
        # bsdstart   If the process was started less than 24 hours ago,
                    # the output format is  " HH:MM",
                    # else it is " Mmm:SS" (where Mmm is the  three letters of the month).

        # start_time  没超过一年前:
                    # "月 日" if it was not started the same day,
                    # or "HH:MM" otherwise.

        # 笔记：
        # --User "${1:-$LOGNAME}" : 当前用户的所有process
        # 各选项在select process时，取并集， 而非交集
        # ps -a -ux | grep --invert-match grep | grep $pidN
        # --headers repeat header lines, one per page of output.

    # done
    # 加了循环报错，错了done啥的

}

f(){
    if [[ `pwd` == "$HOME/d" || `pwd` == "/d" ]]
    then
        # find 的路径，用$HOME, 别用~,  用双引号括起来
        echo '被-prune 且在当前目录下的路径：'
        find . \
            -path "/d/docker" -prune -o  \
            -path "$HOME/d/docker" -prune -o  \
            -path "$HOME/d/.t" -prune -o       \
            -path "$HOME/t" -prune -o       \
            -path "./.t" -prune -o       \
            -name "*$1*" | le
        echo "当前路径为： ~/d"
        echo "(没进去搜的目录, 仍会输出一行 )"
    elif  [[ `pwd` == "$HOME/.t" || `pwd` == "/d/.t" ]] ; then
        find . -name "*$1*" | le
        echo "当前路径为： .t (垃圾箱)"

    else
        # 还是别这样，万一其他路径ln -s到~/d呢
        # if [[ `pwd` == "$HOME" ]]
        # then
        #     echo "不搜 ~/d 或  /d"
        # fi

        # find 的路径，用$HOME, 别用~,  用双引号括起来
        # echo '当前目录存在的 被-prune的路径：'
        find . \
            -path "$HOME/d/docker" -prune -o \
            -path "/d/docker" -prune -o      \
            -path "$HOME/d" -prune -o        \
            -path "/d" -prune -o             \
            -path "/proc" -prune -o          \
            -path "/dev" -prune -o           \
            -path "./ttt" -prune -o          \
            -name "*$1*"
        echo "============不搜 ~/d 或  /d =====\n"
        #这几种写法 都不起作用 (因为指定了find . 只在当前目录下匹配？）
                # -path "$HOME/d/测试目录" -prune -o       \
                # -path "~/测试目录" -prune -o       \
                # -path "/home/wf/测试目录" -prune -o       \
                # -path "/home/wf/测试目录" -prune -o       \

        #在$HOME下这样才行 -path "./测试目录" -prune -o
    fi
    # echo 'find命令太复杂了... todo:  https://docstore.mik.ua/orelly/unix3/upt/ch09_09.htm'

}


th(){ touch $1.n }

# noglob
# Filename generation (globbing) is not performed on any of the words.
# 又叫 filename generation 或者 globbing，对特殊字符 *、?、[ 和 ]进行处理，试着用对应目录下存在文件的文件名来进行补全或匹配，如果匹配失败，不会进行扩展。
## 例子
#$ ls
#test1 test2 test3
#$ echo *
#test1 test2 test3
#$ echo test?
#test1 test2 test3
#$ echo test[1-3]
#test1 test2 test3
#$ echo l*
#l*

gc(){
    if [[ -z ${ALL_PROXY} ]]; then  # -z: 看是否empty
        echo '没开代理'
    else
        echo '代理：'
        echo ${ALL_PROXY}
    fi
    echo $1 $2 $3
    git clone $1 $2
}
nn gcc='nocorrect gcc'
nn get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
# nn git='pro &&  git'
nn globurl='noglob urlglobber '
hl(){
    du --summarize --human-readable $* | sort --human-numeric-sort --reverse| bat
 }

nn http-serve='python3 -m http.server'

# check ip
cip(){
    curl --show-error --silent cip.cc 2> ~/.t/curl_cip.cc.out
                                      # redirects/重定向
                                     # "2"必须紧贴着它:  ">",  不能有空格
    OUT=`cat ~/.t/curl_cip.cc.out`
    # string contain substring? shell处理字符串切片
        # string='My string';
        # if [[ $string =~ "My" ]]; then
        #     echo "It's there!"
        # fi
    if [[ $OUT == *"Recv failure"* ]];then
        echo "curl cip.cc 的结果 >_> $OUT"
        unset ALL_PROXY &&  echo "\n代理挂了，切回无代理"
        INDEX=0
    else

    fi
    source ~/dotF/auto_install/apt_source.sh
}

# kill -15
nn k='kill -s TERM'


nn locate='noglob locate'


nn m='\mv -iv'
nn mv='\mv -iv'
nn mm='\mv -iv -t `pwd`'
nn m.='\mv -iv -t `pwd`'


# Makes a directory and changes to it.
mcd() {
    #这么写，要放到开头才行，不然说  "done 附近有错”
    #for x in $*
    #do
        #if [ -d "${x}" ]; then
            #echo "已存在:$x"
        #else
            #\mkdir -p "$x"
        #fi
    #done

    #[[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
    #mkdir 会变成上面我自己写的md，有暂时无法解释的bug
    [[ -n "$1" ]] && \mkdir --parent --verbose "$1" && builtin cd "$1"
    #-n:
#   string is not null.
}


nn pi='pip3 install'
nn pip='pip3'


nn rm='nocorrect rm -Irv --preserve-root'

nn n='zsh'  # n:  new zsh


nn to='htop --user=`whoami` --delay=30 --tree'  # system monitor
nn top=htop
nn toc='htop -s %cpu'
nn tom='htop -s %mem'

nn z='_z 2>&1'


# nn oc='_oc(){ g++ $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# -f指定归档文件
#  -z (同 --gzip, --gunzip, --ungzip)  通过 gzip 过滤归档
# nn -s gz='wf_gz(){ tar -xzf $* ; t $* ; };wf_gz'

nn disimg="imcat"
nn imcat="imcat"
nn -s png=imcat
nn -s jpg=imcat
nn -s jpeg=imcat
nn -s svg=imcat
nn -s bmp=imcat
nn -s gif=imcat

# -x 等同 --extrac
nn -s tar='tar -xf'

nn -s gz='tar -xzf'
nn -s bz2='tar -xjf'  # -j   针对bz2

nn -s tar.bz2='tar --extract --bzip2 --verbose -f' #-f指定文件
nn -s tbz='tar --extract --bzip2 --verbose -f' # 同上

nn -s tar.gz='tar -xzf'
nn -s tgz='tar -xzf'  # 同上

nn -s tar.xz='tar -xJf'
nn -s txz='tar -xJf'  # 同上

##加了这行导致./build_ops.sh等执行不了
#nn -s sh=vi
# 会导致执行不了?
# nn -s make='vim'

# 只看不改的文件:
    nn -s md=bat
    nn -s log=bat
    nn -s txt=bat
    nn -s html=bat
    nn -s csv=vim

nn -s yaml=vim
nn -s yml=vim

cj(){
    # cj: 意思是 see json
    jq -C "" $1 |le -R  # jq: json query？
}
nn -s json=cj

nn ai='sudo apt install'
nn apt='sudo apt'
nn apt-get='apt'


# unix software resoure python
# nn up='/usr/bin/python'

# 函数开头, 比如下面的echo, 前少了空格，在用这个nn时，报错zsh: parse error near `}

# http://faculty.salina.k-state.edu/tim/unix_sg/shell/variables.html
# 1. 方法名后面可以有多个空格
# 2. 括号内可以有多个空格
# 3. 括号可以不要，但是为了美观，建议加上括号
# 4. 如果方法体写成一行，需要在语句后面加分号“;”
# 5. $*表示除$0外的所有参数

#变量名=$(命令名)
#result=$(password_formula)
#
# print -Pn "\e]2;%~\a" #在terminal的tittle显示路径
#
# 获得当前路径的basename
# $PWD:t
# 或者
# basename $PWD  # 更通用

# sh -c "$(curl -fsLS git.io/某某)" 意思：
    # -f :Fail silently (no output at all) on HTTP error
    # -s :Silent mode
    # -S : Show error even when -s is used
    # -L : follow redirects

nn wg='axel'
# nn wg='python3 ~/dotF/mini_FS/bin/axel_with_quote.py'  # 要是命令行里有符号&,
# 必须手动多敲单引号包裹
nn wget='echo "using axel. 要是遇到别人写wget -O-，知道它是重定向到stdout就好。 axel的参数和wget不同" ; axel'
nn wgname='wget -c -O "wf_need_to_change_name"'

    # sh -c "$(wget -q -O- git.io/chezmoi)"
    # -O: 指定输出文件名


nn help=run-help
nn hp=run-help

nn _tldr='/usr/local/lib/node_modules/tldr/bin/tldr --theme base16'
            # 网络不好时, 自己下载tldr.zip, 解压到~/.tldr/cache/ 可以删掉pages.某某语言,
            # 只剩pages目录
# nn _tldr='/home/linuxbrew/.linuxbrew/bin/tldr'
            # 同样是下载tldr.zip   ~/.tldrc/tldr/ 一堆各种语言的pages

        # nn tldr='tldr --platform=linux'  # 别这样? linux目录和common, mac等平级

        # 在各种client中,它最好看, 但要是找不到, 会一直找
        # brew install tldr, 得到的格式用vim打开很乱

nn cm='whence -ca'
    # 这可以退休了?  直接用h()
    # cm for command
    # 代替where which type
    # -v for verbose, 不过好像没用

nn goo='dl ; googler'
nn bi='brew  install'


# 需要sudo
# >_>_>===================================================================begin
# 换源
    set -x
    mkdir -p /etc/apt/

    mv /etc/apt/sources.list /etc/apt/sources.list.origin_useless
    string=`cat /etc/issue`
    if [[ $string =~ "Ubuntu 18" ]]  # regex
    then
        cp -rf auto_install/sources_china_ubuntu18.py /etc/apt/sources.list
    fi

    if [[ $string =~ "Ubuntu 20" ]]  # regex
    then
        cp -rf auto_install/sources_china_ubuntu20.py /etc/apt/sources.list
    fi

cat ./auto_install/git_url.txt>>/etc/hosts
apt install -y -qq network-manager
service network-manager restart
    # 不用这行: /etc/rc.d/init.d/network restart
        # Ubuntu uses network-manager instead of the traditional Linux networking model.
        # so you should restart the network-manager service instead of the network service

# apt install
# todo: 换做homebrew? 免sudo安装
    # yes | (apt update && apt upgrade ; apt install  nscd )
        # upgrade可能把别人容器的依赖关系破坏了
    yes | (apt update ; apt install  nscd )
    /etc/init.d/nscd restart

    yes | unminimize
    yes | (apt install software-properties-common)  # software-properties-common提供了这个bin：  add-apt-repository
    yes | (add-apt-repository ppa:ultradvorka/ppa )
    yes | (add-apt-repository ppa:deadsnakes/ppa && apt -qq update )
    yes | (apt install sudo)  # 仅限于容器内用root。容器外，没sudo别乱搞

alias ai='sudo apt install -y -qq'
    ai libatlas-base-dev  gfortran libopenblas-dev liblapack-dev
    ai python3.9
    ai python3.9-distutils

    yes | (ai man bat)
    ln -s /usr/bin/batcat /usr/local/bin/bat

    yes | (ai aptitude ;aptitude update -q ; ai zsh; ai progress; ai libevent-dev)
    yes | (ai htop ;ai ack ;ai axel; ai intltool; ai tmux ; ai fontconfig; ai xdg-utils)
    yes | (ai exiftool htop tree tzdata locales)
    yes | (ai ctags; ai build-essential; ai cmake; ai python-dev)
    yes | (ai curl  ffmpeg libsm6 libxext6)
    yes | (ai python3-setuptools ;  ai xsel)
    yes | (ai rename wget  tldr)
    ai python3-neovim
    yes | (ai silversearcher-ag)
    # aptitude install -y postfix  # 有交互, 应该需要手动
    postconf smtputf8_enable=no
    postfix start
    postfix reload
    # yes | (mutt msmtp)
    # touch ~/.msmtp.log


    # under ubuntu16 try this:
    if [[ $string =~ "Ubuntu 16" ]]  # regex
    then
        yes | (ai language-pack-zh-hans language-pack-zh-hans-base)
    fi


    # touch /var/lib/locales/supported.d/local
    #
    # echo 'en_US.UTF-8 UTF-8
    # zh_CN.UTF-8 UTF-8
    # zh_CN.GBK GBK
    # zh_CN GB2312'>>/var/lib/locales/supported.d/local

    # 中文]]
    ai locale-gen
    ai fonts-droid-fallback
    ai ttf-wqy-zenhei
    ai ttf-wqy-microhei
    ai fonts-arphic-ukai
    ai fonts-arphic-uming

    locale-gen zh_CN.UTF-8
    rm -f /etc/localtime &&  ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  #改 Linux 系统的时区

    # ponysay cowsay
        # sudo add-apt-repository --yes ppa:vincent-c/ponysay
        # sudo apt-get update
        # sudo apt-get install fortune cowsay
        # sudo apt-get install ponysay
        # sudo snap install ponysay

    # 修改默认python
        rm /usr/bin/python
        ln -s /usr/bin/python3.? /usr/bin/python
    # 别改系统默认python3的版本啊，不然apt都会出问题
        ## sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
        ## sudo update-alternatives --config python3


yes | (ai python3-pip)
\apt autoremove -y -q

# 不需要sudo
# >_>_>===================================================================begin
# export ALL_PROXY=socks5://你的ip:端口
    echo  'ALL_PROXY is:  ------------------begin'
    echo  $ALL_PROXY
    echo  'ALL_PROXY is:  -------------------end'

    [[ -d /d ]] && ln -s /d ~/d

mv ~/.pip  ~/.pip_wf_bk
ln -s ~/dotF/.pip/ ~/

\mkdir -p $HOME/.local/bin
touch "$HOME/.z" # 这是zsh的z跳转的记录文件

# 用bash跑!!
shopt -s  expand_aliases
    # alias apt='apt -y -qq'
    alias apt='apt -y -q'
    alias pip='\pip3 -qq'
    alias pip3='\pip3 -qq'
    alias cp='cp -r'


# 使用中文的ubuntu会有什么坏处吗？ - 君子笑的回答 - 知乎https://www.zhihu.com/question/340272351/answer/799642709
# 在.zshrc里, 已经export LANGUAGE  不用：
    # echo 'LANG="zh_CN.UTF-8"


curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


yes | (cp -rf .muttrc $HOME ;cp -rf .msmtprc $HOME ; touch $.msmtp.log)
chsh -s `which zsh`


export ZPLUG_HOME=$HOME/.zplug
rm -r $HOME/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh



yes | (unset ALL_PROXY ; pip install --upgrade pip  ; pip install pysocks)
pip install -r pip_tools.txt

pip uninstall pynvim  # 不删会报错

echo '如果有网络问题，这2行要在 设置PROXY后，手动敲: \n
pip install -r pip_tools.txt  \n
pip uninstall pynvim  \n'


# 自动补全, 二选一
    # coc
        mkdir -p ~/.local/share/nvim/site/pack/coc/start
        cd ~/.local/share/nvim/site/pack/coc/start
        git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1

    # git clone https://github.com/kiteco/vim-plugin.git ~/.config/nvim/pack/kite/start/kite/
        # 别用了: 请问有没有人知道kite这个是什么软件？ - 胆大路野的回答 - 知乎  https://www.zhihu.com/question/325925351/answer/2199205110


export  XDG_CACHE_HOME="$HOME/d/.cache"
mkdir -p $XDG_CACHE_HOME
mkdir ~/.ssh
rm -f ~/.condarc
# todo: 考虑gnu stow 管理link?
ln -s  ~/dotF/conda.yml ~/.condarc
ln -sf ~/dotF/zsh/zshenv.zsh    ~/.zshenv
ln -sf ~/dotF/cfg/ssh_cfg.yml ~/.ssh/config
rm -rf ~/.SpaceVim.d    ~/.Spacevim

mkdir -p ~/coc
避免dotF目录被coc插件弄脏
ln -sf ~/coc ~/dotF/cfg/
yes |(mv ~/.tmux ~/.tmux_bk)
yes |(mv ~/.config ~/.old_config ;  ln -sf ~/dotF/cfg ~/.config)
yes |(cp ~/dotF/zsh/local_template.zsh ~/local.zsh )

# tmux插件
    TP="$HOME/.tmux_wf/plugins/tpm"
    if  [[ ! -d $TP ]] ; then
        echo '在装tpm'
        mkdir -p $TP
        git clone https://github.com/tmux-plugins/tpm $TP
        $TP/bin/install_plugins
    else
        echo '之前装了tpm'
    fi

# 解决这里的问题: https://github.com/microsoft/python-type-stubs/pull/72
    # conda activate MY_env_
    # CV2_PATH=`python -c 'import cv2, os; print(os.path.dirname(cv2.__file__))'`
    # URL='https://raw.githubusercontent.com/bschnurr/python-type-stubs/add-opencv/cv2/__init__.pyi'
    # curl -sSL $URL -o ${CV2_PATH}/cv2.pyi

# 进入zsh玩耍了
zsh


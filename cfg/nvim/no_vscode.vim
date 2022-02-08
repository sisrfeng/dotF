" abbrev 和map的区别，就像ahk里 hotkey和hotstring
" 触发： space, Escape, or Enter.
    inoreabbrev nno nnoremap
    inoreabbrev cno cnoremap
    inoreabbrev vno vnoremap
    inoreabbrev ali alias
    inoreabbrev mpa map
    inoreabbrev ali alias
    inoreabbrev al alias
    inoreabbrev df ~/dotF/
    inoreabbrev HO $HOME/
    inoreabbrev ture true


" cnoremap s/ s/\v
" vscode里，用了camp时，必须在光标后有字符才能正常map


" cnoreabbrev
  cnoreabbrev <expr> pl    getcmdtype() == ":" && getcmdline() == 'pl'           ? 'tab drop ~/dotF/cfg/nvim/plug_wf.vim'       :   'pl'
  cnoreabbrev <expr> bt    getcmdtype() == ":" && getcmdline() == 'bt'           ? 'tab drop ~/dotF/cfg/nvim/beautify_wf.vim'    :   'bt'
  cnoreabbrev <expr> e     getcmdtype() == ":" && getcmdline() == 'e'            ? 'tab drop'                           : 'e'
  cnoreabbrev <expr> cc    getcmdtype() == ":" && getcmdline() == 'cc'           ? 'CocConfig'                         : 'cc'
  cnoreabbrev <expr> zbk   getcmdtype() == ":" && getcmdline() == 'zbk'          ? 'tab drop ~/dotF/zsh/bindkey_wf.zsh'     : 'zbk'
  cnoreabbrev <expr> bd    getcmdtype() == ":" && getcmdline() == 'bd'           ? 'tab drop ~/local.zsh'                  : 'bd'
  cnoreabbrev <expr> e     getcmdtype() == ":" && getcmdline() == 'e'            ? 'tab drop'                           : 'e'
  cnoreabbrev <expr> et    getcmdtype() == ":" && getcmdline() == 'et'           ? 'tab drop ~/.t/tmp.vim'                : 'et'
  cnoreabbrev <expr> tc    getcmdtype() == ":" && getcmdline() == 'tc'           ? 'tab drop ~/dotF/cfg/tmux/tmux.conf' : 'tc'
  cnoreabbrev <expr> in    getcmdtype() == ":" && getcmdline() == 'in'           ? 'tab drop ~/dotF/cfg/nvim/init.vim'  : 'in'
  cnoreabbrev <expr> s     getcmdtype() == ":" && getcmdline() == 's'            ? 'tab drop ~/dotF/zsh/rc.zsh'             : 's'
  cnoreabbrev <expr> al    getcmdtype() == ":" && getcmdline() == 'al'           ? 'tab drop ~/dotF/zsh/alias.zsh'          : 'al'

  cnoreabbrev <expr> pi    getcmdtype() == ":" && getcmdline() == 'pi'           ? 'PlugInstall'                       : 'pi'
  "   vscode里也能用, 但会把原文件的内容 粘贴到一个新文件
  cnoreabbrev <expr> cm    getcmdtype() == ":" && getcmdline() == 'cm'           ? 'tab help'                          : 'cm'
  cnoreabbrev <expr> h     getcmdtype() == ":" && getcmdline() == 'h'            ? 'tab help'                          : 'h'
  cnoreabbrev <expr> ctr   getcmdtype() == ":" && getcmdline() == 'tab help ctr' ? 'CTRL'                              : 'ctr'


" noremap
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>


    " todo:参考  https://github.com/mhinz/vim-sayonara
    " nnoremap ss      :update<CR>:Sayonara<CR>
    nnoremap ss      :update<CR>:bdel<CR>
    vnoremap ss :<C-U>update<CR>:bdel<CR>
        " :q只退出tab或者window, 但还留在buffer里
    nnoremap qq       :q!<CR>
    vnoremap qq :<C-U>:q!<CR>

    " nnoremap q :wq<CR>  按一次q要等一会才退出， 不如连续按2次快
    " inoremap qq <ESC>:wq<CR>  别这么干，容易在编辑时敲错

    noremap j gj
    noremap k gk

    " map vs map! : map控制“字母不是用于输入”的几个mode，map！控制“字母 是用于输入的字符串的”mode
    noremap H g^
    " nnoremap H g0
    noremap 0 g0
    noremap <Home> g0
    noremap L g$
    noremap <End> g$

    onoremap <silent> j gj
    onoremap <silent> k gk
    " nnoremap dd g^dg$i<BS><Esc>
    " nnoremap yy g^yg$
    " nnoremap cc g^cg$
    nnoremap A g$a
    nnoremap I g^i

    " nnoremap gm g$
    " nnoremap M

    nnoremap <c-\> <c-w>v
        " <C-\><C-N> can be used to go to  Normal mode
        " from any other mode.  (包括terminal-mode)
        " This can be used to make sure Vim is in
        " Normal mode, without causing a beep like <Esc> would.  However, this does not
        " work in Ex mode.  When used after a command that takes an argument, such as
    nnoremap <c-w>-  <c-w>s
    " nnoremap gd g<C-]>
        " <C-]>只能在本文件内跳转


if &diff
    " 反应变慢，不好
    " map ] ]c
    " map [ [c
    endif
    " map 默认是recursive的



set  nonumber norelativenumber
    " 不好:
    " set  number relativenumber
    " set  number norelativenumber
func HideNumber()
    if(&relativenumber == &number)
        " 叹号或者加inv：表示toggle
        set invrelativenumber invnumber
    elseif(&number)
        set invnumber
    else
        set relativenumber!
    endif
endfunc
nnoremap <Leader>n :call HideNumber()<CR>

set wrap    " vscode里, 要在setting.json设置warp


" tab
    " vscode上有插件自动处理，不用加这些:
    "
    set expandtab " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
    set tabstop=4 " 设置Tab键等同的空格数
    set shiftwidth=4 " 每一次缩进对应的空格数
    set smarttab " insert tabs on the start of a line according to shiftwidth
    set shiftround " 用shiftwidth的整数倍， when indenting with '<' and '>'
    set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
    " 如果要仅对python有效：  autocmd Filetype python set 上面那堆

    " `各种indent方法`
        " 只是对c语言家族而言？
        " 'autoindent'  uses the indent from the previous line.
        " 'smartindent' is like 'autoindent' but also recognizes some C syntax to
        "                 increase/reduce the indent where appropriate.
        " 'cindent' Works more cleverly than the other two and is configurable to
        "             different indenting styles.
        " 'indentexpr'  The most flexible of all: Evaluates an expression to compute
        "       the indent of a line.  When non-empty this method overrides
        "       the other ones.  See |indent-expression|.
    set cindent
        " 考虑用谷歌的规范？
        " https://github.com/google/styleguide/blob/gh-pages/google_python_style.vim
        " set indentexpr=GetGooglePythonIndent(v:lnum)


" vscode里不行
    " nnoremap zz :wq<C-R>
    " inoremap zz <ESC>:wq<CR>
    " cnoremap q1 q!
    " Quickly close the current window
    " nnoremap <leader>q :q<CR>
    " Quickly save the current file
    " nnoremap <leader>w :w<CR>

" 使用方向键切换buffer 。 vscode的map，别用command mode ?


" 已经设置了 let g:NERDCreateDefaultMappings = 0  " 之前设为1，导致vscode用不了nerdcommenter?
nnoremap ce A<space><space><Esc>o/<Esc><Esc>:call nerdcommenter#Comment("n", "Comment")<CR>kJA<BS>
    " 有缩进时，有时会把开头的注释符号删掉，别完美主义吧

" 代替autochdir>_>_>===================================================================begin
    " Switch to the directory of the current file unless it breaks something.
    function! s:autopath_()
        let can_autochdir = (!exists("v:vim_did_enter") || v:vim_did_enter) " Don't mess with vim on startup.
        " let can_autochdir = can_autochdir && david#init#find_ft_match(['help', 'dirvish', 'qf']) < 0 " Not useful for some filetypes
        let can_autochdir = can_autochdir && filereadable(expand("%")) " Only change to real files.
                                            " filereadable()
                                                    " The result is a Number, which is |TRUE| when a file with the
                                                    " name {file} exists, and can be read.  If {file} doesn't exist,
                                                    " or is a directory, the result is |FALSE|.

        if can_autochdir
            silent! cd %:p:h
        endif
    endf

    augroup wfGroup
        autocmd!

        " Could use BufEnter to be more like autochdir, but then we have constant changing pwd.
        " Use <S-space> to reload the buffer if you want to cd.
        autocmd BufReadPost * call s:autopath_()
    augroup END


    " autocmd VimEnter * set autochdir | pwd | echom '设置了autochdir'
    " 要敲一次pwd触发?
        " Note: When this option is on some plugins may not work.
        " todo: debug / buggy

        " 要是放到vscode里会报错:
        " vscode里, 可以手动敲 :lcd


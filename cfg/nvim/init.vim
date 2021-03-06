let mapleader = " "
hi ErrorMsg  guibg=#ede6d3  " 放init.vim最开头, 这样才能在出错前生效



" 文件路径
    if exists('g:vscode')
        " 用vscode时，本文件里也有依赖于$MYVIMRC的变量。别扔掉$MYVIMRC
        let $MYVIMRC =  "~/dotF/cfg/nvim/init.vim"
        " 放进if？ gf无法跳到has_vscode.vim
        " let $has_vscode = fnamemodify($MYVIMRC,':h') . "/has_vscode.vim"
    endif
    let $has_vscode = fnamemodify($MYVIMRC,':h') . "/has_vscode.vim"
    " :h只要路径
    let $no_vscode = fnamemodify($MYVIMRC,':h') . "/no_vscode.vim"

    " notes.vim
    " todo.vim


" 让配置变更立即生效
    " 1.  `:augroup {name}`
    " 	Define the autocmd group name for the  following ":autocmd"
    augroup Reload

    " 2. Delete any old autocommands  `:help autocmd-remove`
    autocmd!

    " 或者： 先在group内删除匹配{event}和{pat}的autocmd，再定义新的cmd
    ":autocmd! [group]   {event}     {pat}      {cmd}
    " autocmd! Reload BufWritePost $MYVIMRC  echom '改了init.vim'

    " When resourcing vimrc always use autocmd-nested  因为autocmd执行时 会又遇到autocmd
    " ++nested 在老版本中是nested
    " todo: ~/dotF/cfg/nvim/*.vim会match~/dotF/cfg/nvim/notes/*.vim.
    " 现在只好把notes下的文件改成其他后缀名
    " autocmd BufWritePost ~/dotF/cfg/nvim/*.vim    source %   | echom "更新了"."init.vim系列"."要是改了has_code.vim, 会有点问题,建议重启"| redraw!
    " autocmd BufWritePost ~/dotF/cfg/nvim/*.vim    source %   | echom "更新了"."配置"."要是改了has_code.vim, 会有点问题,建议重启"| redraw!
    autocmd BufWritePost ~/dotF/cfg/nvim/*.vim           source ~/dotF/cfg/nvim/init.vim   | echom '重新加载nvim'  | redraw!
    autocmd BufWritePost ~/dotF/cfg/nvim/lua/wf_lua.lua  source ~/dotF/cfg/nvim/init.vim   | echom '重新加载nvim'  | redraw!
                                                             " 还是得重启nvim才能更新

                                                             "
    nnoremap <M-C-F10>r :source ~/dotF/cfg/nvim/init.vim<CR>:echo "手动reload完了"<cr>
    " tnoremap <M-C-F10>r :source ~/dotF/cfg/nvim/init.vim<CR>:echo "reload完了"<cr>


    " 4. Go back to the default group, named "end"
    augroup end

" 插件:
        call plug#begin(stdpath('data') . '/plugged')
            source ~/dotF/cfg/nvim/plug_wf.vim  " 方便搜索:plugin_wf / 用了vim-plug
            " 插件 (plugin) 在~/.local/share/nvim/plugged

            if !exists('g:vscode')
                Plug 'plasticboy/vim-markdown'
                " Plug 'preservim/nerdtree'
                " Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  " 会报错
                "
                    autocmd StdinReadPre * let s:std_in=1
                    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
                Plug 'jonathanfilip/vim-lucius'   " colorscheme lucius
            endif
        call plug#end()
            " update &runtimepath and initialize plugin system
            " Automatically executes:
                " filetype plugin indent on
                " syntax enable或者syntax on
				" plug#end() 这行只能出现一次, 如果多次出现, 会让registered的插件可以plugclean, (被视为invalid plugins)

        autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif

    " vim-sandwich的设置, 要在plug#end()后
            let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

            " add spaces inside bracket
            let g:sandwich#recipes += [
            \   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
            \   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
            \   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
            \   {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['{']},
            \   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['[']},
            \   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['(']},
            \ ]

            let g:sandwich_no_default_key_mappings = 1
            let g:operator_sandwich_no_default_key_mappings = 1

            " : To prevent unintended operation
                " nmap s <Nop>
                    "搞死了前面这个 nmap s <Plug>(easymotion-f)
                " xmap s <Nop>
                " xmap creates a mapping for just Visual mode
                    " <NOP>    do nothing (useful in mappings)  no-opperation

            " [number]<command>[text object or motion]
            " t: 记作tag, 成对符号
            nmap ta <Plug>(operator-sandwich-add)
            xmap ta <Plug>(operator-sandwich-add)
            xmap td <Plug>(operator-sandwich-delete)
            xmap tr <Plug>(operator-sandwich-replace)
            nmap <silent> td <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
            nmap <silent> tr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
            nmap <silent> tdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
            nmap <silent> trb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
            " DEBUG: easymotion发疯来这里

            " xnoremap sd <Plug>(operator-sandwich-delete)
            " xnoremap sr <Plug>(operator-sandwich-replace)
            "
            " sc:  sandwich surround Code
            " nmap <Leader>pb <Plug>(operator-sandwich-add-query1st)
            " nmap sa <Plug>(operator-sandwich-add-query1st)
            "
            " 加了没反应

            nmap trt     <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
                        " p for pairs
                        " 这里不能用noremap

                        " 默认的是srb
                            " silent! nmap <unique> srb <Plug>(sandwich-replace-auto)
                            " nmap <silent> <Plug>(sandwich-replace-auto) <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)


" 如何处理string等
	set iskeyword+=-
		" 不加连字符, peco-find 就不是一个word, viw就被连字符打断
	set iskeyword-=#
		" 如果井号作为单词的一部分, 会导致替换时, ctrl w多删了井号
	let g:selecmode="mouse"

	" Return to last edit position when opening files
		autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   execute "normal! g`\"zv" |
			\ endif



" 主要影响map
    set timeoutlen=600
    " set notimeout

" tty?
    set ttimeout ttimeoutlen=10

" 我的map 不涉及插件
	inoremap jj <esc>
	nnoremap yf ggyG<C-O>
	" ctrl o 让光标看着没动
	nnoremap vf ggVGp:echo"已粘贴之前复制的内容"<CR>
	nnoremap df ggdG
		" p后面一般没有参数，所以pf不好。选中全文，一般只是为了替换。所以vf选中后，多了p这一步
	" inoremap yf <Esc>ggyG<C-O>
		" vscode里不行，vscode外也别试了, 保持一致

	" 上下左右
		noremap <Right> *
		noremap <Left> #

		noremap <Up> <C-O>
			" up在vusial mode下好像没功能
		vnoremap <Up> :<esc><C-O>
			" vnoremap <Up> <Esc><C-O>  " 不行

		nnoremap <Down> <C-I>
			" CTRL-I 等价于<Tab>
		vnoremap <Down> :<esc><C-I>


	nnoremap X <C-A>
		" normal模式：<C-X>  数字减1
		" shift在ctrl上，加1 vs 减一，刚好

	inoremap <C-F> <C-X><C-F>
		" <C-X> 调自带的omnicomplete
		" 被coc占用了？
		" 对于vscode-nvim：insert mode is being handled by vscode 所以<C-X>没反应

	" 待用的map
		" U is seldom useful in practice,U 本身的功能，不及C-R
		nnoremap U <C-R>
		nnoremap <M-u> <C-R>

		nnoremap <S-Left> :echom 'hihihihihi'<CR>
		nnoremap <S-Right> :echom 'hihihihihi'<CR>
		nnoremap <C-Left> :echom 'hihihihihi'<CR>
		nnoremap <C-Right> :echom 'hihihihihi'<CR>
		nnoremap <m-s-u> :echom 'hihi'<CR>

	" 看哪个好用:
		nnoremap gf :tab drop <cfile><CR>
		" nnoremap gj :tab drop <cfile><CR>
			" gj留给vscode作为wrapped line的j
		nnoremap gd :split<CR>md<C-]>
			" gd只能在本文件内找
			" 先mark个d, 看完再'd

	nnoremap gh :tab help <C-R><C-W>
			" vim本来用K, K被我map了
		" to be used:  " select mode 是为了讨好MS word患者, 没啥用

				"                             *gV* *v_gV*
				" gV			Avoid the automatic reselection of the Visual area
				"             after a Select mode mapping or menu has finished.
				"             Put this just before the end of the mapping or menu.
				"             At least it should be after any operations on the
				"             selection.
				"
				"                             *gh*
				" gh			Start Select mode, charwise.  This is like "v",
				"             but starts Select mode instead of Visual mode.
				"             Mnemonic: "get highlighted".
				"
				"                             *gH*
				" gH			Start Select mode, linewise.  This is like "V",
				"             but starts Select mode instead of Visual mode.
				"             Mnemonic: "get Highlighted".
				"
				"                             *g_CTRL-H*
				" g CTRL-H		Start Select mode, blockwise.  This is like CTRL-V,
				"             but starts Select mode instead of Visual mode.
				"             Mnemonic: "get Highlighted".

" block模式
    " 记忆：c for block
    "

    nnoremap <c-c> <c-v>
            " vscode里,map <c-c> 或者<c-v>都不生效, 一直是vim本来的功能
    cnoremap <c-c> <c-v>
        " 变成^  （以^H等方式显示一些控制字符）
    " iunmap <c-v>  加了这行,导致ctrl c不能成为i_ctrl-v
    inoremap <c-c> <c-v>
        " i_CTRL-C	Quit insert mode,
        "             not check for  abbreviations.
        "             Does not trigger the |InsertLeave| autocommand  event.
            " iunmap <c-v>
            "   加了这行,导致i_ctrl_c不能成为i_ctrl-v
            " recussive unmap?

        " *i_CTRL-V*
        " *i_CTRL-Q*
        " Insert next non-digit `literally`.
        "      For special keys, the  terminal code is inserted.
        "      The characters typed right after CTRL-V are not considered for  mapping.

    " 加了几行，还是粘贴
    " inoremap <c-v> <c-v>
    " cnoremap <c-v> <esc>:echo 'hi'
            " 没反应  " 会粘到正文里. 什么插件在搞鬼?

    " nnoremap <c-v> <c-v>
            " ctrl v不知道为啥变成了 在normal mode下粘贴windows的clipboard内容
            " 大概看了下, 应该不是stty和tmux的问题

    " 加了这两行，还是删除到行首
    " cnoremap <c-q> <c-v>
    " inoremap <c-q> <c-v>




" About search
" >_>_>===================================================================begin
    set incsearch  " incremental searching
    set wrapscan
    set ignorecase smartcase

    " .1 自动取消高亮=========================================begin
        set hlsearch " 高亮search
        " s: search set highlight
        nnoremap <Leader>ss :set hlsearch!<CR>


        let s:current_timer = -1

        func! Highlight_Search_off(timerId)
            set hlsearch!
        endfunc

        func! ResetTimer()
            if s:current_timer > -1
                call timer_stop(s:current_timer)
            endif
                                            " 第一个参数：按键多少ms后 自动取消
            let s:current_timer = timer_start(3000, 'Highlight_Search_off')
        endfunc


        nnoremap <silent> N N:call ResetTimer()<CR>
        nnoremap <silent> n n:call ResetTimer()<CR>
    " end========================================================<_<_<


    " .2 不搜注释里的内容=========================================begin
    " filetype        on        " 检测文件类型
    " filetype plugin on        " 针对不同的文件类型, load不同plugin
    " filetype indent on        " 针对不同的文件类型采用不同的缩进格式
    filetype plugin indent on " 实现了上面3行
        " 注意下, vim-plug的call plug#end() 会Automatically executes:
                    " filetype plugin indent on
                    " syntax enable或者syntax on

    " if the file type is not detected automatically, or it finds the wrong type,
    " you can  add a modeline to your  file.
        " 但root用户或者vscode-neovim使得modeline是off的，而且, vscode neovim无法识别filetype?
        " 不能靠modelinem 这时要靠这行：
    filetype detect
    " echom "文件类型是"
    " echom &filetype
    " echom "文件类型输出结束"

    au BufNewFile,BufRead *.Vnote  setf vim

    " ms: mark as searh, 回头敲's跳回来
    " https://stackoverflow.com/a/3760486/14972148
    " 据说map了slash会影响其他插件. 不过先用着吧
        if &filetype == 'vim'
            nnoremap ? msgg/\v^[^"]*
        " 防止检测filetype不准
        elseif expand('%:t') == 'init.vim'
            nnoremap ? msgg/\v^[^"]*

        " vim的某个文件已经设置了:  au BufNewFile,BufRead *.ahk  setf autohotkey
        elseif &filetype == 'autohotkey'
            nnoremap ? msgg/\v^[^;]*
            " todo 装个插件
            " https://github.com/hnamikaw/vim-autohotkey
        elseif expand('%:t') == 'wf_key.ahk'
            nnoremap ? msgg/\v^[^;]*
        elseif expand('%:t') == 'tmux.conf'
            nnoremap ? msgg/\v^[^#]*
        elseif &filetype  == 'zsh'
            nnoremap ? msgg/\v^[^#]*
        elseif &filetype  == 'json'
            nnoremap ? msgg/\v^[^/]*
        else
            " vscode neovim无法识别filetype?
            " 暂时一锅乱炖
            nnoremap ? msgg/\v^[^#";]*
        endif

        " 先mark再跳走
        nnoremap g/ msgg/
            " 记作global search
        nnoremap /  ms/
    " end=====================================================================<_<_<



" set linebreak
" set list  " 没设listchar时，这行会导致tab排版混乱
" set listchars=tab:>_,trail:-,nbsp:+

" ctrl and shift
    " map <c-s-a>
    " map <s-c-a>
        " 暂不支持
        " https://stackoverflow.com/a/47656794/14972148

" source各种文件
	source ~/dotF/cfg/nvim/clipboard_regis.vim
	source ~/dotF/cfg/nvim/beautify_wf.vim
			" 这行要调用lucius， 要在`call plug#end()`后面
	source ~/dotF/cfg/nvim/tab_status_lines.vim


" 替换/replace
	" :[range]s[ubstitute]/{pattern}/{string}/[flags] [count]
	nnoremap <F2>   : .,$sub  #\<\>##gc<Left><Left><Left><Left><Left><Left><C-R><C-W><Right><Right><Right><C-R><C-W>
	nnoremap <M-F2> : .,$sub  ###gc<Left><Left><Left><Left><C-R><C-W><Right>
		"       %       表示全文. Example: :%s/foo/bar/g.
		"       .       当前行
		"       $       表示结尾
		"       .,$     from the current line to the end of the file.
                                " 这些不能作为delimiter : 双引号， 竖线， backslash
                                " 其他single-byte character都可以


autocmd FileType json syntax match Comment +\/\/.\+$+
    " get correct comment highlighting for jonsc
    "

    " https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
" 空格 tab
    " T:tab, tab to space
    func! T2S()
        " vscode 有个插件：takumii.tabspace  " 不过应该用不着了
        set expandtab tabstop=4
        " [range]retab 百分号% 表示全文
        %retab!
        echo "  Tab变成4空格"
        endfunc

    autocmd BufNewFile,BufRead *.py  execute ":call T2S()"
        " autocmd对neovim-vscode无效？

    " Two to Four
    func! T2F()
        echom "  2个空格 变成tab"
        set noexpandtab tabstop=2
        " [range]retab 百分号% 表示全文
        %retab!
        call T2S()
        endfunc

    " nnoremap <F10> :call Indent_wf()<CR>
    " inoremap <F10> <ESC>:call Indent_wf()<CR>i


" python文件中输入新行时 #号注释不切回行首
" autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#


" 保存文件时删除多余空格
func! <SID>TrailingWhiteSpace()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunc
    autocmd FileType c,cpp,javascript,python,vim,sh,zsh autocmd BufWritePre <buffer> :call <SID>TrailingWhiteSpace()


let g:ft_man_folding_enable=1
let g:man_hardwrap=1


if has('win32')
    " echo 'leo: 正在用win32，win32表示 32 or 64 bit的windows'
    let g:python3_host_prog = "F:\\python39\\python.exe"  " ToggleBool会用到
    " let g:python_host_prog = ""  " ToggleBool会用到   我fork了这个插件 并改了?
    " let g:loaded_python_provider = 0
endif




" [[----------------------------nerdcommenter-config-------------------------------begin
    " g代表Global Variable
    let g:NERDCreateDefaultMappings = 0    " 别用默认的键位

    let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters
    let g:NERDCompactSexyComs = 1 " Use compact syntax for  multi-line comments
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'

    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }
    let g:NERDCommentEmptyLines = 1  " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
    let g:NERDToggleCheckAllLines = 1 " check all selected lines is commented or not

    " 对vscode无效,不知道为啥
    " <C-/> 在vim中由C-_表示 zsh下敲cat后，ctrl / 显示  ^_
    nnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>j
    inoremap <C-_> <ESC>:call nerdcommenter#Comment('n', 'toggle')<CR>j
    vnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>


    " 不行
    " func! InlineCommentWf()
    "     execute "normal A"
    "     execute "normal o/"
    "     call nerdcommenter#Comment("n", "Comment")
    "     execute "normal kJA"
    " endfunc





    nnoremap <M-/> yy:call nerdcommenter#Comment('n', 'toggle')<CR>p

    " 好慢：
    " nnoremap = :<plug>nerdcommentertoggle<cr>j
    " nnoremap - :k<plug>nerdcommentertoggle<cr>
    " 这行不行:
    " nnoremap = :call <Plug>NERDCommenterInvert<CR>


    "let g:NERDDefaultNesting = 1
" ---------------------------nerdcommenter-config----------------------------------end]]




" nnoremap cb O'''<Esc>Go'''<Esc>
" inoremap cb '''<Esc>Go'''<Esc><C-o>i

"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================start
nnoremap < <<
nnoremap > >>
"缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv
    " 状态栏提示 3 lines <ed 1 tim
    "            3 lines >ed 1 tim
    " >ed is just short for "shifted"
        "不行:
        " vnoremap < <<gv
        " vnoremap > >>gv


noremap K r<CR><UP>
nnoremap J Ji <Esc>

set pastetoggle=<F9>

"有空再搞

"nnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
"nnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
"nnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
"nnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

"nnoremap <silent> <C-b> :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')

"nnoremap <silent> <C-w>H :<C-u>call VSCodeNotify('workbench.action.moveEditorToLeftGroup');<CR>
"nnoremap <silent> <C-w>L :<C-u>call VSCodeNotify('workbench.action.moveEditorToRightGroup');<CR>

"nnoremap <silent> <Leader>f :<C-u>call VSCodeNotify('editor.action.formatDocument')<CR>
"


"nnoremap <silent> <Leader>pi :PlugInstall<Cr>
"nnoremap <silent> <Leader>pc :PlugClean<Cr>
"nnoremap <silent> <Leader>pu :PlugUpdate<Cr>




"" vim-textobj-parameter
"let g:vim_textobj_parameter_mapping = 'a'

"" vim-doge
"let g:doge_mapping = '<Leader>dc'


"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================end



" nnoremap  J j






" 有个自动补全插件 导致(变成  选中候选，只能这样map
inoremap ( (

set completeopt=noinsert,menuone


func! Wfprint_n()
    if &filetype == 'python'
        " todo 加叹号
        " normal! 表示不允许mapping
        " execute "normal yiwoprint(f'{= }')"
        execute "normal yiwoprint(f'{= }')"
        execute "normal hhhhhp"
    elseif &filetype == 'cpp'
        " execute 'normal yiwocout<<""<<' | execute 'normal hhhpf<lpa<<endl;'
        execute 'normal yiwocout<<""<<'
        execute 'normal hhhpf<lpa<<endl;'
    elseif &filetype == 'zsh'
        execute 'normal yiwoecho ${}'
        execute "normal hp"
    elseif &filetype == 'vim'
        execute 'normal yiwoecho &'
        execute "normal p"
    endif
endfunc

func! Wfprint_v()
    if &filetype == 'python'
        " todo
        " visual 是退出ex mode，进入normal mode, 不是在visual mode 执行
        " execute "visual y"
        " y
        execute "normal oprint(f'{= }')"
        execute "normal 4h"
    endif
endfunc

nnoremap _p :call Wfprint_n()<CR>
vnoremap _p :call Wfprint_v()<CR>




" <bar> : 表示 '|' ,  to separate commands, cannot use it directly in a mapping, since it would be seen as marking the end of the mapping.
" 百分号代表当前文件
" bash 的  &&  是前面的命令成功了，继续执行后面的
" autocmd filetype cpp nnoremap <C-c> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

set autowrite

" mswin.vim会导致visual mode 光标所在字符不被选中
" ~/dotF/mswin.vim里有用的内容都在这里
" [[---------------------------------------msvim-------------------------------


" saving,
noremap <C-S>       :update<CR>
inoremap <C-S>      <C-O>:update<CR>
vnoremap <C-S>      <C-C>:update<CR>
                    " Stop Visual mode
                    " *v_CTRL-C*  v表示 Visual mode;

" For CTRL-V to work,  autoselect must be off.
" On Unix we have two selections, autoselect can be used.
" if !has("unix")
"   set guioptions-=a
" endif


" nnoremap <C-Z> u|  " CTRL-Z is Undo
" nnoremap <C-Z> u |  " CTRL-Z is Undo
                " 竖线前的空格，视为map后的一部分。
" CTRL-Z is Undo
inoremap <C-Z> <C-O>u

" inoremap <C-R> <C-O>u
"<C-R>:    Insert the contents of a register

" CTRL-Y is Redo (although not repeat)
" nnoremap <C-Y> <C-R>  <c-y>还是用于scroll吧
" inoremap <C-Y> <C-O><C-R>
inoremap <C-Y> <Esc><C-R>a



" ---------------------------------------msvim-------------------------------]]

" 要删完行末，敲D, dL用于删剩最后一个，比如引号 括号
nnoremap dL v$hhd

noremap <F5> <ESC>oimport pudb<ESC>opu.db
inoremap <F5> <ESC>oimport pudb<ESC>opu.db

" 定义函数AutoHead，自动插入文件头
func! AutoHead()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/zsh")
    elseif &filetype == 'python'
        " google Python风格规范: 不要在行尾加分号, 也不要用分号将两条命令放在同一行。
        " 但不会报错

        " call append(2, 'from dotF.snippetS import *')
        " call append(2, 'sys.path.append(wf_home)')
        " call append(2, 'wf_home = os.path.expanduser("~/")')
        call setline(1, 'import cv2 as cv,cv2')

        call append(1, '#-----------------------自动import结束------------------------#')
        call append(1, 'import sys os json')
        call append(1, 'import numpy as np')

        " call append(2, '    ')
        " call append(2, '    print(round(wf_str,2))')
        " call append(2, '    if type(wf_variable) ==r ')
        " call append(2, 'def xprint(wf_variable):')
        " 括号内部不能换行
    endif

    normal G
    normal o
    normal o
endfunc

autocmd BufNewFile *.sh,*.py execute ":call AutoHead()"







" if 1
    " echo ' wf初始化的文件: ~/dotF/vimrc'
" endif
" nvim中不了<HOME> <END>    $行末 ^行首 结合autohotkey


" <Plug>NERDCommenterToggle<CR>和 :call NERDComment('n', 'toggle')<CR> 应该一样
" nnoremap = :call nerdcommenter#Comment('n', 'toggle')<CR>j
" vim的等号：用来indent
" ==     4= 等
nnoremap - :call nerdcommenter#Comment('n', 'toggle')<CR>k

" 这行 不行:
" nnoremap = :call <Plug>NERDCommenterInvert<CR>



nnoremap <Leader>r :call WfRun()<CR>

func! WfRun()
    execute "w"
    echo "wf_已保存"
    if &filetype == 'python'
        "跑votenet的某个文件时,若这样执行,pc_util.write_ply没被调用; 若正常敲python执行,则正常
        "% 代表当前文件
        execute "! python %"
    elseif &filetype == 'sh'
        execute "! zsh %"
    elseif &filetype == 'cpp'
        execute " ! rm -f /d/script.wf_cpp; g++ -std=c++11 % -Wall -g -o /d/script.wf_cpp `pkg-config --cflags --libs opencv` ; /d/script.wf_cpp "
    endif
endfunc




" CapsLock 识别不了
" map <CapsLock>[ #
" map <CapsLock>] *

let g:ackprg = 'ag --vimgrep'



if exists('$TMUX')
    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
    autocmd VimLeave * call system("tmux rename-window zsh")
    " autocmd BufEnter,FocusGained * call system("tmux rename-window " . expand("%:t"))
    " autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
    set title
endif


"  基础设置
    set title  " change the terminal's title
    set mouse=a  " enable mouse for n,v,i,c mode
    set mousehide  " Hide the mouse cursor while typing

    set nocompatible  " 别兼容老的vi
    set backspace=indent,eol,start
        " allow backspacing 删除:
                " indent   autoindent
                " eol      line breaks (join lines)
                " start    the start of insert; CTRL-W and CTRL-U stop once at the start of insert.
    " 别用，会覆盖DIY的配置:
        " syntax on
        " syntax enable  " 等于上面一行?


        set history=2000  " history存储容量
        set autoread  " 文件修改之后自动载入

        " shortmess: short messages, 简略提示
        set shortmess=I  " I:启动的时候不显示多余提示
        set shortmess+=t  " t: trunc if too long
        set shortmess+=F  " F don't give the file info when editing a file, like :silent

        set shortmess=filnxtToOF



        set cmdheight=1
        " set cmdheight=2
            " To reduce the number of hit-enter prompts:
            " - Set 'cmdheight' to 2 or higher.

    " 自动判断编码时，依次尝试以下编码：
    set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1,big5,eu
    set fencs=utf8,gbk,gb2312,gb18030



" swap file
    " let s:noSwapSuck_file = fnamemodify($MYVIMRC, ":p:h")  . "/noswapsuck.vim"    " 字符串concat，用点号
    "             " fnamemodify比expand的功能更强
    "                 " :echo @%                |" directory/name of file
    "                 " :echo expand('%:p')     |" full path
    "                 " :echo expand('%:p:h')   |" directory containing file ('head')
    "                 " :echo expand('%:t')     |" name of file ('tail')
    " exe 'source ' . s:noSwapSuck_file
    "         " 这样不行： source  . s:noSwapSuck_file
    " " 取代了这些：
    "     " set nobackup  取消备份。 视情况自己改
    "     " set noswapfile  关闭交换文件
    "
    "


" Remember info about open buffers on close
    " 只能存最后一次退出时所打开的session 的信息
    " nvim的session, tab, window,  和tmux的session, window,  pane分别对应
        set shada^=%
        set shada='1000
                " 单引号 对应mark
                " Maximum number of previously edited files for which the marks  are remembered.
                    " This parameter must always be included when  'shada' is non-empty.
                    " 使得 the |jumplist| and the  |changelist| are stored in the shada file.
        set shada+=f1
                " 记录所有A-Z和0-9 marks  (它们是global marks)
        set shada+=<500
                "小于号:   Maximum number of lines saved for each register.
                "         太大会导致启动慢
        set shada+=s100
                    "s: size 有点复杂
        set shada+=%
                    " %:
                        " When included, save and restore the buffer list.
                        "  If Vim is started without a file name argument,
                        "  the  buffer list is restored from the shada file

        " set shadafile=$XDG_...
                    " 文件默认在~/.local/share/nvim/shada/main.shada

" Display Settings
    set noshowmatch  " 用了matchup, 这个可以取消掉: 括号配对情况, 跳转并高亮一下匹配的括号
    " set matchtime=2  " How many tenths of a second to blink when matching brackets
    " set ruler  " 显示当前的行号列号  If the statusline is given by 'statusline' (i.e. not
            " empty),这个设置会被覆盖,




" 折叠
" 其实敲zi就行...不用自己写函数
    " set foldmethod=indent  " 初步尝试, 缩进最好
    set foldmethod=manual
        " set fdm=indent
    set foldopen=block,
                \hor,
                \insert,
                \jump,
                \mark,
                \percent,
                \quickfix,
                \search,
                \tag,
                \undo
    set foldlevel=0
        " 对于nested fold, level是fold的深度(嵌套次数)?
        " 每次只往上fold到这个level?
        "深度 大于这个数的fold才被隐藏
        " zero will close all folds.
        " Higher numbers will close fewer folds.

    set foldcolumn=auto
    " set foldignore=#,;"
    set foldignore=
    let s:folded = 1

    " toggle fold /  fdm
        func! Fold_01()
            if s:folded == 1
                set nofoldenable
                let s:folded = 0
                normal! zR
            else
                set foldenable
                set foldmethod=indent
                normal! zM
                let s:folded = 1
            endif
            set foldenable?
        endfunc
        nnoremap <leader>z :call Fold_01()<cr>zz
                    " z: zhe折叠
                    " zz: 光标所在行 挪到屏幕中间

    autocmd FileType txt setlocal foldmethod=expr
    autocmd FileType txt setlocal foldexpr=VimHelp_fold()
        function! VimHelp_fold()
            let thisline = getline(v:lnum)
            if thisline =~? '\v^\s*$'
                " \v 开头 any number of spaces 结尾
                return '-1'
                " use the fold level of a line before or after this line, ( 二者取min)
            endif

            if thisline =~ '^========.*$'
                return 1
            else
                return indent(v:lnum) / &shiftwidth
            endif
        endfunction

    nnoremap <backspace> zazz
    " 折叠并让光标所在行 显示在屏幕中间
    " gO			Show a filetype-specific, navigable "outline" of the
    "
    "             current buffer.  Currently works in |help| and |:Man| buffers.

    " 失败:
    " nnoremap <CR> za
    " nnoremap <enter> za
        " nnoremap gO :call Table_Of_Content()
        " func! Table_Of_Content()
        "     nunmap <enter>
        "     normal! gO
        " endfunc


" nnoremap ww <c-w>w
nnoremap ws <c-w>w
        " windows switch


" 滚动scrolling of the viewport
    " c-d本来是翻页，光标会动
    set scrolloff=4
        " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
    " 光标不再位于原来的文本处
        nnoremap <c-d> 15<c-d>
        nnoremap <c-u> 15<c-u>
    " ctrl-e (记作 extra lines)和ctrl-y是一对, 光标还在原来的文本处
        nnoremap <c-e> 4<c-e>
        nnoremap <c-y> 4<c-y>


" vk88加a/e, 这些map留作他用
    " nnoremap <C-a> ^
    " inoremap <C-a> <ESC>I

    " nnoremap <C-e> $
    " inoremap <C-e> <ESC>A


" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim


" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()  " tabpagenr(): 换取当前tab的序号
" autocmd [group] {event} {pat} {cmd}



nnoremap vv V
    " 和yy,dd,cc一致
nnoremap Y y$
nnoremap V v$


" Jump to start and end of line using the home row keys
" 增强tab操作, 导致这个会有问题, 考虑换键
"nmap t o<ESC>k
"nmap T O<ESC>j



" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" remap U to <C-r> for easier redo
nnoremap U <C-r>


set updatetime=300
    " longer updatetime (default is 4000 ms = ) leads to  delays and poor user experience.



" 用法: 比如  put =Vim_out('help func')
funct! Vim_out(my_cmd)
" https://unix.stackexchange.com/a/8296/457327
    redir =>my_output
    " a 表示argument
    silent execute a:my_cmd
    redir END
    return my_output
endfunc
" 用法:  put =Vim_out('你的命令')

" <C-:> 不行，cat后`ctrl :`   显示的是<C-[>，和真的<C-[> 已经esc同体？

" unmap <C-[>
nnoremap  <c-'>     :tab drop ~/.t/wf_out.vim<CR>:put = Vim_out('')<left><left>
nnoremap  <Leader>: :tab drop ~/.t/wf_out.vim<CR>ggdG:put = Vim_out('')<left><left>

" nnoremap <c-p> :echo 'to be uesd'<CR>
nnoremap <c-n> :echo 'ctrl-n to be uesd'<CR>

" 避免在不想注释时, 多出注释
nnoremap O O<backspace>
" 设了这个会导致k在最后一行卡顿一下 nnoremap ko O



" autocmd BufRead *  execute ":call Conceal_strang_chr()"
" 需要时手动执行吧
func! Conceal_strang_chr()
    " syn match name_you_like  /[^[:print:]]/ conceal cchar=  " 空格会被自动删掉
    syn match name_you_like  /[^[:print:]]/ conceal cchar=%
    set conceallevel=2
    set concealcursor=vc
endfunc


" set isprint+=9  " 9代表tab，设了回导致排版错乱
set isprint=@,161-255  " 默认值
" set isprint=1-255  " 设了屏幕会很乱  " Stack Overflow有个傻逼回答，别信

" autocmd BufRead *.txt  execute ":call Conceal_strang_chr_3()"
func! Conceal_strang_chr_3()
    " set isprint=1-255  " 设了屏幕会很乱
    set isprint+=9  " 设了屏幕会很乱
    " syn match name_you_like  /[^[:print:]]/ conceal cchar=%
    " set conceallevel=3
    " set concealcursor=vcni
endfunc





" cnoreabbrev
" cmap 对vscode也有效
        cnoreabbrev <expr> map   getcmdtype() == ":" && getcmdline() == 'map'          ? 'verbose map'                       :   'map'
        cnoreabbrev <expr> imap  getcmdtype() == ":" && getcmdline() == 'imap'         ? 'verbose imap'                      :   'imap'
        cnoreabbrev <expr> cmap  getcmdtype() == ":" && getcmdline() == 'cmap'         ? 'verbose cmap'                      :   'cmap'

" cd
        cnoreabbrev <expr> cfg   getcmdtype() == ":" && getcmdline() == 'cfg'          ? 'cd ~/dotF/cfg'                     :   'cfg'
        cnoreabbrev <expr> mdf   getcmdtype() == ":" && getcmdline() == 'mdf'          ? 'cd ~/dotF/'                        :   'mdf'
        cnoreabbrev <expr> dot   getcmdtype() == ":" && getcmdline() == 'dot'          ? 'cd ~/dotF/'                        :   'dot'
        cnoreabbrev <expr> ~/    getcmdtype() == ":" && getcmdline() == '~/'           ? 'cd ~/'                             :   '~/'
        cnoreabbrev <expr> man   getcmdtype() == ":" && getcmdline() == 'man'          ? 'tab Man '                          :   'man'
        " cnoreabbrev <expr> te    getcmdtype() == ":" && getcmdline() == 'te'           ? 'tab edit term: // zsh|p i'               :   'te'
        "                                                                                                      不行
        cnoreabbrev <expr> te    getcmdtype() == ":" && getcmdline() == 'te'           ? 'tabedit term://zsh'               :   'te'
        " cnoreabbrev <expr> t     getcmdtype() == ":" && getcmdline() == 't'           ? 'tab drop term://zsh'               :   't'
        cnoreabbrev <expr> ckh    getcmdtype() == ":" && getcmdline() == 'ckh'           ? 'checkhealth'               :   'ckh'
                                                                                        "  checkhealth时  有些optional的内容,  有error,  别管.  perl的东西难搞
        " cnoreabbrev <expr> st    getcmdtype() == ":" && getcmdline() == 'st'           ? 'split term://zsh'               :   'st'
        cnoreabbrev <expr> r    getcmdtype() == ":" && getcmdline() == 'r'           ? 'register'               :   'r'
        cnoreabbrev <expr> m    getcmdtype() == ":" && getcmdline() == 'm'           ? 'messages'               :   'm'
        cnoreabbrev <expr> me    getcmdtype() == ":" && getcmdline() == 'me'           ? 'messages'               :   'me'

        " todo: 把:h xxx自动替换成:tab help xxx
        " cnoreabbrev <expr> :h    getcmdtype() == ":" && getcmdline() == ':h '          ? 'cd ~/'                             :   '~/'


" terminal mode/windows设置
    " 插件toggleterm的设置
        " set hidden
        " lua require("toggleterm").setup{} " 没动静
        " let g:toggleterm_terminal_mapping = '<C-t>'
        " nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
        " inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>


    set  splitbelow  " split后的新窗口 位于下方
    set  splitright

    " autocmd TermClose *  bdel

    autocmd BufWinEnter,WinEnter  term://* startinsert
    autocmd BufWinEnter,WinEnter  term://* nnoremap <M-C-F10>q :bdel!<cr>
                                                                " 无论用bdel还是q, 原来的窗口都会split
    autocmd BufLeave              term://* stopinsert
    " autocmd BufLeave              term://* nnoremap <M-C-F10>q :echo "真要退出?" |q
    autocmd BufLeave              term://* nnoremap <M-C-F10>q :q



        " 不便于用vim的键位粘贴. 如果用tmux的键位粘贴, 那不如直接用tmux开zsh
        " 改变主意: 如果nvim代替tmux, 进入terminal一般要进insert mode

        " Like ":set" but set only the value local to the
                " current buffer or window.  Not all options have a
                "
        " 0到255
        " let g:terminal_color_4 = '442200'
        " let g:terminal_color_5 = 'black'
        " let g:terminal_color_255 = 'black'
        "
        "
         " In nvim, the terminal acts more like a normal buffer.
                " In vim, the 'termwinkey' option controls which key is recognized as "special" and
                " doesn't get passed directly to the terminal.
                " so in nvim, you would need to leave insert mode (via <C-\><C-n>) and then you can use normal mode commands like usual
                " of course, you can setup your own tmap bindings in nvim to make things work better for your workflow
        tnoremap <M-C-F10> <c-\><c-n>
        "  DEBUG:
        tnoremap <M-C-F10>h  <c-\><c-n>:tabprev<cr>
        tnoremap <M-C-F10>c  <c-\><c-n>:tabedit term://zsh<cr>
        tnoremap <M-C-F10>q  <c-d><c-\><c-n>:q!<cr>
        tnoremap <M-C-F10>\   <c-\><c-n>:vsplit term://zsh<cr>
        tnoremap <M-C-F10><space> <c-\><c-n>:split term://zsh<cr>
        " tnoremap <c-w> <c-w>
                " 不map的话, 是vim的window系列的prefix键
                " map了可以用 ,但有点慢

        tnoremap <C-r> <c-r>
        tnoremap <M-C-F10>e  <c-\><c-n><c-w><S-t>
        nnoremap <M-C-F10>e  <c-w><S-t>
        inoremap <M-C-F10>e  <esc><c-w><S-t>
        vnoremap <M-C-F10>e  <esc><c-w><S-t>
        cnoremap <M-C-F10>e  <esc><c-w><S-t>


        " To simulate |i_CTRL-R| in terminal-mode: >
            tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

        " To use `ALT+{h,j,k,l}` to navigate windows from any mode:
            " tnoremap <A-h> <C-\><C-N><C-w>h
            " tnoremap <A-j> <C-\><C-N><C-w>j
            " tnoremap <A-k> <C-\><C-N><C-w>k
            " tnoremap <A-l> <C-\><C-N><C-w>l
            " inoremap <A-h> <C-\><C-N><C-w>h
            " inoremap <A-j> <C-\><C-N><C-w>j
            " inoremap <A-k> <C-\><C-N><C-w>k
            " inoremap <A-l> <C-\><C-N><C-w>l
            " nnoremap <A-h> <C-w>h
            " nnoremap <A-j> <C-w>j
            " nnoremap <A-k> <C-w>k
            " nnoremap <A-l> <C-w>l

        nnoremap <M-C-F10>c            :tabedit term://zsh<cr>
        nnoremap <M-C-F10><space>      :split term://zsh<cr>

        inoremap <M-C-F10>c       <esc>:tabedit term://zsh<cr>
        inoremap <M-C-F10><space> <esc>:split term://zsh<cr>

        nnoremap <M-C-F10>\ :vsplit term://zsh<cr>
        nnoremap <M-C-F10>\ :vsplit term://zsh<cr>

        inoremap <M-C-F10>\ <esc>:vsplit term://zsh<cr>
        inoremap <M-C-F10>\ <esc>:vsplit term://zsh<cr>

        nnoremap <silent> <M-C-F10>h  :tabprev<cr>
        nnoremap <silent> <M-C-F10>l  :tabnext<cr>

        inoremap <silent> <M-C-F10>h  <esc>:tabprev<cr>
        inoremap <silent> <M-C-F10>l  <esc>:tabnext<cr>
        nnoremap <silent> <M-C-F10>j  <c-w>j
        nnoremap <silent> <M-C-F10>k  <c-w>k

        " z: 表示zsh
        nnoremap <C-Z> :tabedit term://zsh<cr>

    nnoremap <leader>h :tabprev<cr>
    nnoremap <leader>l :tabnext<cr>
    nnoremap <c-l> /<c-r><c-w><cr>
    nnoremap <c-h> ?<c-r><c-w><cr>

" m: middle
" nnoremap mm zz
" 保护小指, 逗号刚好在中指的位置  go to middle
nnoremap ,, zz
vnoremap ,, zz
nnoremap , z
nnoremap ,m zM
nnoremap ,r zR

set virtualedit=insert,block
" toggle virtualedit:  其实不用toggle? 一直按上面那行设就行? 先放着吧
    let s:anywhere = 0
    func! Cursor_anywhere_01()
        if s:anywhere == 0
            set virtualedit=insert,block
            set virtualedit?
            normal! o
            " set virtualedit=all # 会导致光标跳转不舒服
            let s:anywhere = 1
        else
            set virtualedit=
            let s:anywhere = 0
            set virtualedit?
        endif
    endfunc
    nnoremap <Leader>aw :call Cursor_anywhere_01()<cr>
    " insert mode 下map 空格, 很难用 反应迟钝
    " inoremap <Leader>aw <esc>:call Cursor_anywhere_01()<cr>

cnoremap <Up> <c-p>
cnoremap <Down> <c-n>
cnoremap <c-g> <c-r>"
cnoremap <C-Right> <c-r><c-w>

if exists('g:vscode')
    " cnoremap s/ s/\v
    " vscode里，用了cmap时，必须在光标后有字符才能正常map
    " echom '准备进入has_vscode.vim: 路径'
    echom $has_vscode
    source $has_vscode
    echom 'wsl下pwd有问题, 等邮件通知更新'
    " https://github.com/asvetliakov/vscode-neovim/issues/520
else
    source $no_vscode
endif


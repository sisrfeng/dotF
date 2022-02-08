" tabline:
    set showtabline=2
        " 1: only if there are at least two tab pages
        " 2: always

    func! Tabline()
        let style = ''
        for i in range(tabpagenr('$'))
            let tab = i + 1
            let winnr = tabpagewinnr(tab)
            let buflist = tabpagebuflist(tab)
            let bufnr = buflist[winnr - 1]
            let file_name = bufname(bufnr)
            let bufmodified = getbufvar(bufnr, "&mod")

            let style .= '%' . tab . 'T'
            let style .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
            let style .= ' ' . tab .'.'
            if  file_name =~ "term:"
                        " =~   regexp matches (zsh里也是这样 不是~=, python里用regular模块吧 )
                        " !~   regexp doesn't match
                " echo bufname() 显示:
                    " term://~/dotF/cfg/nvim//809801:zsh
                let file_name = "<" . bufnr . ">"
            endif
            let style .= (file_name != '' ? ''. fnamemodify(file_name, ':t') . ' ' : 'No Name')

            if bufmodified
                let style .= '[+] '
            endif
        endfor

        let style .= '%#TabLineFill#'
        return style
    endfunc
    set tabline=%!Tabline()



    hi TabLineFill  guibg=#e0e5e3  guifg=#123456
    hi TabLineSel   guibg=#e0f6e3  guifg=#123456
    hi TabLine      guibg=#e0e5e3  guifg=#123456

    " 改了不生效：
        " func! MyTab()
        "     let label = ''
        "     let bufnrlist = tabpagebuflist(v:lnum)
        "                                 " tab page number for 'guitablabel'
        "                                 "
        "     " Add '+' if one of the buffers in the tab page is modified
        "         for bufnr in bufnrlist
        "             if getbufvar(bufnr, "&modified")
        "                 let label = '+'
        "                 break
        "             endif
        "         endfor
        "
        "     if label != ''
        "         let label .= ' '
        "     endif
        "
        "     " Append the buffer name
        "     return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
        " endfunc

        " set tabline=%!MyTab()
        " 笔记:
        "
            "     N for number
            "     S for string
            "     F for flags as described below
            "     - not applicable
            "
            " item  meaning ~
            " f S   Path to the file in the buffer, as typed or relative to current  directory.
            " F S   Full path to the file in the buffer.
            " t S   File name (tail) of file in the buffer.
            " m F   Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
            " M F   Modified flag, text is ",+" or ",-".
            " r F   Readonly flag, text is "[RO]".
            " R F   Readonly flag, text is ",RO".
            " h F   Help buffer flag, text is "[help]".
            " H F   Help buffer flag, text is ",HLP".
            " w F   Preview window flag, text is "[Preview]".
            " W F   Preview window flag, text is ",PRV".
            " y F   Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
            " Y F   Type of file in the buffer, e.g., ",VIM".  See 'filetype'.
            " q S   "[Quickfix List]", "[Location List]" or empty.
            " k S   Value of "b:keymap_name" or 'keymap' when |:lmap| mappings are
            "       being used: "<keymap>"
            " n N   Buffer number.
            " b N   Value of character under cursor.
            " B N   As above, in hexadecimal.
            " o N   Byte number in file of byte under cursor, first byte is 1.
            "       Mnemonic: Offset from start of file (with one added)
            " O N   As above, in hexadecimal.
            " N N   Printer page number.  (Only works in the 'printheader' option.)
            " l N   Line number.
            " L N   Number of lines in buffer.
            " c N   Column number (byte index).
            " v N   Virtual column number (screen column).
            " V N   Virtual column number as -{num}.  Not displayed if equal to 'c'.
            " p N   Percentage through file in lines as in |CTRL-G|.
            " P S   Percentage through file of displayed window.  This is like the
            "       percentage described for 'ruler'.  Always 3 in length, unless
            "       translated.
            " a S   Argument list status as in default title.  ({current} of {max})
            "       Empty if the argument file count is zero or one.
            " { NF  Evaluate expression between '%{' and '}' and substitute result.
            "       Note that there is no '%' before the closing '}'.  The
            "       expression cannot contain a '}' character, call a function to
            "       work around that.  See |stl-%{| below.
            " {% -  This is almost same as { except the result of the expression is
            "       re-evaluated as a statusline format string.  Thus if the
            "       return value of expr contains % items they will get expanded.
            "       The expression can contain the } character, the end of
            "       expression is denoted by %}.


set laststatus=2  "  always show statusline
        " set laststatus=1  " only if there are at least two windows
        " 没有statusline时，命令那行和代码容易混在一起

" Each status line item is of the form: ( All fields except the {item} are optional.)
"       %-0{minwid}.{maxwid}{item}
    " 在上面的基础上：  (几表示某个highlight设置)
    " %Highlight配色号码

"


"  貌似不能放进colorscheme file.
    hi User1 guibg=#e0e5e3  guifg=#123456
    hi User2 guibg=#e0f6e3  guifg=#000000

" stl: statusline
" statusline是个str, 竖线 空格都要escape
" %几* 表示User几的highlight
    set stl=
    set stl+=%1*\ %2p%%\ \ %F\ \          " File+path
    " set stl+=\[buf号:%n]                  " buffernr
    set stl+=\ \ %r\                      " %r  readonly, 显示 [RO]
    set stl+=\ \ %w\                      " Top/bot.
    set stl+=\ \ 行:%l/%L\ \              " Rownumber/total (%)
    set stl+=\ 列:%2c\                    " Colnr
    set stl+=\|\ 格式:%{&fileformat}\     " FileFormat (dos/unix)
    " set stl+=\ %{&spelllang}\             " Spell language?

    autocmd TermEnter *  setlocal laststatus=0 | setglobal laststatus=2

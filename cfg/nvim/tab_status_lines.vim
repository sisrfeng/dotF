
hi TabLineFill  guibg=none
hi TabLineSel   guibg=#abefcd  guifg=#123456
hi TabLine      guibg=#e0f6e3  guifg=#123456



" 改了貌似不生效：
func! MyTab()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
                                   " tab page number for 'guitablabel'


    " Add '+' if one of the buffers in the tab page is modified
        for bufnr in bufnrlist
            if getbufvar(bufnr, "&modified")
                let label = '+'
                break
            endif
        endfor

    if label != ''
        let label .= ' '
    endif

    " Append the buffer name
    return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
endfunc

set guitablabel=%{MyTab()}
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




" todo
set showtabline=2

" Each status line item is of the form: ( All fields except the {item} are optional.)
"       %-0{minwid}.{maxwid}{item}
" 在上面的基础上：  (几表示某个highlight设置)
" %Highlight配色号码

"    %=   右对齐
"    %r  readonly, 显示 [RO]
" set statusline=
" set statusline=%7*=%r
" set statusline=%=%t                            " tittle
" set statusline+=%=\ buffer号:%n\            "buffer number
" set statusline+=%=%m                         "modified flag
" " set statusline+=%=文件格式:%{&ff}            "是否unix
" " flag[Preview] ??
" set statusline+=%=\ %h
" set statusline+=%=\ %w
" set statusline+=%=\ %k
" set statusline+=%=\ %q
" set statusline+=%999X
" " set statusline+=
" set statusline+=%=第%l行/
" set statusline+=%L行               "total lines
" set statusline+=(%p%%)
" set statusline+=%=第%v列         "virtual column number (screen column)
" " set statusline+=\ %c           " Column number (byte index).
"
"
set laststatus=2  "  always show statusline

hi User1 guibg=#f0f6f0  guifg=#128456
hi User2 guibg=#e0f6e3  guifg=#000000
set statusline=
" set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%1*\ %F\                                "File+path
set statusline+=%9*\[buf号:%n]                                  "buffernr  " buffer号码
set statusline+=%9*\ \ %r%w\                            " Readonly? Top/bot.
set statusline+=%8*\ %=\ 行:%l/%L\ (%3p%%)\             "Rownumber/total (%)
set statusline+=%9*\ 列:%3c\                            "Colnr

" set statusline+=%2*\ %y\                                  "FileType
" set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
" set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
" set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
" set statusline+=%5*\ %{&spelllang}\                         "Spellanguage
" set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

" set laststatus=1  " only if there are at least two windows
" 没有statusline时，命令那行和代码容易混在一起

" put the following lines in your current colorscheme file??
    "  貌似不能放进colorscheme file.
    " hi User1 guifg=#ffdad8  guibg=#880c0e


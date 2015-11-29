"==========================================
" vim:ft=vim
" Author:  edited by spacewander currently
" Version: 8
" Email: spacewanderlzx@gmail.com
" BlogPost:
" ReadMe: README.md
" StartAt: 2013-11-25
" Sections:
"     ->augroup and func 命令组和函数
"     ->General 基础设置
"     ->Show 展示/排版等界面格式设置
"     ->file encode, 文件编码,格式
"     ->others 其它基础配置
"     ->hot key  自定义快捷键
"     ->colortheme 主题,及一些展示上颜色的修改
"     ->bundle 插件管理和配置项
"==========================================
":) augroup and func 命令组和函数 {{{
" 切换绝对行号和相对行号
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

"删除多余空格
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
" 自动加权限
function! Chmod()
    if strpart(getline(1), 0, 2) == '#!'
        let f = expand("%:p")
        if stridx(getfperm(f), 'x') != 2
            call system("chmod +x ".shellescape(f))
            e!
            filetype detect
        endif
    endif
endfunction

" 切换鼠标模式和无鼠标模式。方便复制
function! ToggleMouse()
    if &mouse ==# 'a'
        set mouse=
        set norelativenumber
        set nonumber
        echo 'no mouse mode'
    else
        set mouse=a
        set number
        set relativenumber
        echo 'mouse mode'
    endif
endfunction

" 更改文件工作目录为该文件当前目录
function! ChangeWorkDir()
    lcd %:p:h
endfunction

" 在保存时自动排版格式
function! AutoFormat()
    exec 'normal! 1GVG='
endfunction

"通过一些钩子来自动调用一些函数
augroup myFun
    autocmd!
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite * :call ChangeWorkDir()
    autocmd BufWritePost * :call Chmod()
    "autocmd BufWritePost * :call DeleteTrailingWS()
    "autocmd BufWritePost * :call AutoFormat()
augroup END

noremap <F2> :call ToggleMouse()<CR>
nnoremap <S-F6> :call AutoFormat()<cr>
nnoremap <F6> :call DeleteTrailingWS()<cr>
"}}}
"==========================================
":) General 基础设置 {{{
"==========================================
" history存储长度。
set history=2000
"检测文件类型
filetype on
"针对不同的文件类型采用不同的缩进格式
filetype indent on
"允许插件
filetype plugin on
"启动自动补全
filetype plugin indent on

"非兼容vi模式。去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
set autoread          " 文件修改之后自动载入。
set shortmess=astI
set mouse=a
" 备份,到另一个位置. 防止误删
set backup
set backupext=.bak
set backupdir=~/bak/vimbk/
set cursorline              " 突出显示当前行
set display=lastline
"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
"好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=
" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=exclusive
set selection=inclusive
set selectmode=key
" 去掉输入错误的提示声音
set title                " change the terminal's title
set novisualbell           " don't beep
set noerrorbells         " don't beep
set t_vb=
set tm=500
"}}}
"==========================================
":) Show 展示/排版等界面格式设置 {{{
"==========================================
"显示行号：
set number
"set nowrap                    " 取消换行。
augroup specialFileWrap
    autocmd!
    autocmd BufReadPost *.html setlocal wrap
    autocmd BufReadPost *.js setlocal wrap
augroup END

"括号配对情况
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" 有一个或以上大写字母时仍大小写敏感
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
" 为vim脚本设定特殊的折叠方法
augroup vimFold
    autocmd FileType vim setlocal foldmethod=marker
augroup END
set foldlevel=99
set foldlevelstart=99

set cindent

set tabstop=4                " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4             " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab                " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
autocmd FileType make setlocal noexpandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast
"行号变成相对，可以用 nj  nk   进行跳转 5j   5k 上下跳5行
set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
augroup relativeNum
    autocmd!
    au FocusLost * :set number
    au FocusGained * :set relativenumber
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
augroup END
"create undo file
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set undofile                " keep a persistent backup file
set undodir=~/bak/vimundo/

"显示当前的行号列号：
set ruler
"在状态栏显示正在输入的命令
set showcmd
" Show current mode
set showmode

" Set 15 lines to the cursor - when moving vertically using j/k 上下滚动,始终在中间
set scrolloff=22
" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line
set laststatus=2
"高亮第80列，就像一把尺子
set cc=80
autocmd Filetype md setlocal cc=
autocmd Filetype text setlocal cc=
"}}}
":) file encode, 文件编码,格式 {{{
"==========================================

set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 下面这句只影响普通模式 (非图形界面) 下的 Vim。
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
" 合并两行中文时，不在中间加空格：
set formatoptions+=B
" }}}
"==========================================
":) others 其它配置 {{{
"==========================================
" 记住文件外观，如折叠等
"augroup rememberView
    "autocmd!
    "au BufWinEnter * silent! loadview
    "au BufWinLeave * silent! mkview
"augroup END

" about highlight
set nohlsearch          " do not highlight searched-for phrases
set incsearch           " ...but do highlight-as-I-type the search string

"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class,*.obj

" set tabsize here
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab ai
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufWinEnter *.erb setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType stylus setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
"autocmd FileType c setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
"autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" set cursorcolumn line here
"autocmd FileType coffee setlocal cursorcolumn
"autocmd FileType python setlocal cursorcolumn
set cursorcolumn

" if this not work ,make sure .viminfo is writable for you
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remember info about open buffers on close"
set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

autocmd BufReadPost *.styl setlocal omnifunc=csscomplete#CompleteCSS
autocmd BufReadPost *.scss setlocal omnifunc=csscomplete#CompleteCSS

" automatically leave insert mode after 'updatetime' milliseconds of inaction
"au CursorHoldI * stopinsert
" set 'updatetime' to 5 seconds when in insert mode
"au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
"au InsertLeave * let &updatetime=updaterestore
"}}}
"==========================================
":) hot key  自定义快捷键 {{{
"==========================================
" 设置全局leader键
let mapleader = ','
" 设置局部leader键"
let g:maplocalleader = '.'

nnoremap <F1> :vert help
inoremap df <c-[>
vnoremap df <c-[>

inoremap <c-v> <ESC>v
"Quickly fold/unfold
nnoremap Z za

"Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
noremap j gj
noremap k gk

" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>

"Smart way to move between windows 分屏窗口移动
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Go to home and end using capitalized directions
noremap H 0
noremap L $

" Remap VIM 0 to first non-blank character
noremap 0 ^

nnoremap <F4> :set wrap! wrap?<CR>
"set paste
set pastetoggle=<F5>            " when in insert mode, press <F5> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" quick close Quickfix
nnoremap <F10> :ccl<cr>

function! CleanSwFile()
    if expand('%:c')[0] == '.'
        !rm %.sw*
    else
        !rm .%.sw*
    endif
endfunction
nnoremap <s-F10> :call CleanSwFile()<cr>

function! AutoRunInBuf(cmd)
    :w
    let result = system(a:cmd .' ' . expand('%:p'))
    vsplit __Output__
    normal! ggdG
    set buftype=nofile
    set filetype=output
    call append(0,split(result, '\v\n'))
endfunction

function! AutoRun(cmd)
    :w
    execute '!'.a:cmd.' '.expand('%:p')
endfunction

augroup autoRun
    autocmd!
    noremap <F12> :call AutoRun('')<cr>
    noremap <s-F12> :call AutoRunInBuf('')<cr>

    au FileType sh nnoremap <s-F12> :call AutoRunInBuf('bash')<cr>
    au FileType sh nnoremap <F12> :call AutoRun('bash')<cr>
    au FileType ruby nnoremap <s-F12> :call AutoRunInBuf('ruby')<cr>
    au FileType ruby nnoremap <F12> :call AutoRun('ruby')<cr>
    au FileType python nnoremap <s-F12> :call AutoRunInBuf('python')<cr>
    au FileType python nnoremap <F12> :call AutoRun('python')<cr>
    au FileType javascript nnoremap <s-F12> :call AutoRunInBuf('node')<cr>
    au FileType javascript nnoremap <F12> :call AutoRun('node')<cr>
    au FileType coffee nnoremap <s-F12> :call AutoRunInBuf('coffee')<cr>
    au FileType coffee nnoremap <F12> :call AutoRun('coffee')<cr>
    au FileType go noremap <F12> :call AutoRun('go run')<cr>
    au FileType go noremap <s-F12> :call AutoRunInBuf('go run')<cr>
    au FileType lua noremap <F12> :call AutoRun('luajit')<cr>
    au FileType lua noremap <s-F12> :call AutoRunInBuf('luajit')<cr>
augroup END

noremap Y y$
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" expand %% to current directory in command-line mode
cnoremap %% <C-R>=expand('%:p:h')<cr>
" and this one for current file!
cnoremap %c <C-R>=expand('%:p')<cr>

" quick way to replace
nnoremap <leader>s :%s///gc<left><left><left><left>
" insert cword in commandline mode with Ctrl-r Ctrl-w
nnoremap <localleader>s :%s/<C-R><C-W>//gc<left><left><left>

nnoremap ; :
nnoremap : ;
nnoremap <leader>v V`}
" 清扫命令行
cnoremap <leader>d <End><c-u>

"Use sane regexes"
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Quickly close the current window
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>

" Quickly save the current file
nnoremap <leader>w :w<CR>
function! FixSaveCoffee()
    w
    if expand('%:e') ==? 'coffee'
        set ft=coffee
    endif
endfunction
au Filetype conf nnoremap <buffer> <leader>w :call FixSaveCoffee()<cr>
au BufReadPost *.coffee set ft=coffee

nnoremap <leader>x :x<CR>
inoremap <leader>w <ESC>:w<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
"nnoremap ' `
"nnoremap ` '

" remap U to <C-r> for easier redo
nnoremap U <C-r>
" select all
nnoremap <Leader>sa ggVG"

nnoremap <C-up> :tabnew<cr>
nnoremap <leader>te :tabedit
nnoremap <C-left>   :tabfirst<CR>
nnoremap <C-right>   :tablast<CR>
" insert 'end' in current line
inoremap <C-e> end

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <c-up> :e <c-r>=expand("%:p:h")<cr>/
nnoremap <c-down> :tabedit <c-r>=expand("%:p:h")<cr>/

nnoremap <leader>z0 :set foldlevel=0<CR>
nnoremap <leader>z1 :set foldlevel=1<CR>
nnoremap <leader>z2 :set foldlevel=2<CR>
nnoremap <leader>z9 :set foldlevel=99<CR>

" Change Working Directory to that of the current file
cnoremap cwd lcd %:p:h
nnoremap <C-x> :lcd %:p:h<cr>

" jump to the place with the same word. <bar> should be used ,otherwise the
" expressions won't be correct.
nnoremap <Leader>gw [I:let nr = input("Which one: ") <bar>exe "normal " . nr ."[\t"<CR>
nnoremap <Leader>fw ]I:let nr = input("Which one: ") <bar>exe "normal " . nr ."[\t"<CR>

" 从normal模式直接进入粘贴模式
nnoremap <S-F5> a<F5>

inoremap -( (
inoremap -{ {
inoremap -[ [
inoremap -' '
inoremap -" "
"}}}
"==========================================
":) 自定义命令和函数 {{{
"==========================================
augroup ultiEdit
    command! UE UltiSnipsEdit
augroup END

augroup railsCommand
    command! TM RTmodel
    command! TC RTcontroller
    command! TV RTview
    command! TJ RTjavascript
    command! TS RTstylesheet
    command! TR RTinitalizer
    command! VM RVmodel
    command! VC RVcontroller
    command! VV RVview
    command! VJ RVjavascript
    command! VS RVstylesheet
    command! VR RVinitalizer
    command! RT Rake
augroup END
"}}}
"==========================================
":) 主题,及一些展示上颜色的修改 {{{
"==========================================
"开启语法高亮
syntax enable
syntax on

"colorscheme solarized
set background=dark
set t_Co=256


"设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

"" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Monaco:h14 "for mac user
    if has("gui_gtk2")   "GTK2
        set guifont=Ubuntu\ Mono
    endif
    set guioptions-=T
    set guioptions+=e
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_Co=256
endif
"}}}
"==========================================
":) bundle 插件管理和配置项 {{{
"==========================================
"========================== config for plugins begin ======================================
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"filetype off " required! turn off
call neobundle#begin(expand('~/.vim/bundle'))

"################### 插件管理 ###################"

"使用NeoBundle来管理插件
NeoBundleFetch 'Shougo/neobundle.vim'

"################### 导航 ###################"
"标签导航
NeoBundle 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_show_linenumbers = -1
let g:tagbar_sort = 0
let g:tagbar_compact = 1

"for file search ctrlp, 文件搜索
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 'Et'
noremap <leader>ru :CtrlPMRU<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn|rvm)|node_modules|coverage)$',
            \ 'file': '\v(\.(exe|so|dll|zip|tar|tar.gz)|a.out)$',
            \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_max_files = 1000
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

NeoBundle 'dyng/ctrlsf.vim'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
"################### 显示增强 ###################"
"状态栏增强展示
NeoBundle 'bling/vim-airline'
let g:Powerline_symbols = 'unicode'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'


"括号显示增强
NeoBundle 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

"主题 molokai
NeoBundle 'tomasr/molokai'
let g:molokai_original = 1

"自动补全单引号，双引号等
NeoBundle 'jiangmiao/auto-pairs'
" 仅当同一行有闭合符号时才自动跳到闭合符号处
let g:AutoPairsMultilineClose = 0
autocmd Filetype ruby let b:AutoPairs = {
            \ '(':')', '[':']', '{':'}',
            \ "'":"'",'"':'"', '`':'`', 
            \ '|':'|'}

" new startup
NeoBundle 'mhinz/vim-startify'
" 保存会话
"command! Mk mksession! ~/Session.vim
"command! So so ~/Session.vim
command! Mk SSave
command! So SLoad

"################### 快速移动 ###################"

"更高效的移动 <leader><leader>+ w/fx
",,+w 跳转 ,,+fx 快速跳转定位到某个字符位置
NeoBundle 'Lokaltog/vim-easymotion'
" link color for vim-easymotion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

"%匹配成对的标签，跳转
NeoBundle 'vim-scripts/matchit.zip'

"################### 补全及快速编辑 ###################"
"快速插入代码片段
NeoBundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
"定义存放代码片段的文件夹 .vim/snippets下,必须在runtimepath下
"，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
"定义使用的python版本，为2.x
let g:UltiSnipsUsePythonVersion = 2
" let :UltiSnipsEdit open the snippets in vertical split
let g:UltiSnipsEditSplit = "vertical"
"username and user_email
let g:snips_author = "spacewander"
let g:snips_author_email = "spacewanderlzx@gmail.com""

"迄今为止用到的最好的自动VIM自动补全插件
NeoBundle 'Valloric/YouCompleteMe'
"具体配置内容请参考该项目的github主页
"youcompleteme  默认tab  s-tab 和自动补全冲突
",gd 高亮选中的函数 仅c-family语言有效
let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_global_ycm_extra_conf = '~/github/spacewander-vim/ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/github/spacewander-vim/ycm_extra_conf2.py'
nnoremap <leader>ey :execute ':vs '.g:ycm_global_ycm_extra_conf
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments = 1 "default value is 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_blacklist = {
            \ 'unite' : 1,
            \ 'notes' : 1,
            \}
let g:ycm_use_ultisnips_completer = 1
nnoremap <leader>bc :YcmDiags<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType python setlocal completeopt-=preview
autocmd FileType cpp setlocal completeopt-=preview
autocmd FileType c setlocal completeopt-=preview
autocmd FileType clojure setlocal completeopt-=preview
autocmd FileType go setlocal completeopt-=preview

NeoBundle 'marijnh/tern_for_vim'
autocmd FileType javascript setlocal completeopt-=preview
autocmd FileType javascript nnoremap <leader>jd :TernDef<cr>
autocmd FileType javascript nnoremap <leader>jr :TernRefs<cr>

"快速 加减注释
"<leader>cc 加上注释
"<leader>cu 解开注释
"<leader>ci 加上/解开注释
NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jshint_exec='/usr/bin/jshint'
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_shell_checkers=['shellcheck']
let g:syntastic_coffee_checkers=['coffeelint']
let g:syntastic_go_checkers=['govet']
highlight SyntasticErrorSign guifg=white guibg=black
let g:syntastic_loc_list_height = 5
autocmd BufWinEnter *.rb :let syntastic_mode_map = { 'mode':'active', 'passive_filetypes':[]}
autocmd BufWritePre *.rb :SyntasticCheck<cr>

" vim映射集锦
NeoBundle 'tpope/vim-unimpaired'
"################# 具体语言补全 ###############
"FOR HTML
" 著名的vim上的html简记法撰写插件，内容丰富而复杂，建议到官网上学习具体用法
"NeoBundle 'mattn/emmet-vim'
"let g:user_emmet_leader_key = '<leader>.'
"let g:use_emmet_complete_tag = 1
" for xml and html
"NeoBundle 'othree/xml.vim'
" [[ to previous open tag
" ]] to next open tag
" [] to previous close tag
" ][ to next close tag
" let <localleader> = '\'
" \c rename tag
" \f fold tag
" \d delete tag
" \D delete tag and its content

"################# 具体语言语法高亮及排版 ###############
" for jumping in C/C++
"NeoBundle 'vim-scripts/a.vim'
":A switches to the header file corresponding to the current file being edited (or vise versa)
":AS splits and switches
":AV vertical splits and switches
":AT new tab and switches
":AN cycles through matches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
":IHT new tab and switches
":IHN cycles through matches
"<Leader>ih switches to file under cursor
"<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
"<Leader>ihn cycles through matches

" for markdown
NeoBundle 'hughbien/md-vim'
autocmd BufWinEnter *.markdown set filetype=md
autocmd BufWinEnter *.md set filetype=md

NeoBundle "kchmck/vim-coffee-script"
autocmd BufWinEnter *.coffee set omnifunc=javascriptcomplete#CompleteJS

" for css
NeoBundle "spacewander/vim-coloresque"
NeoBundle 'hail2u/vim-css3-syntax'
" for stylus
NeoBundle 'wavded/vim-stylus'

" for ruby
NeoBundle 'tpope/vim-rails'
" for Go
NeoBundle 'fatih/vim-go'
autocmd BufWinEnter *.go nnoremap <leader>t :wa<cr>:!go test<cr>
autocmd BufWinEnter *.go inoremap <leader>t <ESC>:wa<cr>:!go test<cr>
autocmd BufWinEnter *.go nnoremap <leader>jd :GoDef<cr>

" for lua
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-lua-ftplugin'
let g:lua_complete_omni = 0
"################### 其他 ###################"
"edit history, 可以查看回到某个历史状态
NeoBundle 'sjl/gundo.vim'
nnoremap <leader>ud :GundoToggle<CR>

" end turn on
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"========================== config for plugins end ======================================
colorscheme molokai
"colorscheme desert
" settings for kien/rainbow_parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"}}}

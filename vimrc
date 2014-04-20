"==========================================
" vim:ft=vim 
" Author:  edited by spacewander currently 
" Version: 7
" Email: spacewanderlzx@gmail.com
" BlogPost:
" ReadMe: README.md
" Last_modify: 
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

augroup myFun
    autocmd!
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWritePost * :call Chmod()
augroup END

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
" 备份,到另一个位置. 防止误删, 目前是取消备份
set backup
set backupext=.bak
set backupdir=~/bak/vimbk/
" 取消备份。 视情况自己改
"set nobackup
"set noswapfile
" 突出显示当前行等 不喜欢这种定位可注解
"set cursorcolumn
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
    autocmd BufReadPost *.html set wrap
    autocmd BufReadPost *.js set wrap
augroup END

"括号配对情况
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" 搜索时忽略大小写
set ignorecase
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
"Smart indent
set smartindent
set autoindent    " always set autoindenting on
" never add copyindent, case error   " copy the previous indentation on autoindenting
set tabstop=4                " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4             " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab                " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
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
set scrolloff=15
" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line
set laststatus=2
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
augroup sourceVimrc
    autocmd! bufwritepost *.vim source % " vim文件修改之后自动加载。 windows。
    autocmd! bufwritepost *.vim source % " vim文件修改之后自动加载。 linux。
augroup END
" 记住文件外观，如折叠等
augroup rememberView
    autocmd!
    au BufWinEnter * silent! loadview
    au BufWinLeave * silent! mkview
augroup END

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

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab ai

" if this not work ,make sure .viminfo is writable for you
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remember info about open buffers on close"
set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
"}}}
"==========================================
":) hot key  自定义快捷键 {{{
"==========================================
" 设置全局leader键
let mapleader = ','
let g:mapleader = ','
" 设置局部leader键"
let maplocalleader = '\\'

inoremap df <c-c>
vnoremap df <c-c> 
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

noremap <F2> :call ToggleMouse()<CR>
nnoremap <F4> :set wrap! wrap?<CR>
              "set paste
set pastetoggle=<F5>            " when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

function! AutoRun(cmd)
    let result = system(a:cmd .' ' . expand('%:p'))
    vsplit __Output__
    normal! ggdG
    set buftype=nofile
    set filetype=output
    call append(0,split(result, '\v\n'))
endfunction

augroup autoRun
    autocmd!
    au FileType sh nnoremap <s-F12> :call AutoRun('sh')<cr>
    au FileType sh nnoremap <F12> :!sh %:p
    au FileType ruby nnoremap <s-F12> :call AutoRun('ruby')<cr>
    au FileType ruby nnoremap <F12> :!ruby %:p
augroup END

noremap Y y$
"cmap w!! %!sudo tee > /dev/null %
" w!! to sudo & write a file
cnoremap w!! w !sudo tee >/dev/null %

noremap <F1> :help 

nnoremap ; :
au FileType sh nnoremap <leader>m  :!man <cWORD><cr>
nnoremap <leader>v V`}
" 清扫命令行
cnoremap <leader>d <End><c-u>

"Use sane regexes"
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" grep current word
nnoremap <leader>jw :grep! -r <cword> *<cr>

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
"插入大括号的正确方式
inoremap {<CR> {<CR><CR>}<up><End>

" Quickly close the current window
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>

" Quickly save the current file
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
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

" Close the current buffer
"noremap <leader>bd :Bclose<cr>
"" " Close all the buffers
"noremap <leader>ba :1,1000 bd!<cr>

nnoremap <C-up> :tabnew<cr>
nnoremap <leader>te :tabedit 
nnoremap <C-left>   :tabprevious<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <c-down> :tabedit <c-r>=expand("%:p:h")<cr>/

nnoremap <leader>z0 :set foldlevel=0<CR>
nnoremap <leader>z1 :set foldlevel=1<CR>
nnoremap <leader>z2 :set foldlevel=2<CR>
nnoremap <leader>z9 :set foldlevel=99<CR>

" Change Working Directory to that of the current file
cnoremap cwd lcd %:p:h
" 保存会话
cnoremap ss mksession!
" jump to the place with the same word. <bar> should be used ,otherwise the
" expressions won't be correct.
nnoremap <Leader>gw [I:let nr = input("Which one: ") <bar>exe "normal " . nr ."[\t"<CR>
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

"}}}
"==========================================
":) bundle 插件管理和配置项 {{{
"==========================================
"========================== config for plugins begin ======================================

" 0-bundle the plugins
"package dependent:  ctags
"python dependent:  pep8, pyflake pylint

filetype off " required! turn off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"################### 插件管理 ###################"

"使用Vundle来管理Vundle
Bundle 'gmarik/vundle'
" vim plugin bundle control, command model
" :BundleInstall     install
" :BundleInstall!    update
" :BundleClean       remove plugin not in list

"################### 导航 ###################"
"目录导航
Bundle 'scrooloose/nerdtree'
noremap <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$','\.egg$','\.exe$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let g:netrw_home='~/bak'
let NERDTreeShowBookmarks=1
let NERDTreeShowLineNumbers=1
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

"for minibufferexpl
"Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplCycleArround=1

" 默认方向键左右可以切换buffer
" 似乎有一个问题，如果在其中一个窗口使用退出命令，则所有的窗口都会退出
"noremap <leader>bn :MBEbn<CR>
"noremap <leader>bp :MBEbp<CR>
"noremap <leader>bd :MBEbd<CR>

"标签导航
Bundle 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_show_linenumbers = -1
let g:tagbar_compact = 1

"标签导航 要装ctags
Bundle 'vim-scripts/taglist.vim'
set tags=tags;/
let Tlist_Ctags_Cmd="/usr/bin/ctags"
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 1
let Tlist_Max_Tag_Length = 30
let Tlist_Process_File_Always = 0
let Tlist_Show_Menu = 0
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "order"
let Tlist_Use_Horiz_Window = 0
let Tlist_Use_Right_Window = 0
let Tlist_WinWidth = 25

"for file search ctrlp, 文件搜索
Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
noremap <leader>f :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
"使用<ESC>退出搜索

Bundle 'Shougo/unite.vim'
Bundle 'rking/ag.vim'
nnoremap <leader>sc :Ag! <cWORD><cr>
nnoremap <leader>s :Ag! 

"################### 显示增强 ###################"
"书签
Bundle 'vim-scripts/Vim-bookmark'
"mm 建立书签
"mp 到达上一个书签
"mn 到达下一个书签
"ma 删除所有书签
":VbookmarkGroup 当此命令不带参数时，表示列出当前所有的书签组。此命令后可
"以接上书签组名，如果此名称存在，则打开对应的书签组，如果此名称不存在，则新建
"一个书签组
":VbookmarkGroupRemove 当此命令不带参数时，表示移除当前的书签组。此命令后
"可以接上书签组名，如果此名称存在，则移除对应的书签组
" 设置保存书签的文件
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'

"状态栏增强展示
Bundle 'Lokaltog/vim-powerline'
"if want to use fancy,need to add font patch -> git clone git://gist.github.com/1630581.git ~/.fonts/ttf-dejavu-powerline
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'


"括号显示增强
Bundle 'kien/rainbow_parentheses.vim'
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

"主题 solarized
"Bundle 'altercation/vim-colors-solarized'
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"

"主题 molokai
Bundle 'tomasr/molokai'
let g:molokai_original = 1

"################### 快速移动 ###################"

"更高效的移动 <leader><leader>+ w/fx
",,+w 跳转 ,,+fx 快速跳转定位到某个字符位置
Bundle 'Lokaltog/vim-easymotion'
" link color for vim-easymotion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

"%匹配成对的标签，跳转
Bundle 'vim-scripts/matchit.zip'

"################### 补全及快速编辑 ###################"

"迄今为止用到的最好的自动VIM自动补全插件
Bundle 'Valloric/YouCompleteMe'
"具体配置内容请参考该项目的github主页
"youcompleteme  默认tab  s-tab 和自动补全冲突
",gd 高亮选中的函数 仅c-family语言有效
let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments = 1 "default value is 0
let g:ycm_complete_in_strings = 1 "as default
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_blacklist = {
    \ 'unite' : 1,
    \ 'notes' : 1,
    \}
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
nnoremap <leader>bc :YcmDiags<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType python setlocal completeopt-=preview
autocmd FileType cpp setlocal completeopt-=preview

"快速插入代码片段
Bundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
"定义存放代码片段的文件夹 .vim/snippets下
"，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["ultisnips", "bundle/UltiSnips/UltiSnips"]
"定义使用的python版本，为2.x
let g:UltiSnipsUsePythonVersion = 2
"username and user_email
let g:snips_author = "spacewander"
let g:snips_author_email = "spacewanderlzx@gmail.com""

"for Doxygen
"Bundle 'NsLib/vim-DoxygenToolkit-mod'

"快速 加减注释
"<leader>cc 加上注释
"<leader>cu 解开注释
"<leader>ci 加上/解开注释
Bundle 'scrooloose/nerdcommenter'
"imap <c-c> <Plug>NERDCommenterInsert

"快速加入修改环绕字符
"Bundle 'tpope/vim-surround'

"自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType ruby let b:delimitMate_quotes = "\" ' ` |"
au FileType html let b:delimitMate_matchpair = "(:),[:],{:},{%:%}"
"for code alignment
",f=/:/, 按相应的符号切分格式化
"Bundle 'godlygeek/tabular'
"nnoremap <Leader>f= :Tabularize /=<CR>
"vnoremap <Leader>f= :Tabularize /=<CR>
"nnoremap <Leader>f, :Tabularize /,<CR>
"vnoremap <Leader>f, :Tabularize /,<CR>
"nnoremap <Leader>f: :Tabularize /:\zs<CR>
"vnoremap <Leader>f: :Tabularize /:\zs<CR>

"for visual selection
Bundle 'terryma/vim-expand-region'
noremap <a-v> <Plug>(expand_region_expand)
noremap - <Plug>(expand_region_shrink)

"for mutil cursor
Bundle 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"################# 具体语言语法检查 ###############

" 编辑时自动语法检查标红, vim-flake8目前还不支持,所以多装一个
" 使用pyflakes,速度比pylint快
Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_cpp_compiler_options = ' -std=c++11 '
highlight SyntasticErrorSign guifg=white guibg=black

"################# 具体语言补全 ###############
"FOR HTML
" 著名的vim上的html简记法撰写插件，内容丰富而复杂，建议到官网上学习具体用法
Bundle 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<leader>.'
let g:use_emmet_complete_tag = 1
" for xml and html
Bundle 'othree/xml.vim'
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
Bundle 'vim-scripts/a.vim'
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

" for python.vim syntax highlight
"Bundle 'hdima/python-syntax'
let python_highlight_all = 1
" for markdown
"Bundle 'plasticboy/vim-markdown'
"let g:vim_markdown_folding_disabled=1
Bundle 'hughbien/md-vim'
autocmd BufWinEnter *.markdown set filetype=md
autocmd BufWinEnter *.md set filetype=md

" for javascript
Bundle "pangloss/vim-javascript"
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:javascript_enable_domhtmlcss = 1
" for css
Bundle "gorodinskiy/vim-coloresque"
autocmd FileType html set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType css set tabstop=2 shiftwidth=2 expandtab ai

"################### 其他 ###################"
" task list
Bundle 'vim-scripts/TaskList.vim'
noremap <leader>td <Plug>TaskList

" for git 尚未用起来
"Bundle 'tpope/vim-fugitive'

"edit history, 可以查看回到某个历史状态
Bundle 'sjl/gundo.vim'
nnoremap <leader>ud :GundoToggle<CR>

" end turn on
filetype plugin indent on

"========================== config for plugins end ======================================
colorscheme molokai
"colorscheme desert
" settings for kien/rainbow_parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"}}}

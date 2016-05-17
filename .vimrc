
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set backupdir=~/vimbackupfile
"设置备份文件后缀，默认是~
set backupext=.bak
"设置修改原始文件时保留一个原始文件备份
"set patchmode=.origin_bak
set history=200	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  "set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"每当我们保存文件的改动时，都会调用ctags对整个代码库进行更新索引操作
"  autocmd BufWritePost * call system("ctags -R")
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif




syntax on
" 语法高亮

 autocmd InsertLeave * se nocul
 autocmd InsertEnter * se cul
" " 用浅色高亮当前行

 set smartindent
 " 智能对齐

 set confirm
 " 在处理未保存或只读文件的时候，弹出确认

 set tabstop=4
 " tab键的宽度

 set softtabstop=4
 set shiftwidth=4
 "  统一缩进为4

 set noexpandtab
 " 不要用空格代替制表符

 set number
 " 显示行号

 "set hlsearch
 set incsearch
 " 搜索逐字符高亮

" set gdefault
 " 行内全部替换

 set encoding=utf-8
 set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1
 " 编码设置
 colorscheme molokai
let g:molokai_original = 1
 " 设置颜色主题

 set guifont=menlo:h18
 " 设置字体

 set langmenu=zn_cn.utf-8
 set helplang=cn
 " 语言设置

 set cmdheight=2
 " 命令行（在状态行）的高度，默认为1,这里是2

 set laststatus=2
 " 总是显示状态行

 set scrolloff=3
 " 光标移动到buffer的顶部和底部时保持3行距离

 set showmatch
 " 高亮显示对应的括号

 set matchtime=5
 " 对应括号高亮的时间（单位是十分之一秒）

 set autowrite
 " 在切换buffer时自动保存当前文件

 set wildmenu
 " 增强模式中的命令行自动完成操作

 set linespace=2
 " 字符间插入的像素行数目

 set whichwrap=b,s,<,>,[,]
 
 "开启Normal或Visual模式下Backspace键，空格键，左方向键，右方向键，Insert或replace模式下左方向键，右方向键跳行的功能。

 filetype plugin indent on
 " 分为三部分命令：file on, file plugin on, file indent  on.分别表示自动识别文件类型，用文件类型脚本，使用缩进定义文件。

 "==================自定义的键映射======================

 vnoremap $1 <esc>`>a)<esc>`<i(<esc>
 vnoremap $2 <esc>`>a]<esc>`<i[<esc>
 vnoremap $3 <esc>`>a}<esc>`<i{<esc>
 vnoremap $$ <esc>`>a"<esc>`<i"<esc>
 vnoremap $q <esc>`>a'<esc>`<i'<esc>
 vnoremap $e <esc>`>a"<esc>`<i"<esc>
 " 括号自动生成

 map <F7> :if exists("syntax_on") <BAR>
 \    syntax off <BAR><CR>
 \  else <BAR>
 \syntax enable <BAR>
 \  endif
 " 单键<F7>控制syntax on/off。原因是有时候颜色太多会妨碍阅读。

 map <F5> :call CompileRunGcc()<CR>
 func! CompileRunGcc()
 exec "w"
 exec "!gcc % -o %<"
 exec "! ./%<"
 endfunc
 " <F5>编译和运行C程序

 map <F6> :call CompileRunGpp<CR>
 func! CompileRunGpp()
 exec "w"
 exec "!g++ % -o %<"
 exec "! ./<"
 endfunc
 " <F6>编译和运行C++程序

 " Don't write backup file if vim is being called by "crontab -e"
 au BufWrite /private/tmp/crontab.* set nowritebackup
 " Don't write backup file if vim is being called by "chpass"
 au BufWrite /private/etc/pw.* set nowritebackup
 execute pathogen#infect()
 map <C-n> :NERDTreeToggle<CR>

"命令映射 加入配置后
"在vim的命令行提示符后输入%%时，它就会被自动展开为活动缓冲区所在目录的路径，就像你输入了%:h<tab>一样。
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'
highlight Visual term=reverse ctermbg=030 guibg=#403D3D

"激活后可在配对的关键词之间转跳
runtime macros/matchit.vim

"设置VIM状态栏 
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏) 
set statusline= 
set statusline+=%2*%-3.3n%0*\  "buffernumber 
set statusline+=%F\ " file name 
set statusline+=%h%1*%m%r%w%0* " flag 
set statusline+=%= " right align 
set statusline+=[ 
if v:version >= 600 
	set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype 
	set statusline+=%{&fileencoding}, " encoding 
endif 
set statusline+=%{&fileformat}]\ \  " file format 
"set statusline+=0x%-8B\ " current char 
set statusline+=%-10.(%l,%c%V%)\ %<%P " offset 
"disable the folding configuration
let g:vim_markdown_folding_disabled=1

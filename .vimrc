set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Markdown 插件
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_emphasis_multiline = 0

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"开启所有模式下对鼠标的支持
set mouse=a
"设置后，切换缓冲区将自动把未保存的缓冲区设为隐藏
set hidden
"配置启动时自动加载matchit插件
runtime macros/matchit.vim
"启动zsh风格的自动补全菜单
set wildmenu
set wildmode=full
"激活该选项会让vim根据已在查找域中输入的文本，预览第一处匹配。
set incsearch 
"支持显示256色
set t_Co=256 
"让>和<命令正常工作
set shiftwidth=4 softtabstop=4  expandtab
syntax on
colorscheme molokai
"If you prefer the scheme to match the original monokai background color, put
"this in your .vimrc file:
"let g:molokai_original = 1
"There is also an alternative scheme under development for color terminals
"which attempts to bring the 256 color version as close as possible to the the
"default (dark) GUI version. To access, add this to your .vimrc:
let g:rehash256 = 1
"可视模式选中内容背景
highlight Visual ctermbg=39 ctermfg=0 
"匹配括号颜色
highlight MatchParen  ctermbg=0 ctermfg=196,bold 
"高亮当前行
set cursorline
hi CursorLine   cterm=NONE ctermbg=236
"高亮当前列
"set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"设置命令历史数量
set history=200
"开启自动缩进
set autoindent
"智能缩进，适合程序语言
set smartindent
"显示行号 set number 
set nu
"给命令映射快捷键
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
"给<Ctrl-l>增加暂时关闭查找高亮的功能
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l> 
"当在vim命令行提示符后输入 %% 时，它就会自动展开为活动缓冲区所在的目录的路径
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"将f5映射成开启与关闭粘贴选项的开关
set pastetoggle=<f5>
"搜索时智能决定是否区分大小写
set smartcase
"按下* 和 # 时搜索选中的文本而不是光标下的一个单词
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

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

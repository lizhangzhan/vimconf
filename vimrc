"File: .vimrc
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Download google_python_style.vim and put it in ~/.vim/indent
" curl -fLo ~/.vim/indent/python.vim --create-dirs  \
"   https://raw.githubusercontent.com/google/styleguide/gh-pages/google_python_style.vim
" Gotta be first

call plug#begin('~/.vim/plugged')

" 颜色主题
Plug 'tomasr/molokai'
Plug 'google/vim-colorscheme-primary'

" 快速补全
Plug 'vim-scripts/AutoComplPop'

" ---- vim as IDE --------
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'NLKNguyen/copy-cut-paste.vim'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" nerdtree 文件导航
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'

" 检查程序语法错误
"Plug 'scrooloose/syntastic'
Plug 'vim-syntastic/syntastic'

" 自动生成tag 文件
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
Plug 'ludovicchabant/vim-gutentags'

" tag list
Plug 'vim-scripts/taglist.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/c.vim'

" [bookmark]
" mm - 添加书签,  mx - 删除所有书签
" mn - next书签,  mp - previous书签, ma - all书签
Plug 'MattesGroeger/vim-bookmarks'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'

" working with git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'

" ---- man pages, tmux ------
Plug 'jez/vim-superman'
Plug 'Raimondi/delimitMate'

"安装此插件解决macvim下没有加号寄存器的问题。
Plug 'kana/vim-fakeclip'
Plug 'terryma/vim-multiple-cursors'

" language support
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'

" python document support
Plug 'vim-scripts/pydoc.vim'

Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'
Plug 'maksimr/vim-jsbeautify'

call plug#end()

" ----- scrooloose/syntastic 设置 -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

augroup mySyntastic
  au!
  au FileType tex,python let b:syntastic_mode = "passive"
augroup END
" manual invocation: \ + c
nmap <silent> <leader>c :SyntasticCheck<CR>

" ------ autocomplpop 设置
let g:AutoComplPop_IgnoreCaseOption=1
set ignorecase
let g:acp_behaviorKeywordCommand="\<C-n>"

" ------ NERDTreetagbar 设置
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:NERDTreeWinSize = 35
let g:tagbar_width=20
nmap <silent> <leader>n :NERDTree<CR>

" ----- xolox/vim-easytags 设置 -----
" Where to look for tags files
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
set tags=./tags;,~/.vimtags

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" ----- majutsushi/tagbar settings -----
"  " Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>

" google style colorscheme
syntax enable
set t_Co=256
set background=dark
colorscheme primary

" ----- bling/vim-airline 设置-----
"  preconditions(MUST):
"    - Install special fonts for tmuxline
"
" Always show statusbar
set laststatus=2
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" ------ Gist设置
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'

" --------cpp 设置--------
"  buildifier:
"    - desciption: A bazel BUILD file formatter
"    - installation: brew install buildifier
"  clang-format
"    - desciption: cpp code formatter
"    - installation: brew install clang-format
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
augroup endif

" --------python 设置--------
" preconditions:
"   - pip install pylint
"   - pip install yapf

" Enable syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1


" 基本设置
set encoding=utf-8
set fileencoding=utf-8
set backspace=eol,start,indent
set fileencodings=ucs-bom,utf-8,chinese
set ambiwidth=double
set wrap "自动换行
set hlsearch " 搜索高亮
set nobackup " 无备份
set nowritebackup
set textwidth=100

" 语法高亮
syntax enable
syntax on
set number
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set listchars=tab:>\ ,eol:¬
set fileformat=unix

" ------ usecase 设置--------
" trim trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

"在mac下iterm终端标题中中显示文件名称
autocmd BufEnter *.* exe 'silent ! echo -ne "\033];%:t\007"'

" file-type based indentation
filetype plugin indent on

" for different programing language files setting
autocmd FileType c,cc,cpp,hpp,h setlocal shiftwidth=2 tabstop=2

" share clipboard in macOS
set clipboard=unnamed
set lazyredraw " to avoiding scrolling problems

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" ------ shortcut设置 ------
" 调整窗口大小
" lead 键=\, 使用\>, \<快捷键调整窗口大小
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) - 10)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) + 10)<CR>
nnoremap <buffer> H :<C-u>execute "!pydoc " . expand("<cword>")<CR>

" 复制，粘贴，剪贴, ctrl+v ctrl+x (可视化模式)
vmap <C-V> "+pa
vmap <C-C> "+y
vmap <C-X> "+x

"ctrl+s为保存
map <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>

"使用tab切换window
map <C-i> :tabn <CR><CR>

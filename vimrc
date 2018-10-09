" File: .vimrc
" Author: lizhangzhan <lizhangzhan@outlook.com>
" Download plug.vim and put it in ~/.vim/autoload
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Gotta be first

call plug#begin('~/.vim/plugged')

" 颜色主题
Plug 'tomasr/molokai'
Plug 'altercation/solarized'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'

" 快速补全
Plug 'quark-zju/vim-cpp-auto-include'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/taglist.vim'

" ---- vim as IDE --------
Plug 'junegunn/vim-easy-align'
Plug 'NLKNguyen/copy-cut-paste.vim'

" nerdtree 文件导航
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'

" 检查程序语法错误
Plug 'scrooloose/syntastic'

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

" scala support
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'

call plug#end()

" ----- scrooloose/syntastic 设置 -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

"autocomplpop 设置
let g:AutoComplPop_IgnoreCaseOption=1
set ignorecase
let g:acp_behaviorKeywordCommand="\<C-n>"

"设置NERDTreetagbar的宽度
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:NERDTreeWinSize = 35
let g:tagbar_width=20

"快捷键设置 \n
nmap <silent> <leader>n :NERDTree<CR>

" ----- xolox/vim-easytags 设置 -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

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

"颜色主题设置
"set t_Co=256

let g:solarized_termcolors=16
" 两种流行风格的主题
colorscheme molokai
set background=dark
" colorscheme solarized
"set background=light

" ----- bling/vim-airline 设置-----
" Always show statusbar
set laststatus=2
" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

"Gist设置
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'


" --------python 设置--------

" Indent Python in the Google way.
setlocal indentexpr=GetGooglePythonIndent(v:lnum)
let s:maxoff = 50 " maximum number of lines to look backwards.

" automatically remove all trailing whitespace
autocmd FileType c,cc,cpp,hpp,java,python,cython,scala autocmd BufWritePre <buffer> :%s/\s\+$//e
" autocmd BufWritePre *.py[x|d]? :%s/\s\+$//e

function GetGooglePythonIndent(lnum)
  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction
" cython
"set tlist_pyrex_settings='python;c:classe;m:memder;f:function'

" Enable syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1
set mouse=a
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

" 多行缩进
vnoremap <Tab> >
vnoremap <S-Tab> <

" shift+tab 展开代码片段
imap <S-TAB> <Plug>snipMateNextOrTrigger

"在mac下iterm终端标题中中显示文件名称
autocmd BufEnter *.* exe 'silent ! echo -ne "\033];%:t\007"'

" 调整窗口大小
" lead 键=\, 使用\>, \<快捷键调整窗口大小
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) - 10)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) + 10)<CR>

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
set textwidth=80

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

" other
set lazyredraw " to avoiding scrolling problems

" 复制，粘贴，剪贴, ctrl+v ctrl+x (可视化模式)
vmap <C-V> "+pa
vmap <C-C> "+y
vmap <C-X> "+x
"ctrl+s为保存
map <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>

"使用tab切换window
map <C-i> :tabn <CR><CR>

" file-type based indentation
filetype plugin indent on
autocmd FileType c,cc,cpp,hpp,h,python,cython setlocal shiftwidth=2 tabstop=2

" share clipboard in macOS 
set clipboard=unnamed

" fix the issue that save scala file slow,
" https://github.com/scrooloose/syntastic/issues/1223
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": [],
                           \ "passive_filetypes": ["scala"] }

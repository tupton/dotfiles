" Manage multiple buffers
set hidden

" Use the file's name in the title
set title

" No annoying beep
set visualbell

" Turn on syntax highlighting
syntax on

" Background, colorscheme, etc
set background=dark

" Utility features
set ruler
set number
set cursorline
set history=1000
set nocp

" Set the terminal font encoding
set encoding=utf-8
set termencoding=utf-8

" Turn plugin features on
filetype on
filetype plugin on
filetype indent on
set autoindent
set showmatch

" Bash-like tab completion
set wildmenu
set wildmode=list:longest

" Mouse options
"set mouse=a
"set mousemodel=popup

" Spacing and tabbing
set expandtab
set smarttab
set softtabstop=2
set shiftwidth=2
set tabstop=2
set textwidth=80
set nowrap

" Scrolling context
set scrolloff=3

" Set leader to ,
let mapleader = ","

" Scrolling speed
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Filetype-specific formatting
set formatoptions+=t,c,r,o,n

au FileType c,cpp,h set cindent formatoptions+=ro noexpandtab
au FileType c set omnifunc=ccomplete#Complete noexpandtab
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType html,xhtml,xml set omnifunc=htmlcomplete#CompleteTags tw=0
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType make set noexpandtab shiftwidth=8
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType python set omnifunc=pythoncomplete#Complete et sw=4 sts=4 ts=4 ai
au FileType ruby set omnifunc=rubycomplete#Complete
au FileType tex SPCheck
au FileType tex let dialect='US'
au Syntax {cpp,c,idl} runtime syntax/doxygen.vim

au BufRead,BufNewFile PKGBUILD set ts=2 sts=2 et sw=2
au BufNewFile,BufRead .Xdefaults* set filetype=xdefaults

" Tabs
nnoremap <silent> <F5> :tabnew<CR>
nnoremap <silent> <F6> :tabp<CR>
nnoremap <silent> <F7> :tabn<CR>

" Toggle whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Completion
inoremap <Nul> <C-x><C-p>

" Status line settings
set laststatus=2
set statusline=%-3.3n\ %f%(\ %r%)%(\ %#WarningMsg#%m%0*%)%=(%l/%L,\ %c)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y
set shortmess+=aI

hi StatusLine term=inverse cterm=NONE ctermfg=white ctermbg=black
hi StatusLineNC term=none cterm=NONE ctermfg=darkgray ctermbg=black

" Folding
if has("folding")
    set foldenable 
    set foldmethod=indent 
    set foldlevel=100 
    set foldopen-=search
    set foldopen-=undo
endif

hi Folded term=standout ctermfg=3 ctermbg=0

" Searching & Replacing
set nohlsearch
set ignorecase
set smartcase
set incsearch

" Enable extended % matching
runtime macros/matchit.vim

" Taglist settings
let Tlist_Process_File_Always = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Max_Tag_Length = 35
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 40

" OmniCPPComplete settings
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 0
let OmniCpp_SelectFirstItem = 0


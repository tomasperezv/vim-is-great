" ------------------------------------------------------------------------------
" Vim
" My .vimrc file.
" @author tom@0x101.com
" @see https://github.com/tomasperezv/vim-is-great
"
" - Changelog
" 2014-03-15 version 0.1.1 Full rewrite from the scratch.
" 2015-10-25 version 0.2 Repo moved to a separate project.
"
" - Structure:
" 1) CUSTOM FUNCTIONS
" 2) GENERAL VIM CONFIGURATION
" 3) PLUGINS CONFIGURATION
"
" - Comments syntax
" @plugin [PLUGIN NAME] -> begin of configuration for a plugin
" @shortcut [SHORTCUT] -> keyboard shortcut definition
" @see [URL]
" ------------------------------------------------------------------------------

" ==============================================================================
" CUSTOM FUNCTIONS
" ==============================================================================
function PHPDebug()
  :VdebugStart
  :!php -d xdebug.remote_autostart=On -d xdebug.idekey=VIM -d xdebug.remote_host=localhost %:p
endfunction

" ==============================================================================
" GENERAL VIM CONFIGURATION
" ==============================================================================
set fileformat=unix

" Set encoding to UTF8 without Byte Order Mark.
" The BOM is a Unicode char used to signal the endianness or byte order of a
" text file or a stream. BOM is optional.
set encoding=utf-8 nobomb

" Autoreload .vimrc automatically when it's saved.
au! BufWritePost .vimrc source %

" Display line numbers by default
set number

" Display the status line always
set laststatus=2

" Eliminating delays on ESC
set ttimeoutlen=50

" By default, searching starts after you enter the string. With this option set,
" incremental searches will be done.
set incsearch

" Any search highlights the string matched by the search.
set hlsearch

" Each new line will be automatically indented the correct amount according to
" the C indentation standard.
" set cindent

" Indentation for Javascript
autocmd FileType javascript setlocal ts=2 sw=2 expandtab smartindent
autocmd FileType html setlocal ts=2 sw=2 expandtab smartindent
autocmd FileType css setlocal ts=2 sw=2 expandtab smartindent
autocmd FileType handlebars setlocal ts=2 sw=2 expandtab smartindent

" Indentation for PHP
autocmd FileType php set sw=4 ts=4 smarttab autoindent smartindent copyindent

" Indentation for less
au BufNewFile,BufRead *.less set filetype=css

" show a full list when hitting tab
" looking for files.
set wildmode=list:longest,full

" show tab chars with ...>
set list listchars=tab:»·,trail:·

" Come back to the same location after editing
" If you exit Vim and later start it again, you would normally lose a lot of
" information.  The viminfo file can be used to remember that information.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='10,\"100,:20,%,n~/.viminfo

" Put the swp file in a tmp directory.
set directory=~/.vim/tmp

" @shortcut %
noremap % v%

" Strips off two full keystrokes from almost every Vim command.
nnoremap ; :

" Set show matching parenthesis.
set showmatch

" Turn off auto indenting for text pasting.
"set paste

" Ignore case when searching.
set ignorecase

" Clearing highlighted searches.
" @shortcut ,/
nmap <silent> ,/ :nohlsearch<CR>

" Ignores files matching the pattern when using |wildcards| in Ex-commands that
" take a filename, or in expand(), glob() and globpath().
set wildignore=*.swp,*.bak,*.pyc,*.class,*.git
set wildignore+=.*

" @shortcut ,u
" underscore to camel case
" http://vim.wikia.com/wiki/CamelCase_to_under_lined_and_vice_versa
" Change selected text from NameLikeThis to name_like_this.
vnoremap ,u :s/\<\@!\([A-Z]\)/\_\l\1/g<CR>gul

" @shortcut ,c
" Change selected text from name_like_this to NameLikeThis.
vnoremap ,c :s/_\([a-z]\)/\u\1/g<CR>gU

" Syntax highlighting
set t_Co=256
syntax on

" Dark background and light foreground
set background=dark

" Make <C-A> and <C-X> increment and decrement all numbers as decimals.
set nrformats=

" Disable error bells.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" @shortcut <C-a>
" Increment current selected number.

" @shortcut <C-x>
" Decrement current selected number.

" ==============================================================================
" PLUGINS
" ==============================================================================

" ******************************************************************************
" pathogen
"
" pathogen.vim makes it super easy to install plugins and runtime files in their
" own private directories.
" @see https://github.com/tpope/vim-pathogen
" @plugin pathogen
" ******************************************************************************

execute pathogen#infect()
syntax on
filetype plugin indent on
execute pathogen#helptags()

" Omni completion is not enabled by default.
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Color scheme is active only after pathogen is active.
colorscheme distinguished

" ******************************************************************************
" NERDtree
"
" The NERD tree allows you to explore your filesystem and to open files and
" directories.
" @see https://github.com/scrooloose/nerdtree
" @plugin NERDtree
" ******************************************************************************

" Open NERD Tree automatically when vin starts up, if no files were specified
" autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" @shortcut <C-t>
" Shortcut to open NERDTree
map <C-t> :NERDTreeToggle<CR>

" @shortcut :bp
" NERDtree doesn't offer a way to move to the previous opened file.

" @shortcut <SHIFT-i>
" Hidden folders and files are hidden by default, show them with this shortcut.

" @shortcut t
" NERDtree Opens the selected file in a new tab by default.

" @shortcut r
" Refresh current node.

" Strange characters in NERDTree
" @see http://superuser.com/questions/387777/what-could-cause-strange-characters-in-vim
let g:NERDTreeDirArrows=0

" ******************************************************************************
" surround
" The plugin provides mappings to easily delete, change and add such surroundings
" in pairs.
" @see https://github.com/tpope/vim-surround
" @plugin surround
" ******************************************************************************

" @shortcut cs[DELIMITER][NEW_DELIMITER]
" e.g. cs"' => will replace " by '
" It works with any delimiter, e.g. HTML

" @shortcut ds[DELIMITER]
" Remove delimiter completely.

" ******************************************************************************
" Airline
" Lean & mean status/tabline for vim that's light as air.
" @see https://github.com/bling/vim-airline
" @plugin vim-airline
" ******************************************************************************
" Enable tab lines, and display number
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" Display date and time
let g:airline_section_y = airline#section#create(['ffenc', ' ', '%{strftime("%d/%m/%y %H:%M")}'])

" ******************************************************************************
" Syntastic
" Syntax checking plugin for Vim that runs files through external syntax
" checkers and displays any resulting errors to the user.
" @see https://github.com/scrooloose/syntastic
" @plugin syntastic
" ******************************************************************************

" In active mode, syntastic does automatic checking whenever a buffer is saved or
" initially opened.  When set to "passive" syntastic only checks when the user
" calls |:SyntasticCheck|
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': ['js', 'php'],
	\ 'passive_filetypes': ['puppet'] }

let g:syntastic_php_checkers=['']
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" check for errors on file open"
let g:syntastic_check_on_open=1

" jshint
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args = "--config " . fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/jshintrc"

" ******************************************************************************
" vim-javascript
" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
" @see https://github.com/pangloss/vim-javascript
" ******************************************************************************

" Enables HTML/CSS syntax highlighting in your JavaScript file.
let g:javascript_enable_domhtmlcss = 1

" ******************************************************************************
" delimitMate
" This plug-in provides automatic closing of quotes, parenthesis, brackets, etc.
" @see https://github.com/Raimondi/delimitMate
" ******************************************************************************

" @shortcut <C-a> after opener added, insert an enter
" As example:
" 	1. type "function() {"
" 	2. it will add the closing bracket: "function() {|}"
"	3. now you can type <C-a>, it will insert the new line
imap <C-a> <CR><Esc>O

" ******************************************************************************
" tern_for_vim
" In JavaScript files, the package will hook into omni completion to handle
" autocompletion.
" @see https://github.com/marijnh/tern_for_vim
" ******************************************************************************

" Locate the .tern-project file.
let b:ternProjectDir = $HOME . "/.vim/"

" Use keyboard shorcuts.
let g:tern_map_keys = 1

" Will display argument type hints when the cursor is left over a function.
let g:tern_show_argument_hints='on_hold'

" Note: <LocalLeader> corresponds to the  key "\"
" @shortcut <LocalLeader><td>
" TernDoc

" @shortcut <LocalLeader><tt>
" TernType

" @shortcut <LocalLeader><tb>
" TernDocBrowse

" @shortcut <LocalLeader><tR>
" TernRename

" @shortcut <LocalLeader><tr>
" TernRefs

" @shortcut <C-X><C-O>
" Launch omni completion.

" @shortcut <C-N>
" With the omni completion displayed, show next match.

" @shortcut <C-P>
" With the omni completion displayed, show previous match.

" ******************************************************************************
" PHP Documentor for VIM 2
" Version 2 of PDV - PHP Documentor for VIM, your tool of choice for
" generating PHP doc blocks.
" @see https://github.com/tobyS/pdv
" ******************************************************************************

" Define the directory for the templates
let g:pdv_template_dir = $HOME ."/.vim/doc-templates"

" @shortcut <C-F7>
" Apply PHP Documentor
autocmd FileType php nmap <C-F7> :call pdv#DocumentWithSnip()<CR>

" ******************************************************************************
" Ultisnips
" The ultimate snippet solution for Vim.
" @see https://github.com/SirVer/ultisnips
" ****************************************************************************=*=n

" Customized code snippets folder
let g:UltiSnipsSnippetsDir = $HOME . "/.vim/snippets"
let g:UltiSnipsExpandTrigger="<c-j>"

" ******************************************************************************
" VDebug
" A powerful, fast, multi-language debugger for Vim
" @see https://github.com/joonty/vdebug
" @see https://github.com/joonty/vdebug/blob/master/doc/Vdebug.txt
" ******************************************************************************

" Options required in the php.ini file
" zend_extension=/path/to/xdebug.so
" xdebug.remote_enable=on
" xdebug.remote_handler=dbgp
" xdebug.remote_host=localhost
" xdebug.remote_port=9000

" @shortcut <F5>
" Run.

" @shortcut <F2>
" Step over.

" @shortcut <F3>
" Step in.

" @shortcut <F4>
" Step out.

" @shortcut <F9>
" Run to cursor, without setting a hard breakpoint.

" @shortcut <F7>
" Detach.

" @shortcut <F6>
" Stop/close.

" @shortcut <F10>
" Set/Remove breakpoint.

" Debug PHP client script
" php -dxdebug.remote_autostart=On -dxdebug.idekey=VIM -dxdebug.remote_host=localhost script.php

" Debug PHP browser script
" Pass XDEBUG_SESSION_START=VIM

" Debug the current file opened in the command line
" @shortcut <C-F5>
autocmd FileType php nmap <C-F5> exec PHPDebug()

" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;$HOME

:let g:syntastic_loc_list_height=5

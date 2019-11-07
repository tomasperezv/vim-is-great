" ------------------------------------------------------------------------------
" Vim
" My .vimrc file.
" @author tom@0x101.com
" @see https://github.com/tomasperezv/vim-is-great
"
" - Changelog
" 2014-03-15 version 0.1.1 Full rewrite from the scratch.
" 2015-10-25 version 0.2 Repo moved to a separate project.
" 2015-11-21 version 0.3 Javascript snippets moved to a separate module.
" 2018-05-05 version 0.4 Replacing syntastic by Ale
"
" - Structure:
" 1) CUSTOM FUNCTIONS
" 2) GENERAL VIM CONFIGURATION
" 3) PLUGINS CONFIGURATION
"
" - Comments annotations syntax
" @plugin [PLUGIN NAME] -> begin of configuration for a plugin
" @shortcut [SHORTCUT] -> keyboard shortcut definition
" @see [URL]
" @command [COMMAND NAME] -> represents a command e.g. 'retab'
" ------------------------------------------------------------------------------

" ==============================================================================
" VARIABLES
" ==============================================================================
let working_folder=fnamemodify(resolve(expand('<sfile>:p')), ':h')

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

" Auto save on focus lost
au FocusLost * silent! :w

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
autocmd FileType erb setlocal ts=2 sw=2 expandtab smartindent
autocmd FileType html.erb setlocal ts=2 sw=2 expandtab smartindent
autocmd FileType css setlocal ts=2 sw=2 expandtab smartindent

" Fix indentation
nmap <C-I> :setlocal ts=2 sw=2 expandtab smartindent<CR>

" Indentation for less
au BufNewFile,BufRead *.less set filetype=css

" Auto format
au BufRead,BufNewFile *.txt setlocal formatoptions=atql textwidth=72 wrapmargin=0 breakat=^I!@*-+;:,./?

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

" Start scrolling when we're 8 lines away from margins
set scrolloff=3
set sidescrolloff=5
set sidescroll=1

" ==============================================================================
" Completion
" @see http://vim.wikia.com/wiki/Great_wildmode/wildmenu_and_console_mouse
" ==============================================================================

" Show a full list when hitting tab looking for files
set wildmode=list:longest,full

" Enables a menu at the bottom of the vim window
set wildmenu

" File matching patterns that are ignored in wildcards (filenames, expand, glob and globpath)
set wildignore=*.swp,*.bak,*.pyc,*.class,*.git
set wildignore+=*.png,*.jpg,*.gif
set wildignore=*.o,*.obj,*~
set wildignore+=*sass-cache*
set wildignore+=node_modules/**
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem

" ==============================================================================
" COMMANDs
" ==============================================================================

" @command retab
" Convert current file to new tab settings (e.g. tabs to spaces)

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
syntax enable
filetype plugin indent on
execute pathogen#helptags()

" Omni completion is not enabled by default.
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Color scheme is active only after pathogen is active.
colorscheme distinguished

" ******************************************************************************
" deoplete
"
" @see https://github.com/Shougo/deoplete.nvim
" @plugin deoplete
" ******************************************************************************

" Use deoplete.
let g:deoplete#enable_at_startup = 1

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

" Open NerdTree by default if no file specified
" @see http://stackoverflow.com/questions/1759737/auto-open-nerdtree-in-vim
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()

" @shortcut <C-t>
" Shortcut to open NERDTreeTabs
map <C-t> :NERDTreeTabsToggle<CR>

" @shortcut :bp
" NERDtree doesn't offer a way to move to the previous opened file.

" @shortcut <SHIFT-i>
" Hidden folders and files are hidden by default, show them with this shortcut.

" @shortcut t
" NERDtree Opens the selected file in a new tab by default.

" @shortcut r
" Refresh current node.

" @shortcut i
" Open selected file in a new horizontal split
" Note: use g as in gi for preview split

" @shortcut s
" Open selected file in a new vertical split
" Note: use g as in gs for preview split

" @shortcut I
" Open Toggle hidden files
"

" @shortcut T
" Open New tab silently

" @shortcut A
" Maximize NERDTree

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

" Show only tabs, not buffers
let g:airline#extensions#tabline#show_buffers = 0

" Display date and time
let g:airline_section_y = airline#section#create(['ffenc', ' ', '%{strftime("%d/%m/%y %H:%M")}'])

" ******************************************************************************
" Ale
" Syntax checking plugin for Vim that runs files through external syntax
" checkers and displays any resulting errors to the user.
" @see https://github.com/w0rp/ale
" @plugin ale
" ******************************************************************************

" Enable completion where available.
let g:ale_completion_enabled = 1

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
" vim-flow
" @see https://github.com/flowtype/vim-flow
" ******************************************************************************
let g:flow#enable = 0

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
let g:pdv_template_dir = working_folder ."/vim/doc-templates"

" ******************************************************************************
" Ultisnips
" The ultimate snippet solution for Vim.
" @see https://github.com/SirVer/ultisnips
" ****************************************************************************=*=n

" Customized code snippets folder
let g:UltiSnipsSnippetDirectories=[working_folder.'/vim/snippets/src/']
let g:UltiSnipsExpandTrigger="<c-j>"

" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

" ******************************************************************************
" Integration with ag
"
" A code-searching tool similar to ack, but faster
" @see https://github.com/ggreer/the_silver_searcher
" ******************************************************************************
let g:ackprg="ag --vimgrep"

" ******************************************************************************
" Notes
" ******************************************************************************
function! Notes()
  let id = input('Enter file id: ')
  call inputsave()
  call inputrestore()
  let filename = strftime("%Y%m%d") . '_' . id . '.gpg'
  execute "e " . filename
endfunction

" ******************************************************************************
" Update encrypted files with last edition date
" ******************************************************************************
function! AppendLastMod()
  let l = line('$')
  call append(l, ["", "", strftime("Created at %Y-%m-%d %H:%M:%S"), "******************************", ""])
  1,$ ! gpg --armor --symmetric --no-use-agent --yes --cipher-algo AES256 2>/dev/null
endfunction

" ******************************************************************************
" Encryption
"
" @see https://github.com/tomasperezv/vimcrypt
" ******************************************************************************
set cryptmethod=blowfish

" Transparent editing of gpg files for symmetric encryption.
" Forked and modified from an original implementation by Wouter Hanegraaff.
" @see http://vim.wikia.com/wiki/Encryption
augroup encrypted
  au!

  " Avoid writing to ~/.viminfo while editing
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt --no-use-agent 2> /dev/null
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Encrypt text before writing
  autocmd BufWritePre,FileWritePre *.gpg  ks|call AppendLastMod()|'s
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

" ******************************************************************************
" Open tag under cursor in new tab
" @see http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
" @shortcut <C-\>
" ******************************************************************************
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>"

" ******************************************************************************
" Easy tags
" @see https://github.com/xolox/vim-easytags
" ******************************************************************************
"let g:easytags_opts = ["--options=" . working_folder . "/ctags"]

" Use jsctags for javascript files
" @see https://github.com/xolox/vim-easytags/issues/92
let g:easytags_languages = {
\   'javascript': {
\     'cmd': working_folder . "/node_modules/jsctags/bin/jsctags",
\     'args': [],
\     'fileoutput_opt': '-f',
\     'stdout_opt': '-f-',
\     'recurse_flag': '-R'
\   },
\   'php': {
\     'cmd': working_folder . "/bin/ctags",
\     'args': ['-R'],
\     'recurse_flag': '-R'
\   }
\}

let g:easytags_cmd = '/usr/bin/ctags'
let g:easytags_file = "vim_easytags"
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_events = ['BufWritePost', 'BufReadPost']
set tags=./vim_easytags,tags;$HOME

" *****************************************************************************
" Make sure vitality is always enabled and works with terminator
" *****************************************************************************
let g:vitality_always_assume_iterm = 1

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

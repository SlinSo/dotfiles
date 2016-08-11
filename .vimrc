set autowrite

" Load Plugins
call plug#begin()
Plug 'fatih/vim-go'                 " go for vim
Plug 'fatih/molokai'                " colorscheme
Plug 'AndrewRadev/splitjoin.vim'    " format strucs
Plug 'SirVer/ultisnips'             " snippets
Plug 'ctrlpvim/ctrlp.vim'           " easy navigation
Plug 'rbgrouleff/bclose.vim'        " close buffer without vim
Plug 'mileszs/ack.vim'              " fast searching
Plug 'jlanzarotta/bufexplorer'      " some buffer enhancements
Plug 'tpope/vim-fugitive'           " git for vim
Plug 'tpope/vim-surround'           " surround everything
Plug 'gregsexton/gitv'              " see commits that lead to that code
Plug 'godlygeek/tabular'            " align code
Plug 'majutsushi/tagbar'            " code explorer
Plug 'easymotion/vim-easymotion'    " easy text navigation
Plug 'scrooloose/nerdcommenter'     " multi line commenting
Plug 'scrooloose/nerdtree'          " file explorer
Plug 'Shougo/neocomplete.vim'       " autocomplete
Plug 'jiangmiao/auto-pairs'         " auto complete pairs
Plug 'terryma/vim-multiple-cursors' " sublime multi cursor
call plug#end()

" Settings for ack.vim to use ag instead
let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack

"bufexplorer commands: be, bt, bs, bv
" vim-multiple-cursos
	let g:multi_cursor_next_key='<C-n>'
	let g:multi_cursor_prev_key='<C-p>'
	let g:multi_cursor_skip_key='<C-x>'
	let g:multi_cursor_quit_key='<Esc>'
	
	" Called once right before you start selecting multiple cursors
	function! Multiple_cursors_before()
	  if exists(':NeoCompleteLock')==2
	      exe 'NeoCompleteLock'
	  endif
	endfunction
	" Called once only when the multiple selection is canceled (default <Esc>)
	function! Multiple_cursors_after()
	    if exists(':NeoCompleteUnlock')==2
	       exe 'NeoCompleteUnlock'
		endif
	endfunction
" }}


" Nerdtree {{
	map <C-t> :NERDTreeToggle<CR>
" }}

" tagbar {{
	nmap <F8> :TagbarToggle<CR>
"	let g:tagbar_autofocus = 1
"   let g:tagbar_autoclose = 1
	let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
	\ }
" }}

" CTRL P {{
	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'
	nnoremap <silent> <D-t> :CtrlP<CR>
	nnoremap <silent> <D-r> :CtrlPMRU<CR>
	let g:ctrlp_custom_ignore = {
	    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
	    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
	let g:ctrlp_user_command = {
	      \ 'types': {
	          \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
	          \ 2: ['.hg', 'hg --cwd %s locate -I .'],
	          \ },
	      \ 'fallback': 'ag %s --nocolor -l -g ""'
	\ }
" }}

" NeoComplete
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	 let g:neocomplete#sources#dictionary#dictionaries = {
	     \ 'default' : '',
         \ 'vimshell' : $HOME.'/.vimshell_hist',
         \ 'scheme' : $HOME.'/.gosh_completions'
     \ }

	" Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
       return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
     " For no inserting <CR> key.
     "return pumvisible() ? "\<C-y>" : "\<CR>"
     endfunction
     " <TAB>: completion.
     inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
     " <C-h>, <BS>: close popup and delete backword char.
     inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
     inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
     " Close popup by <Space>.
     "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
  
     " AutoComplPop like behavior.
     "let g:neocomplete#enable_auto_select = 1
  
     " Shell like behavior(not recommended).
     "set completeopt+=longest
     "let g:neocomplete#enable_auto_select = 1
     "let g:neocomplete#disable_auto_complete = 1
     "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
  
     " Enable omni completion.
     autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
     autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
     autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
     autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
     autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  
     " Enable heavy omni completion.
     if !exists('g:neocomplete#sources#omni#input_patterns')
       let g:neocomplete#sources#omni#input_patterns = {}
     endif
     "let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'
     "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:]*\t]\%(\.\|->\)'
     "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:]*\t]\%(\.\|->\)\|\h\w*::'

     " For perlomni.vim setting.
     " https://github.com/c9s/perlomni.vim
     let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}

" Text Formatting
	set autoindent
	set shiftwidth=4
	set tabstop=4
	set softtabstop=4
" }}

let mapleader = ","
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <silent> <leader>bd :Bclose<CR>

"run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
   let l:file = expand('%')
   if l:file =~# '^\f\+_test\.go$'
     call go#cmd#Test(0, 1)
   elseif l:file =~# '^\f\+\.go$'
     call go#cmd#Build(0)
endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
autocmd FileType go nmap <Leader>i <Plug>(go-info)


let g:rehash256 = 1
let g:molokai_original = 1

colorscheme molokai
set updatetime=100


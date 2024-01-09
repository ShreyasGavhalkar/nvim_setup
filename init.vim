:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set mouse=a
:set mouse=v
:set smarttab
:set showmatch
:set cursorline
:set clipboard=unnamedplus
:set tags=./tags,tags;$HOME

call plug#begin("~/.vim/plugged")
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox' " Theme
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf',{'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'romgrk/barbar.nvim'
"Plug 'nvim-telescope/telescope.nvim', {'tag':'0.1.1'}
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-eunuch'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'APZelos/blamer.nvim'
Plug 'rust-lang/rust.vim'
call plug#end()

autocmd vimenter * ++nested colorscheme molokai
let g:barbar_auto_setup = v:false
lua << EOF
require'barbar'.setup{
	highlight_visible = true,
	insert_at_end = true,
	animation = true,
	clickable = true,
	sidebar_filetypes = {
		-- Use the default values: {event = 'BufWinLeave', text = nil}
		NvimTree = true,
	},
}
require('nvimtree')
-- disable netrw at the very start of your init.lua
require("toggleterm").setup{
	open_mapping = [[<C-Space>]],
	autochdir = true,
}

EOF

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


"inoremap <expr><TAB> coc#pum#visible() ? coc#pum#next(1) : "\<C-K>"
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-J>"
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
nnoremap <silent> <C-t> :tabnew <CR>
nnoremap <silent> <C-Left> <Cmd>BufferPrevious<CR>
nnoremap <silent> <C-Right> <Cmd>BufferNext<CR>
nnoremap <silent> <C-q> <Cmd>BufferClose!<CR>
nnoremap <C-A-q> <Cmd>BufferCloseAllButCurrent<CR>
nnoremap <C-f> <Cmd>NvimTreeToggle<CR>
inoremap <C-f> <Cmd>NvimTreeToggle<CR>
nnoremap <C-s> :Files <CR>
tnoremap <Esc> <C-\><C-o>
inoremap <M-Left> <C-\><C-N><C>h
inoremap <M-Down> <C-\><C-N><C-w>j
inoremap <M-Up> <C-\><C-N><C-w>k
inoremap <M-Right> <C-\><C-N><C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l
nnoremap <M-z> :set number! relativenumber! <CR>
nnoremap <M-x> :BlamerToggle <CR>
inoremap <M-x> :BlamerToggle <CR>
inoremap <silent><nowait><expr> <C-a> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-a>"
inoremap <silent><nowait><expr> <C-q> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-q>"

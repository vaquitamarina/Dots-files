set number
set mouse=a
syntax enable
set showcmd
set showmatch
set relativenumber
set noshowmode
set tabstop=4
set shiftwidth=4
"set expandtab
set sw=4
set noswapfile
autocmd BufNewFile *.cpp 0r ~/.config/nvim/plantillas/cpp.tpl

call plug#begin('~/.config/nvim/plugged')
" UI
Plug 'itchyny/lightline.vim'
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'nvim-tree/nvim-tree.lua'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim'
Plug 'marko-cerovac/material.nvim'

" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim',          " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/cmp-buffer'

Plug 'saadparwaiz1/cmp_luasnip' 

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
" Extras
Plug 'lukas-reineke/indent-blankline.nvim'


call plug#end()

" colorscheme catppuccin-mocha
" colorscheme tokyonight-moon

let g:lightline = {
  \ 'colorscheme': 'nord',
  \ }

lua << END
  require("ui")
  require('nvim-treesitter.configs').setup{highligh = true}

  --Lsp,cmp,mason config
  require("mason").setup()
  
  require("lsp")

  require("mason-lspconfig").setup()

  
  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    --window = {
      --completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },    scrollbar = false,
      --documentation = {
	--border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--scrollbar = false,
	--},
      --},
    --},

    window = {
      completion = { -- rounded border; thin-style scrollbar
	border = 'rounded',
	scrollbar = '║',
      },
      documentation = { -- no border; native-style scrollbar
	border = nil,
	scrollbar = '', -- other options
      },
    },
    mapping = {
      -- `Enter` key to confirm completion
      ['<Tab>'] = cmp.mapping.confirm({select = true}),

      -- Ctrl+Space to trigger completion menu
      ['<C-Space>'] = cmp.mapping.complete(),

      -- Navigate between snippet placeholder
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },

    sources = {
      {name = 'luasnip'},
      {name = 'nvim_lsp'},
      {name = 'buffer'},
    },
  })
  -- Identline config
  require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
  }
END

nnoremap m :NvimTreeOpen<cr>
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>


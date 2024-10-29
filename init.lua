-- initial config to call vim functions
local vim = vim
local Plug = vim.fn['plug#']

-- Plugin manager = Vim Plug -> link: https://github.com/junegunn/vim-plug
-- to install run sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim.call('plug#begin')

-- color scheme
Plug('projekt0n/github-nvim-theme') --link: https://github.com/projekt0n/github-nvim-theme
-- autocompletion 
Plug('neoclide/coc.nvim', {['branch'] = 'master', ['do'] = 'npm ci'}) --link: https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim
-- status bar
Plug('vim-airline/vim-airline')
-- icons
Plug('ryanoasis/vim-devicons')
-- syntax highlight
Plug('sheerun/vim-polyglot')
-- autopairs closing
Plug('jiangmiao/auto-pairs')
-- show css colors in the editor
Plug('ap/vim-css-color')
-- file explorer
Plug('preservim/nerdtree')
-- markdown support
Plug('plasticboy/vim-markdown')
-- highlight the git changes in the file
Plug('airblade/vim-gitgutter')

vim.call('plug#end')

-- set color scheme
vim.cmd('colorscheme github_dark_default')
-- basic config
vim.cmd('set number')
vim.cmd('set cursorline')
vim.cmd('set relativenumber')
vim.cmd('set splitbelow splitright')
vim.cmd('set title')
vim.cmd('set ttimeoutlen=0')
--vim.cmd('set wildmenu')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set hidden')
vim.cmd('set inccommand=split')
--vim.cmd('set completeopt=noinsert,menuone,noselect')
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- tab size
vim.cmd('set expandtab')
vim.cmd('set shiftwidth=2')
vim.cmd('set tabstop=2')

-- add automatic syntax support for open files
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- spell check
vim.cmd('setlocal spell spelllang=en_us')

-- color support
vim.cmd('set t_Co=256')

-- airline customization
vim.g.airline_theme = 'github_dark_default'
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions_tabline_enabled = 1

-- show hidden files in nerdtree
vim.g.NERDTreeShowHidden = 1

-- disable math text conceal feature
vim.g.text_conceal = ''
vim.g.vim_markdown_math = 1
-- markdown other settings
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_fenced_languages = {'tsx=typescriptreact'}

-- KEYMAPS
local keyset = vim.keymap.set

-- Ctrl+f to Toggle nerdtree
vim.keymap.set('n', '<C-f>', ':NERDTreeToggle %:p:h<CR>', { noremap = true })

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true`
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- Tab to select the suggestion
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- Shift-Tab to select the previous suggestion
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- Enter key to select
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

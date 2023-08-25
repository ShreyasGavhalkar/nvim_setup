vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

	api.config.mappings.default_on_attach(bufnr)
--	vim.keymap.set('n', '<C-Tab>', api.tree.toggle, opts())
end

require("nvim-tree").setup{
	on_attach = my_on_attach,
}

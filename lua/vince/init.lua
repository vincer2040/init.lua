require("vince.set")
require("vince.remap")
require("vince.lsp")

local augroup = vim.api.nvim_create_augroup
local VinceGroup = augroup('Vince', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufWritePre"}, {
    group = VinceGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

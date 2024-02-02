vim.g.mapleader = ' '

vim.keymap.set("n", "<leader>n", vim.cmd.Ex)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>ee", "iif err != nil {<CR>}<ESC>O")

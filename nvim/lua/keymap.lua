-- Save file
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Cmd>w<CR>")

-- Better move
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Remove highlight
vim.keymap.set("n", "<Leader><Space><Space>", "<Cmd>nohlsearch<CR>")

-- -- Terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>") -- Escape from terminal by ESC

-- Buffer
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>bh", vim.cmd.split)
vim.keymap.set("n", "<leader>bv", vim.cmd.vsplit)

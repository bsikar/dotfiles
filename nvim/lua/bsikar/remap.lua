vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- 1/2 page jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland (copy to clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- Have to learn
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")     -- have to learn
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")     -- have to learn
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- have to learn
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- have to learn

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>SP", ":set invpaste<cr>")
vim.keymap.set("n", "<leader>tt", ":term<cr>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "ZZ", ":vs<cr>")
vim.keymap.set("n", "zz", ":sp<cr>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Define the command mappings
local mappings = {
    ['c'] = 'clang',
    ['cpp'] = 'clang++',
    ['rs'] = 'rustc',
    ['py'] = 'python',
    -- Add more mappings for other languages as needed
}

-- Function to get the file extension
local function get_extension()
    local path = vim.fn.expand('%:p')
    return path:match('%.([^%.]+)$')
end

-- Function to run the appropriate compiler

function RunCompiler()
    local extension = get_extension()
    local command = mappings[extension]

    if command then
        local file = vim.fn.expand('%:p')
        local file_without_extension = vim.fn.expand('%:t:r') -- Get the file name without extension

        vim.cmd('!cd ' .. vim.fn.expand('%:p:h'))
        if extension == 'py' then
            vim.cmd('!python "' .. file .. '"')                                                    -- Enclose the file path in double quotes
        else
            vim.cmd('!"' .. command .. '" -o "' .. file_without_extension .. '" "' .. file .. '"') -- Enclose file paths in double quotes
            vim.cmd('!./"' .. file_without_extension .. '"')                                         -- Run the compiled file
        end
    else
        print('No compiler found for this file type.')
    end
end

-- Define the key mapping
vim.api.nvim_set_keymap('n', '<leader>ct', ':lua RunCompiler()<CR>', { noremap = true })

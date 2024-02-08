-- Define the cheatsheet contents with order
local cheatsheet = {
    { key = "<leader>a",   desc = "Add file to harpoon" },
    { key = "<C-e>",       desc = "Toggle harpoon menu" },
    { key = "<C-u>",       desc = "Move up half a page" },
    { key = "<C-h>",       desc = "Move down half a page" },
    { key = "gd",          desc = "Go to definition" },
    { key = "gD",          desc = "Go to implementation" },
    { key = "<C-k>",       desc = "Insert mode, get signature" },
    { key = "<leader>vca", desc = "Code action" },
    { key = "<leader>vrr", desc = "Code ref" },
    { key = "<leader>vrn", desc = "Rename" },
    { key = "<leader>vws", desc = "Workspace symbol" },
    { key = "<C-o>",       desc = "Go back" },
    { key = "<leader>pf",  desc = "Find files" },
    { key = "<C-p>",       desc = "Find git files" },
    { key = "<leader>ps",  desc = "Grep" },
    { key = "[c",          desc = "Go to top of context" },
    { key = "<leader>u",   desc = "Toggle undotree" },
}

function SHOW_CHEATSHEET()
    local bufnr = vim.api.nvim_create_buf(false, true)

    local max_command_length = 0
    for _, entry in ipairs(cheatsheet) do
        max_command_length = math.max(max_command_length, #entry.key)
    end

    local lines = {}
    local padding_top = 2     -- Adjust top padding as needed
    for i = 1, padding_top do -- Add padding at the top
        table.insert(lines, "")
    end

    for _, entry in ipairs(cheatsheet) do
        local command_padding = string.rep(" ", max_command_length - #entry.key)
        local line = entry.key .. command_padding .. " - " .. entry.desc
        table.insert(lines, line)
    end

    local max_line_length = 0
    for _, line in ipairs(lines) do
        max_line_length = math.max(max_line_length, #line)
    end

    local padding_left = 4                               -- Adjust left padding as needed
    for i, line in ipairs(lines) do
        lines[i] = string.rep(" ", padding_left) .. line -- Add padding at the beginning of each line
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

    local width = max_line_length + (padding_left * 2) -- Total width includes left and right padding
    local height = #lines + padding_top                -- Total height includes top and bottom padding

    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = (vim.api.nvim_get_option("columns") - width) / 2,
        row = (vim.api.nvim_get_option("lines") - height) / 2,
        anchor = "NW",
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(bufnr, true, win_opts)
    local opts = { noremap = true, silent = true }

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<ESC>', '<cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>', opts)
end

vim.api.nvim_set_keymap("n", "<leader>/", ":lua SHOW_CHEATSHEET()<CR>", { noremap = true, silent = true })

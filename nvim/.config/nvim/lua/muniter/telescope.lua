local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local builtin = require('telescope.builtin')
local M = {}

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--follow'
    },
    find_command = {
        "rg",
        "--smart-case",
        "--files",
        "--hidden",
        "--follow",
        "-g",
        "!.git/*"
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {'.git/'},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

-- Load the extensions
require('telescope').load_extension('fzy_native')

-- Mappings

vim.api.nvim_set_keymap('n', '<M-/>', [[<Cmd>lua require('telescope.builtin').find_files({ follow = true, hidden = true, file_ignore_patterns = {'.git/'} })<CR>]] , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-p>', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]] , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-;>', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]] , { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mdf', [[<Cmd>lua require('muniter.telescope').my_dotfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tb', [[<Cmd>Telescope builtin<CR>]], { noremap = true, silent = true })

-- Custom pickers.

-- My dotfiles
M.my_dotfiles = function()
    require('telescope.builtin').find_files({
        prompt_title = "dotfiles",
        cwd = "~/dotfiles",
        hidden = true,
        follow = true,
        file_ignore_patterns= {'.git/'}
    })
end

-- Improved buffers
M.my_buffers = function()
    prompt_title = "Buffers"
end

return M

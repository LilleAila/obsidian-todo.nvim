local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local M = {}

M.obsidian_todos = function(opts)
  opts = opts or {}

  local base_command = opts.vimgrep_arguments or conf.vimgrep_arguments
  local args = { "\\- \\[ \\]", opts.vault_path }
  local command = utils.flatten({ base_command, args })

  pickers.new(opts, {
    prompt_title = "TODOs",
    finder = finders.new_oneshot_job(command, {
      entry_maker = opts.entry_maker or function(entry)
        local _, _, filename, lnum, col, text = string.find(entry, [[(..-):(%d+):(%d+):(.*)]])

        local ok
        ok, lnum = pcall(tonumber, lnum)
        if not ok then
          lnum = nil
        end

        ok, col = pcall(tonumber, col)
        if not ok then
          col = nil
        end

        display = vim.fn.fnamemodify(filename, ":t") .. " - " .. text:gsub("%- %[ %] " ,"")

        return {
          value = entry, -- Original value
          ordinal = filename, -- Sorted by
          display = display, -- Displayed
          filename = filename, -- Absolute path
          lnum = lnum,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts),
  }):find()
end

-- Testing
-- M.obsidian_todos(require("telescope.themes").get_dropdown({
--   vault_path = "/home/olai/Documents/Obsidian Vault"
-- }))

return M

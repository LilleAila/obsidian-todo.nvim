local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local M = {}

local lua_pattern_escape = function(text)
  local pattern_specials = "().%+-*?[]^$"
  return text:gsub("[" .. pattern_specials:gsub("(.)", "%%%1") .. "]", "%%%1")
end

local regex_escape = function(text)
  local pattern_specials = "().%+-*?[]^$"
  return text:gsub("[" .. pattern_specials:gsub("(.)", "%%%1") .. "]", "\\%1")
end

M.obsidian_todo = function(opts)
  opts = opts or {}

  local search_pattern = opts.search_pattern or conf.search_pattern
  local regex_pattern = regex_escape(search_pattern)
  local lua_pattern = lua_pattern_escape(search_pattern)

  local search_path = (opts.search_path or conf.search_path):gsub("$HOME", os.getenv("HOME"))

  local base_command = opts.vimgrep_arguments or conf.vimgrep_arguments
  local args = { regex_pattern, search_path }
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

        local content = text:gsub(lua_pattern, "")
        -- Get basename and remove file extension
        local display = vim.fn.fnamemodify(filename, ":t"):gsub("%..+$", "") .. " - " .. content

        return {
          value = entry, -- Original value
          ordinal = display, -- Sorted by
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
-- M.obsidian_todo({
--   search_path = "$HOME/Documents/Obsidian Vault",
--   search_pattern = "- [ ] "
-- })

return M

return require("telescope").register_extension({
  setup = function(ext_config, config)
    config.search_path = ext_config.search_path
    config.search_pattern = ext_config.search_pattern or "- [ ] "
  end,
  exports = {
    obsidian_todo = require("obsidian-todo").obsidian_todo,
  },
})

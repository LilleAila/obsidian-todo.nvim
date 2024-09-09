return require("telescope").register_extension({
  setup = function(ext_config, config)
    config.search_path = ext_config.search_path
  end,
  exports = {
    obsidian_todo = require("obsidian-todo").obsidian_todos,
  },
})

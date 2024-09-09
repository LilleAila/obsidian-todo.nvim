return require("telescope").register_extension({
  setup = function(ext_config, config)
    config.vault_path = ext_config.vault_path
  end,
  exports = {
    obsidian_todo = require("obsidian-todo").obsidian_todos,
  },
})

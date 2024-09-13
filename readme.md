# obsidian-todo.nvim

Easily search through your obsidian TODOs items with telescope.

## Usage

Run `:Telescope obsidian_todo obsidian_todo` to open a telescope window with all your TODO-items.

## Installation

### Requirements

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

### Installation

Install the plugin with your favorite plugin manager

#### lazy.nvim

```lua
{ "LilleAila/obsidian-todo.nvim" }
```

### Configuration

Add this to your telescope configuration:

```lua
require("telescope").setup({
    extensions = {
        obsidian_todo = {
            search_path = "/path/to/your/vault", -- This has to be an absolute path
            search_pattern = "- [ ] ", -- This is the default value
        },
    },
})
```

## Nixvim

Add this to your inputs:

```nix
inputs.obsidian-todo = {
    url = "github:LilleAila/obsidian-todo.nvim";
    inputs.nixpkgs.follows = "nixpkgs";
}
```

Add this to your configuration:

```nix
extraPlugins = [ inputs.obsidian-todo.packages.${pkgs.system}.default ];

plugins.telescope.settings.extensions.obsidian_todo = {
    search_path = "/path/to/your/vault";
};

extraConfigLua = # lua
  ''
    require("telescope").load_extension("obsidian_todo")
  '';
```

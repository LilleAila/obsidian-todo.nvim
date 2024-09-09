# obsidian-todo.nvim

Easily search through your TODO items with telescope. This searches for all unchecked check boxes and displays them in a list.

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
            search_path = "/path/to/your/vault"
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
extraPlugins = [ inputs.plugin-obsidian-todo.packages.${pkgs.system}.default ];

plugins.telescope.settings.extensions.obsidian_todo = {
search_path = "/home/olai/Documents/Obsidian Vault";
};

extraConfigLua = # lua
  ''
    require("telescope").load_extension("obsidian_todo")
  '';
```

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs =
    { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      systems = lib.systems.flakeExposed;
      pkgsFor = lib.genAttrs systems (system: import nixpkgs { inherit system; });
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in {
      packages = forEachSystem (pkgs: {
        default = pkgs.vimUtils.buildVimPlugin {
          name = "obsidian-todo.nvim";
          src = ./.;
        };
      });
    };
}

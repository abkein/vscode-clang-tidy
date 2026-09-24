{
  description = "TypeScript dev shell";

  inputs = {
    system-flake.url = "path:/home/kein/nixos-configuration";
    nixpkgs.follows = "system-flake/nixpkgs";
    flake-utils.follows = "system-flake/flake-utils";
  };

  outputs =
    { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jq
            nodejs
            vsce
          ];
        };
      }
    );
}

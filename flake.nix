{
  description = "TypeScript dev shell";

  inputs = {
    system-flake.url = "path:/home/kein/nixos-configuration";
    nixpkgs.follows = "system-flake/nixpkgs";
    flake-utils.follows = "system-flake/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      system-flake,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = system-flake.formatter.${system};
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

{
  description = "TypeScript dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:

    let
      workspaceName = "vscode-clang-tidy";
      root = "/home/kein/repos/vscode-clang-tidy";
      vscodeDir = "${root}/.vscode";

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };


      workspaceFileLoc = "${vscodeDir}/${workspaceName}.code-workspace";
      workspaceFile = pkgs.writeText "${workspaceName}.code-workspace" (
        builtins.toJSON {
          folders = [
            {
              path = root;
            }
          ];
          settings = {

          };
        }
      );
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          jq
          nodejs_24
        ];

        shellHook = ''
          mkdir -p '${vscodeDir}'
          export BETTER_CODE_VSCODE_WORKSPACE_FILE='${workspaceFileLoc}'
          cat '${workspaceFile}' | jq . > '${workspaceFileLoc}'

        '';
      };
    };
}

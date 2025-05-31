{
    description = "Minimal Package declaration for a Nix flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }: {
        flake-utils.lib.eachDefautlSystem (system:
            let
                pkgs = import nixpkgs { inherit system; };
            in
            {
                packages.default = pkgs.buildEnv {
                    name = "minimal-package";
                    paths = with pkgs; [
                        fish 
                        starship
                        neovim
                        git
                        gh
                        ripgrep
                        fd
                        bat
                        numbat
                        tree
                        jq
                    ];
                };
                
                devShells.default = pkgs.mkShell {
                    name = "minimal-dev-shell";
                    buildInputs = with pkgs; [
                        fish 
                        starship
                        neovim
                        git
                        gh
                        ripgrep
                        fd
                        bat
                        tree
                        jq
                    ];
                };
            }
        )
    };
}

{
    description = "";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    };

    outputs = { nixpkgs, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        devShells.${system}.default = pkgs.mkShell {
            packages = with pkgs; [
                ruby_3_4
                ruby-lsp
                nodejs_22
                yarn
                postgresql
            ];
            shellHook = ''
                export GEM_HOME=$PWD/.gem
                export GEM_PATH=$PWD/.gem
                export PATH=$GEM_HOME/bin:$PATH

                echo "Ruby on Rails development shell"
                echo ""
                echo "Ruby Version:"
                ruby -v
                echo "NodeJS Version:"
                node -v
                echo "Yarn Version:"
                yarn -v
                echo "Postgresql Version:"
                postgres --version
                echo ""
                echo "Gems are installed in $GEM_HOME"
                echo "Recommended to use direnv to ensure the same .gem folder is used every time for this project"
            '';
        };
    };
}

{
  description = "Redot Documentation Build Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        pythonEnv = pkgs.python311.withPackages (ps: with ps; [
          pygments
          sphinx
          sphinx-rtd-theme
          sphinx-tabs
          sphinx-copybutton
          sphinx-notfound-page
          sphinxext-opengraph
          sphinxcontrib-video
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.git
            pkgs.gnumake
            pkgs.parallel
            pkgs.libwebp
            pkgs.imagemagick
          ];

          shellHook = ''
            echo "Redot Docs Build Environment"
            echo "Python version: $(python --version)"
            echo ""
            echo "To build docs:"
            echo "  FULL_RUN=1 ./build.sh"
            echo ""
            echo "To serve locally:"
            echo "  cd output/html/en/latest && python -m http.server 8000"
          '';
        };

        apps.default = {
          type = "app";
          program = toString (pkgs.writeShellScript "build-docs" ''
            export PATH="${pythonEnv}/bin:${pkgs.git}/bin:${pkgs.gnumake}/bin:$PATH"
            cd ${self}
            FULL_RUN=1 ./build.sh
            echo "Build complete!"
            echo "To serve: cd output/html/en/latest && python -m http.server 8000"
          '');
        };
      });
}

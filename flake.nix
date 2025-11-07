{
  description = "My mechanical keyboard keymaps";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      defaultSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in {
      devShells = nixpkgs.lib.genAttrs defaultSystems (system: {
        default = let pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.mkShell {
          packages = with pkgs; [ qmk ];
          QMK_HOME = "../qmk_firmware";
          shellHook = ''
            echo "Info: $(qmk config user.overlay_dir)"
            echo "Info: QMK_HOME=$QMK_HOME"
          '';
        };
      });
    };
}


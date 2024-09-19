{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # eduroam
    # eduroam-livuni = {
    #   url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=295&device=linux&generatedfor=user&openroaming=0";
    #   flake = false;
    # };

    # Stylix
    stylix.url = "github:danth/stylix";

    # SWWW
    swww.url = "github:LGFae/swww";

    # AGS
    ags.url = "github:Aylur/ags";

    # Hyprpanel
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # idk
    supportedSystems = [  "linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ ]; });
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # formatter = forAllSystems (system: nixpkgsFor.${system}.nixpkgs-fmt);
    # packages = forAllSystems (system:
    #   let
    #     pkgs = nixpkgsFor.${system};
    #     python-with-dbus = pkgs.python3.withPackages (p: with p; [ dbus-python ]);
    #   in
      # {
        # nix run .#list-eduroam-entityIDs
        # list-eduroam-entityIDs = pkgs.writeShellScriptBin "list-eduroam-entityIDs"
        #   "${pkgs.curl}/bin/curl 'https://cat.eduroam.org/user/API.php?action=listAllIdentityProviders&api' | ${pkgs.jq}/bin/jq";
      
        # # nix run .#install-eduroam-livuni
        # install-eduroam-livuni = pkgs.writeShellScriptBin "install-eduroam-livuni"
        #   "${python-with-dbus}/bin/python3 /home/gabri/.src/nixos/network-config/eduroam-linux-UoL.py";
        # Original code
        nixosConfigurations = {
          # FIXME replace with your hostname
          gtnbr-nixos = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs outputs;};
            # > Our main nixos configuration file <
            modules = [
              ./configuration.nix
              inputs.stylix.nixosModules.stylix
            ];
          };
        };
      };
}
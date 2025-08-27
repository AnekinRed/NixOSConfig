{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      zen-browser = {
    url = "github:0xc000022070/zen-browser-flake/beta";
    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    inputs.nixpkgs.follows = "nixpkgs";
  };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, stylix, zen-browser, ... }: {

    nixosConfigurations.AnekinRedsLaptop = nixpkgs.lib.nixosSystem {
      modules = [
      stylix.nixosModules.stylix
        ./configuration.nix
      ];
    };

  };
  
}

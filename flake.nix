{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # zen-browser = {
    #url = "github:0xc000022070/zen-browser-flake";
    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    # inputs.nixpkgs.follows = "nixpkgs";
    #};
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      stylix,
      home-manager,
      fenix,
      ...
    }@inputs:
    {
      packages.x86_64-linux.default = fenix.packages.x86_64-linux.stable.toolchain;
      nixosConfigurations.AnekinRedsLaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anekinred = ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          {nixpkgs.overlays = [ fenix.overlays.default ];}
          ];
      };

    };

}

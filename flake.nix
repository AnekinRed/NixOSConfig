{  
inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nixos' is the default hostname
      system = "x84_64-linux";
      modules = [
      {nix.settings.experimental-features = ["nix-command" "flakes"];} 
     ./configuration.nix ];

    };
}

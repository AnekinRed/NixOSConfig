# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
services.displayManager.sddm.wayland.enable = true;
services.displayManager.sddm.enable = true;
nixpkgs.config.allowUnfree = true;  
programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # ...

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia""modesetting"];

  hardware.nvidia = {

    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


 

	hardware.nvidia.prime = {
    		sync.enable = true;

		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
                
	};

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    });
  '';
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev" ;


 
  networking.hostName = "AnekinRedsLaptop";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    
  # Set your time zone.
   time.timeZone = "Europe/Oslo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.111111
   i18n.defaultLocale = "en_GB.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
   };

  # Enable the X11 windowing system.
  #  services.xserver.enable = true;


  #  Configure keymap in X11
   services.xserver.xkb.layout = "no";
   services.xserver.xkb.variant = "nodeadkeys";
   services.xserver.xkb.options = "eurosign:e, compose:menu, grp:win_alt_space_toggle";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
 
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.anekinred = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$wazE4Reg6Za8EalIiAlsT1$CxwmGLZtnfD3DMhAda9Z91O4UewzVHXi.NfdkIQzF01";
    packages = with pkgs; [
      tree
    ];
   };

nix.settings.experimental-features = ["nix-command" "flakes" ];

  programs.firefox.enable = true;
  programs.steam.enable =  true;
  programs.fish.enable = true;
  programs.neovim.defaultEditor = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim
    git
    vesktop
    htop-vim
    libreoffice-qt6
    obsidian
    qalculate-qt
    flatpak
    inkscape-with-extensions
    godot
    bottles
    obs-studio
    wget
    kitty
    kittysay
    kitty-img
    byobu
    fastfetch
    testdisk-qt
    lazygit
    libgcc
    curlFull
    fzf
    ripgrep-all
    fd
    vimPlugins.LazyVim
    vimPlugins.nvim-treesitter
    pavucontrol
    waybar
    thunderbird-latest-unwrapped
    vlc
    kdePackages.dolphin
  ];
  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

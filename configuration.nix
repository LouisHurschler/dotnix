# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone  = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  
  services = {
      desktopManager.plasma6 = {
        enable = true;
        enableQt5Integration = true; #disable for qt6 full version
      };
      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          # wayland.enable = true;
        };
      };
    };
  # Enable wayland
  # services.xserver = {
  #   enable = true;
  #   # Enable the KDE Plasma Desktop Environment.
  #   desktopManager.plasma5.enable = true;
  # };

  # services.displayManager = {
  #   # defaultSession = "plasmawayland";
  #   sddm = {
  #     enable = true;
  #     # this does not work?
  #     # wayland.enable = true;
  #   };
  # };


  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "ch";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.louish = {
    isNormalUser = true;
    description = "Louis Hurschler";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      google-chrome
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  wget
  ifuse
  ];

  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  hardware.graphics.enable = true;

	hardware.nvidia = {
		# powerManagement.enable = true;
		# package = config.boot.kernelPackages.nvidiaPackages.beta;
		# package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    open = false;
		modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
		prime = {
			# offload.enable = true;
			sync.enable = true;

			# Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
			nvidiaBusId = "PCI:1:0:0";

			# Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
			intelBusId = "PCI:0:2:0";
    };
	};  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 1883 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

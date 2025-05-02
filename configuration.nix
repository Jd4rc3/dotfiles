# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  fonts.packages = with pkgs; [ noto-fonts-color-emoji ];
  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;
  security.pam.services.login.enableKwallet = true;
  security.pam.services.sddm.enableKwallet = true;
  security.pam.services.kde.enableKwallet = true;
  #programs.nix-ld.libraries = with pkgs; [ xorg.libX11 xorg.libXcursor xorg.libXext xorg.libXrender xorg.libXt xorg.libXrandr xorg.libXext xorg.libXfixes xorg.libXi ];
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  nixpkgs.config.allowUnfree = true;
  # DOCKER
 # virtualisation.docker = {
 #   enable = false;
 #   enableOnBoot = false;
 # };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.extraGroups.docker.members = [ "arce" ];

  programs.zsh.enable = true;
  programs.steam.enable = true;
  services.ratbagd.enable = true;
  services.gsignond.enable = true;
  services.gsignond.plugins = with pkgs; [ gsignondPlugins.oauth gsignondPlugins.sasl gsignondPlugins.mail ];

  users.users.arce = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ 
      adw-gtk3
      android-tools
      awscli
      #AZCLI
      (azure-cli.withExtensions [ azure-cli.extensions.azure-devops ])
      bashdb
      bat
      cargo
      cmakeMinimal
      curl
      delta
      discord
      dockfmt
      dotnetPackages.Nuget
      dbeaver-bin
      #dotnet-sdk
      editorconfig-core-c
      emacs30
      element-desktop
      pinentry-qt
      kdePackages.ksshaskpass
      kdePackages.kio-gdrive
      kdePackages.kaccounts-providers
      kdePackages.kaccounts-integration
      kdePackages.ksystemlog
      gsignondPlugins.oauth
      erdtree
      vlc
      eza
      fd
      ffmpeg-full
      fnm
      freerdp3
      fzf
      fzf
      gcc
      gdb
      ghostty
      git
     # GNOME
    # gnomeExtensions.appindicator
    # gnomeExtensions.clipboard-history
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.space-bar
    # gnome-tweaks
      gnumake
      go
      go
      hadolint
      handbrake
      hex
      htmlq
      htop
      imagemagick
      jdk17
      jetbrains-toolbox
      jq
      lazydocker
      lazygit
      libtool
      llvm
      llvmPackages_19.clang-unwrapped
      luarocks
      microsoft-edge
      neovim
      nerdfonts
      onlyoffice-desktopeditors
      pavucontrol
      pipx
      podman-desktop
      podman-compose
      powershell
      python311
      qbittorrent
      ripgrep
      shellcheck
      shfmt
      spotify
      starship
      stow
      tealdeer
      terraform
      tmux
      unzip
      utf8proc
      vscode
      wl-clipboard
      yt-dlp
      zed-editor
      zip
      zoxide
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];



  networking = {
    hostName = "laptop-nixos";
    extraHosts = ''
      192.168.1.13 homelab
    '';
  };
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
#    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb.layout = "us";
    xkb.options = "eurosign:e,caps:escape,compose:ralt";
  };
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  programs.firefox.enable = true;

  #FLATPAK
  services.dbus.enable = true;
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
 # environment.gnome.excludePackages = (with pkgs; [
 #   epiphany # web browser
 #   geary # email reader
 #   gnome-console
 # ]);

  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
         # List package dependencies here
      ];
    })
    piper
    vim
    wget
    ungoogled-chromium
    qemu_full
  ];
  

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

  services.asusd = {
    enableUserService = true;
    enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}


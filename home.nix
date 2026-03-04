{ lib, pkgs, ... }:
let
  username = "dk";
in
{
  home = {
    packages = with pkgs; [ ];

    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    file = {
      ".bashrc" = {
        text = ''
          								# This must be sourced in your .bashrc or whatever shell you're using.
          								# In the future we can get home-manager to do this for us, but bootstrapping for now...
          								source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
          								alias ls = eza
          								complete -cf doas
        '';
        executable = false;
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    bashrcExtra = ''
      complete -cf doas
    '';
  };

  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = {
      DefaultDownloadDirectory = "\${home}/firefoxDownloads";
      AppAutoUpdate = false;
      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [
          "Google"
          "Ecosia"
          "Bing"
        ];
      };
      OfferToSaveLogins = false; # Control whether or not Firefox offers to save passwords.
      # Disable or configure PDF.js, the built-in PDF viewer.
      PDFjs = {
        Enabled = true;
        EnablePermissions = false; # if set to true, the built-in PDF viewer will honor document permissions like preventing the copying of text.
      };
      FirefoxSuggest = {
        WebSuggestions = false;
      };

      # ----Performance----
      DisableFeedbackCommands = true; # Disable the menus for reporting sites.
      DisableFirefoxAccounts = true; # Disable Firefox Accounts integration (Sync).
      DisableFirefoxScreenshots = true; # Remove access to Firefox Screenshots.
      DisablePocket = true; # Remove Pocket in the Firefox UI.
      DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image.
      DontCheckDefaultBrowser = true; # Don’t check if Firefox is the default browser at startup.
      # Configure generative AI features.
      GenerativeAI = {
        Enabled = false;
      };
      HardwareAcceleration = true; # Control hardware acceleration.
      PasswordManagerEnabled = false; # Remove (some) access to the password manager.
      PrintingEnabled = false; # Enable or disable printing.

      # ----Privacy----
      DisableFirefoxStudies = true; # Disable Firefox studies (Shield).
      DisableFormHistory = true; # Turn off saving information on web forms and the search bar.
      DisableTelemetry = true;

      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4665768/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        "clipper@obsidian.md" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4707389/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4698131/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
      };

    };
  };
}

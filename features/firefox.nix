{ pkgs, config, firefox-addons, ... }: {
  programs.firefox = {
    enable = true;
    profiles.pkino = {
      extensions = {
        packages = with firefox-addons.packages."x86_64-linux"; [
          control-panel-for-twitter
          leechblock-ng
          ublock-origin
          vimium
          to-deepl
        ];
      };

      settings = {
        autoDisableScopes = 0;
      };
    };
  };
}

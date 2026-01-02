{ firefox-addons, system, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.pkino = {
      extensions = {
        packages = with firefox-addons.packages.${system}; [
          control-panel-for-twitter
          leechblock-ng
          ublock-origin
          vimium
          to-deepl
        ];

        force = true;
      };

      settings = {
        autoDisableScopes = 0;
      };
    };
  };
}

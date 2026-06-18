{ firefox-addons-unfree, system, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.l955a6 = {
      extensions = {
        packages = with firefox-addons-unfree; [
          control-panel-for-twitter
          leechblock-ng
          ublock-origin
          vimium
          to-deepl
          firefox-addons-unfree."1password-x-password-manager"
        ];

        force = true;
      };

      settings = {
        autoDisableScopes = 0;
      };
    };
  };
}

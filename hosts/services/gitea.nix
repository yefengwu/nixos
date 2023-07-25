{
  services.gitea = {
    enable = true;
    appName = "Franklxw's Gitea Service";
    stateDir = "/home/gitea";
    database = {
      type = "postgres"; # Database type
      passwordFile = "/run/keys/gitea-dbpass"; # Where to find the password
    };
    settings.server = {
      ROOT_URL = "https://git.in.com/";
      DOMAIN = "git.in.com";
      HTTP_PORT = 3000;
      SSH_PORT = 22;
    };
  };
  services.postgresql = {
    enable = true; # Ensure postgresql is enabled
    authentication = ''
      local gitea all ident map=gitea-users
    '';
    identMap = # Map the gitea user to postgresql
      ''
        gitea-users gitea gitea
      '';
  };
}

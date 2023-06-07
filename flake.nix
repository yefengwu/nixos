{
  description = "xuwei's NixOS Flake"
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs @ { self, nixpkgs, ...}@inputs: {
      nixosConfigurations."nixos" =
        let
          username = "xuwei";
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs username; };
          modules = [
            ./hosts/minium
            ./hosts/system.nix
            # ./modules/virtualisation

            # 导入 home-manager 模块
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              # 导入想要的 home-manager 配置文件
              home-manager.users.${username}.imports = [
                ./hm/default.nix
              ];
            }
          ];
        };
    };
}

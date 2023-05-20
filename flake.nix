{
  inputs = {
    # 新加入 nixos-wsl
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
      self,
      nixpkgs,
      nixos-wsl, # 新加入
      nixos-hardware,
      home-manager,
      ...
    }: {
      # 几乎跟之前配置一样
      nixosConfigurations.wsl = let
        # 自己定义一个局部变量，并用 specialArgs 传导给其它文件
        username = "xuwei"; 
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs username;};
          modules = [
            # 导入 nixos-wsl 模块
            nixos-wsl.nixosModules.wsl

            # 导入自己写的 wsl 系统配置
            ./hosts/wsl
	    ./hosts/system.nix

            # 导入之前系统的一些配置
            #./nixos/nixconfig.nix
            #./nixos/font.nix

            # 导入 home-manager 模块
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs;};
              # 导入想要的 home-manager 配置文件
              home-manager.users.${username}.imports = [
                #./home-manager/cli.nix
		./home-manager/default.nix
                ./home-manager/zsh.nix
              ];
            }
          ];
        };
    };
}

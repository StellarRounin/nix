# modules/disko-base.nix
{ self, inputs, ... }: {

  # Lo exportamos globalmente al árbol de tu Flake
  flake.nixosModules.diskoBase = { config, lib, ... }: {
    options = {
      miSistema.discoPrincipal = lib.mkOption {
        type = lib.types.str;
        description = "Ruta o ID del disco principal para instalar NixOS";
      };
    };

    config = {
      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = config.miSistema.discoPrincipal;
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  end = "500M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = {
                  name = "root";
                  end = "-0";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

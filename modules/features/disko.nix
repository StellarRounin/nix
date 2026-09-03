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
            device = "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S21PNXAGB12345";
            content = {
              type = "gpt";
              partitions = {
                boot = {
                  size = "1M";
                  type = "EF02"; # for grub MBR
                };
                ESP = {
                  size = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = {
                  size = "100%";
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

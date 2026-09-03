# modules/disko-base.nix
{ self, inputs, ... }: {

  flake.nixosModules.diskoBase = { config, lib, ... }: {
    options = {
      miSistema.discoPrincipal = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      disko.devices = {
        disk = {
          main = {
            device = config.miSistema.discoPrincipal;;
            type = "disk";

            content = {
              type = "gpt";

              partitions = {
                boot = {
                  type = "EF00";
                  size = "500M";

                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };

                swap = {
                  size = "8G";

                  content = {
                    type = "swap";
                  };
                };

                root = {
                  size = "80%";

                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };

                home = {
                  size = "100%";

                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/home";
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

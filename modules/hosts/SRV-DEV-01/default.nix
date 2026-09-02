{ self, inputs, ... }: {
  flake.nixosConfigurations.srvDev01 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.srvDev01Configuration
    ];
  };
}

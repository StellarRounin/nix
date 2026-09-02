{ self, inputs, ... }: {
  flake.nixosConfigurations.srvDev01 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.disko.nixosModules.disko # Inyecta el motor de disko
      self.nixosModules.srvDev01Configuration
    ];
  };

}

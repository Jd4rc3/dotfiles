{
  description = "Chatterino unstable branch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = {
     chatterino = nixpkgs.legacyPackages.x86_64-linux.chatterino7;
     default = self.packages.x86_64-linux.chatterino;
    };
  };
}

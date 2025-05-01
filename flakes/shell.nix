{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let 
    dotnet-combined = (with dotnetCorePackages; combinePackages [
      sdk_8_0
      sdk_9_0
    ]).overrideAttrs (finalAttrs: previousAttrs: {
      postBuild = (previousAttrs.postBuild or '''') + ''

        for i in $out/sdk/*
        do
          i=$(basename $i)
          mkdir -p $out/metadata/workloads/''${i/-*}
          touch $out/metadata/workloads/''${i/-*}/userlocal
        done
      '';
    });
in
dotnet-combined

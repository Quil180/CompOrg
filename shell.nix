# shell.nix for setting up development environment for Nixos/Nix
with (import <nixpkgs> {});
  mkShell {
    buildInputs = [
      openjdk8-bootstrap
    ];
    shellHook = ''
      alias mars="java -jar Mars4_5.jar"
      java -jar Mars4_5.jar
    '';
  }

# Nixtalia

A flake that combines a preconfigured niri, and noctalia shell for NixOS.

## Usage

You can use this flake in a variety of ways. either running it directly via

```nix
nix run github:DeagledSmeagol/nixtalia
```

or via importing one of the package exports.

- `default`: Installs the full nixtalia experience
- `myNiri`: same as default
- `myNoctalia`: just noctalia shell, without niri

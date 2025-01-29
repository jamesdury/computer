{ lib, ... }:
{
  mapModules =
    args: dir:
    lib.attrValues (
      lib.mapAttrs (name: _: import (dir + "/${name}") args) (
        lib.filterAttrs (_: type: type == "regular") (builtins.readDir dir)
      )
    );
}

{ lib, ... }: {
  mapModules = dir:
    lib.attrValues (lib.mapAttrs (name: _: import (dir + "/${name}"))
      (lib.filterAttrs (_: type: type == "regular") (builtins.readDir dir)));
}

{ lib, ... }:
{
  mapModules =
    args: dir:
    lib.attrValues (
      lib.mapAttrs (
        name: _:
        import (dir + "/${name}") (
          args
          // {
            inherit (args)
              config
              lib
              pkgs
              homeConfig
              ;
            # Add any other necessary arguments here
          }
        )
      ) (lib.filterAttrs (_: type: type == "regular") (builtins.readDir dir))
    );
}

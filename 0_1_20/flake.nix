{
  description = ''a collection of useful macro functionalities & enums'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-macroplus-0_1_20.flake = false;
  inputs.src-macroplus-0_1_20.ref   = "refs/tags/0.1.20";
  inputs.src-macroplus-0_1_20.owner = "hamidb80";
  inputs.src-macroplus-0_1_20.repo  = "macroplus";
  inputs.src-macroplus-0_1_20.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-macroplus-0_1_20"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-macroplus-0_1_20";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}
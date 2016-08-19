within IDEAS.Buildings.Data.Constructions;
record CavityWall
  "Classic cavity wall construction with fully-filled cavity"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={Materials.BrickMe(d=0.08),
                insulationType,
                Materials.BrickMi(d=0.14),
                Materials.Gypsum(d=0.015)});

end CavityWall;

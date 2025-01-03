within IDEAS.Buildings.Data.Constructions.EPB.label_C;
record Floor  "Construction data of Floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={IDEAS.Buildings.Data.Materials.CeramicTileForFinishing(d=0.02),
 IDEAS.Buildings.Data.Materials.ScreedOrLightCastConcrete(d=0.08),
 IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(d=0.075),
 IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(d=0.075),
 IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02)});
end Floor;

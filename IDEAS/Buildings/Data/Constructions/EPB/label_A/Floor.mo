within IDEAS.Buildings.Data.Constructions.EPB.label_A;
record Floor  "Construction data of Floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.CeramicTileForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.ScreedOrLightCastConcrete(d=0.08),
        IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(d=0.075),
        IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(
        d=0.075),
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02)});
        annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end Floor;

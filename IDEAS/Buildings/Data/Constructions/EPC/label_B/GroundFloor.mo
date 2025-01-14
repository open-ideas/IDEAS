within IDEAS.Buildings.Data.Constructions.EPC.label_B;
record GroundFloor  "Construction data of GroundFloor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
  locGain={3},
  incLastLay=IDEAS.Types.Tilt.Floor,
  final mats={
    IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(d=0.2),
    IDEAS.Buildings.Data.Insulation.ExpandedPolystrenemOrEPS(d=0.07382181126658739),
    IDEAS.Buildings.Data.Materials.ScreedOrLightCastConcrete(d=0.06),
    IDEAS.Buildings.Data.Materials.CeramicTileForFinishing(d=0.02)});
  annotation (Documentation(revisions="<html> 
                  <ul> 
                  <li>March 10, 2024, by Lucas Verleyen:<br> 
                  Add locGain={3}.</li>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
Implementation in IDEAS. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end GroundFloor;

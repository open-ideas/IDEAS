within IDEAS.Buildings.Data.Constructions.EPC.LabelB;
record GroundFloor  "Construction data of GroundFloor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={2},
    incLastLay=IDEAS.Types.Tilt.Floor,
    final mats={
        IDEAS.Buildings.Data.Materials.EPC.DenseCastConcreteAlsoForFinishing(d=0.2),
        IDEAS.Buildings.Data.Insulation.EPC.ExpandedPolystrenemOrEPS(d=0.07382181126658739),
        IDEAS.Buildings.Data.Materials.EPC.ScreedOrLightCastConcrete(d=0.06),
        IDEAS.Buildings.Data.Materials.EPC.CeramicTileForFinishing(d=0.02)});
  annotation (Documentation(info="<html>
<p>
Construction data of a ground floor in an EPC B building
</p>
</html>",revisions="<html> 
<ul> 
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
Implementation in IDEAS. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
<li>
March 10, 2024, by Lucas Verleyen:<br/> 
Add locGain.
</li>
</ul>
</html>"));
end GroundFloor;

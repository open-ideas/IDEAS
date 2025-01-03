within IDEAS.Buildings.Data.Constructions.EPB.label_C;
record GroundFloor  "Construction data of GroundFloor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(locGain={3},
    final mats={IDEAS.Buildings.Data.Materials.DenseCastConcreteAlsoForFinishing(d=0.2),
     IDEAS.Buildings.Data.Insulation.ExpandedPolystrenemOrEPS(d=0.07382181126658739),
     IDEAS.Buildings.Data.Materials.ScreedOrLightCastConcrete(d=0.06),
     IDEAS.Buildings.Data.Materials.CeramicTileForFinishing(d=0.02)});
  annotation (Documentation(revisions="<html> 
                  <ul> 
                  <li>March 10, 2024, by Lucas Verleyen:<br> 
                  Add locGain={3}.</li> 
                  </ul> 
                  </html>"));
end GroundFloor;

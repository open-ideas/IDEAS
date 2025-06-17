within IDEAS.Buildings.Data.Constructions;
record FloorOnGround "Floor on ground for floor heating system"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={2},
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={
      IDEAS.Buildings.Data.Materials.Concrete(d=0.20),
      IDEAS.Buildings.Data.Insulation.Eps(d=0.1),
      IDEAS.Buildings.Data.Materials.Screed(d=0.08),
      IDEAS.Buildings.Data.Materials.Tile(d=0.02)});


  annotation (Documentation(revisions="<html>
<ul>
<li>
April 14, 2025, by Anna Dell'Isola:<br/>
Update contruction. 
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1433\">#1433</a>
</li>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end FloorOnGround;

within IDEAS.Buildings.Data.Constructions;
record UninsulatedFloor "Construction data of Uninsulated Floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
 locGain={2},
 incLastLay=IDEAS.Types.Tilt.Floor,
 final mats={IDEAS.Buildings.Data.Materials.Gypsum(d=0.02),
        IDEAS.Buildings.Data.Materials.Concrete(d=0.15),
        IDEAS.Buildings.Data.Materials.Screed(d=0.08),
        IDEAS.Buildings.Data.Materials.Tile(d=0.02)});
        annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end UninsulatedFloor;

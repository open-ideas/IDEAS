within IDEAS.Examples.PPD12.Data;
record InteriorWall18 "Ppd12 interior wall 18 cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01),
      IDEAS.Buildings.Data.Materials.Brick(d=0.18),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01)});
  annotation (Documentation(info="<html>
<p>
Custom interior wall construction type.
</p>
</html>", revisions="<html>
<ul>
<li>
July 20, 2022, by Filip Jorissen:<br/>
Revised brick type for #1245.
</li>
</ul>
</html>"));
end InteriorWall18;

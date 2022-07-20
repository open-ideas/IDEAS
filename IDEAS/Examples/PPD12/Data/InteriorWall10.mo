within IDEAS.Examples.PPD12.Data;
record InteriorWall10 "Ppd12 interior wall 10cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02),
      IDEAS.Buildings.Data.Materials.Brick(d=0.10),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02)});
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
end InteriorWall10;

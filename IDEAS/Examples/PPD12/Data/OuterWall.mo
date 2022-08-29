within IDEAS.Examples.PPD12.Data;
record OuterWall "Ppd12 outer wall 30cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Brick(d=0.27),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02)});

  annotation (Documentation(info="<html>
<p>
Custom outer wall construction type.
</p>
</html>", revisions="<html>
<ul>
<li>
November 14, 2022, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end OuterWall;

within IDEAS.Buildings.Data.Materials.EPC;
record MediumMasonryForInteriorApplications =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=0.54,
      c=840,
      rho=1400,
      epsLw=0.88,
      epsSw=0.55)
      annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

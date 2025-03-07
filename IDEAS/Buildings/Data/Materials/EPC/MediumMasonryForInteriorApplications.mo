within IDEAS.Buildings.Data.Materials.EPC;
record MediumMasonryForInteriorApplications =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=0.54,
      c=840,
      rho=1400,
      epsLw=0.88,
      epsSw=0.55)
  "Material name: MediumMasonryForInteriorApplications, Material ID: bea89b1c-ad85-11eb-a67c-484d7ef975f7"
      annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

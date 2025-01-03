within IDEAS.Buildings.Data.Materials;
record HeavyMasonryForInteriorApplications =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=0.90,
      c=840,
      rho=1850,
      epsLw=0.88,
      epsSw=0.55)
  "Material name: HeavyMasonryForInteriorApplications, Material ID: 0abb1554-83ff-11e6-bed8-2cd444b2e704"
      annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

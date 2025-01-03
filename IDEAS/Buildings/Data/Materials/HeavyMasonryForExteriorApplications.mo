within IDEAS.Buildings.Data.Materials;
record HeavyMasonryForExteriorApplications =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=1.10,
      c=840,
      rho=1850,
      epsLw=0.88,
      epsSw=0.55)
  "Material name: HeavyMasonryForExteriorApplications, Material ID: 0abaee5a-83ff-11e6-a1cb-2cd444b2e704"
    annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

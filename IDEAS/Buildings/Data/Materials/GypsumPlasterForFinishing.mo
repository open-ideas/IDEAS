within IDEAS.Buildings.Data.Materials;
record GypsumPlasterForFinishing = IDEAS.Buildings.Data.Interfaces.Material (
      k=0.6,
      c=840,
      rho=975,
      epsLw=0.85,
      epsSw=0.65)
  "Material name: GypsumPlasterForFinishing, Material ID: 0aba51fd-83ff-11e6-b93d-2cd444b2e704"
    annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

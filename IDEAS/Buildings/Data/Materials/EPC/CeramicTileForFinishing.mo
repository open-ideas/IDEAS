within IDEAS.Buildings.Data.Materials.EPC;
record CeramicTileForFinishing = IDEAS.Buildings.Data.Interfaces.Material (
      k=1.4,
      c=840,
      rho=2100,
      epsLw=0.88,
      epsSw=0.55)
  "Material name: CeramicTileForFinishing, Material ID: 0aba520e-83ff-11e6-920d-2cd444b2e704"
      annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

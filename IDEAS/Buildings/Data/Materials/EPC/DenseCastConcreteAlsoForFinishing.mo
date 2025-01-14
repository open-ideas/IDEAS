within IDEAS.Buildings.Data.Materials.EPC;
record DenseCastConcreteAlsoForFinishing =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=1.4,
      c=840,
      rho=2100,
      epsLw=0.88,
      epsSw=0.55)
  "Material name: DenseCastConcreteAlsoForFinishing, Material ID: 0abb8a82-83ff-11e6-8ff5-2cd444b2e704"
      annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

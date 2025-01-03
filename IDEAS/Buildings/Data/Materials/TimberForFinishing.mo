within IDEAS.Buildings.Data.Materials;
record TimberForFinishing = IDEAS.Buildings.Data.Interfaces.Material (
      k=0.11,
      c=1880,
      rho=550,
      epsLw=0.86,
      epsSw=0.44)
  "Material name: TimberForFinishing, Material ID: 0abaa02c-83ff-11e6-b0b6-2cd444b2e704"
      annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

within IDEAS.Buildings.Data.Materials.EPC;
record TimberForFinishing = IDEAS.Buildings.Data.Interfaces.Material (
      k=0.11,
      c=1880,
      rho=550,
      epsLw=0.86,
      epsSw=0.44)
      annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

within IDEAS.Buildings.Data.Insulation.EPC;
record Rockwool415TimberForFinishing35 =
    IDEAS.Buildings.Data.Interfaces.Insulation (
      k=0.042,
      c=920.0,
      rho=144.22,
      epsLw=0.85,
      epsSw=0.85)
  annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

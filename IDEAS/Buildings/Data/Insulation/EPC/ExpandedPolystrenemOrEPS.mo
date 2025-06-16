within IDEAS.Buildings.Data.Insulation.EPC;
record ExpandedPolystrenemOrEPS = IDEAS.Buildings.Data.Interfaces.Insulation (
      k=0.036,
      c=1470,
      rho=26,
      epsLw=0.8,
      epsSw=0.8)
    annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

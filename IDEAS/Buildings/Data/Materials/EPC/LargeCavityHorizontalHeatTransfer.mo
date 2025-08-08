within IDEAS.Buildings.Data.Materials.EPC;
record LargeCavityHorizontalHeatTransfer =
    IDEAS.Buildings.Data.Interfaces.Material (
      k=0.1388888888888889,
      c=20,
      rho=1.23,
      epsLw=0.88,
      epsSw=0.55,
      final gas=true)
      annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));

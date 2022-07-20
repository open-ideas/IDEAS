within IDEAS.Buildings.Data.Materials;
record Slate =IDEAS.Buildings.Data.Interfaces.Material (
    k=1.44,
    c=1260,
    rho=2700,
    epsLw=0.97,
    epsSw=0.9) "Slate (13 mm) for roofing" annotation (Documentation(
      revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>",           info="<html>
<p>
Thermal properties of slate. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>"));

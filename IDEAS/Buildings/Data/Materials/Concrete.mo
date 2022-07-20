within IDEAS.Buildings.Data.Materials;
record Concrete = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.4,
    c=900,
    rho=2240,
    epsLw=0.88,
    epsSw=0.55) "Heavyweight concrete" annotation (
    Documentation(info="<html>
<p>
Thermal properties of concrete. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

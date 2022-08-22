within IDEAS.Buildings.Data.Materials;
record Gypsum = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.38,
    c=840,
    rho=1120,
    epsLw=0.85,
    epsSw=0.65) "Gypsum plaster for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of gypsum. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

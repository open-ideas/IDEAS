within IDEAS.Buildings.Data.Materials;
record Glass = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.0,
    c=840,
    rho=2500,
    epsLw=IDEAS.Buildings.Data.Constants.epsLw_glass,
    epsSw=IDEAS.Buildings.Data.Constants.epsSw_glass) "Glass" annotation (Documentation(info="<html>
<p>
Thermal properties of glass. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

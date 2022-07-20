within IDEAS.Buildings.Data.Materials;
record Plywood = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.15,
    c=1880,
    rho=540,
    epsLw=0.86,
    epsSw=0.44) "Plywood finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of plywood. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26  and values provided <a href=\"https://buildex.techinfus.com/en/uteplenie/teploprovodnost-uteplitelej.html\">here</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

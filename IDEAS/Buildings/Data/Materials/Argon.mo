within IDEAS.Buildings.Data.Materials;
record Argon = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.0174,
    c=522,
    rho=1.66,
    epsSw=0,
    epsLw=0,
    gas=true,
    nu=13.4*10e-6) "Argon gass" annotation (Documentation(info="<html>
<p>
Constant argon thermal properties (T=20&deg;C). The values are calculated using the records in the Buildings library.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

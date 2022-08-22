within IDEAS.Buildings.Data.Materials;
record Air = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.0256,
    c=1006,
    rho=1.20,
    epsSw=0,
    epsLw=0,
    gas=true,
    nu=15.1*10e-6) "Air" annotation (Documentation(info="<html>
<p>
Constant air thermal properties (T=20&deg;C). The values are calculated using the records in the Buildings library.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

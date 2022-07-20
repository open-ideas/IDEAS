within IDEAS.Buildings.Data.Materials;
record Xenon =   IDEAS.Buildings.Data.Interfaces.Material (
    k=0.0055,
    c=158,
    rho=5.46,
    epsSw=0,
    epsLw=0,
    gas=true,
    nu=41.8*10e-6) "Xenon gass"   annotation (Documentation(info="<html>
<p>
Constant xenon thermal properties (T=20&deg;C). The values are calculated using the records in the Buildings library.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

within IDEAS.Buildings.Data.Materials;
record Screed = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.45,
    c=840,
    rho=1100,
    epsLw=0.88,
    epsSw=0.55) "Typical (Belgian) screed" annotation (Documentation(info="<html>
<p>
Thermal properties of screed. The values are based on those provided in <a href=\"https://www.rsprojects.eu/images/Duremit/Warmtegeleiding%20van%20Duremitchape.pdf\">this document</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

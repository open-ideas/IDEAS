within IDEAS.Buildings.Data.Materials;
record BrickHollow = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.3,
    c=880,
    rho=850,
    epsLw=0.88,
    epsSw=0.55) "Masonry for interior applications (hollow brick, Dutch: 'snelbouwsteen')" annotation (
    Documentation(info="<html>
<p>
Thermal properties of heavy bricks for interior masonry. 
The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26 and 
values provided in a <a href=\"https://www.wienerberger.be/content/dam/wienerberger/belgium/marketing/documents-magazines/technical/technical-infosheet/wall/Thermobrick%2015N%20-%20Nova.pdf\">datasheet</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Created one brick type for interior masonry. 
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

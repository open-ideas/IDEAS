within IDEAS.Buildings.Data.Materials;
record Brick = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.89,
    c=800,
    rho=1920,
    epsLw=0.88,
    epsSw=0.55) "Masonry for exterior applications" annotation (
    Documentation(info="<html>
<p>
Thermal properties of heavy bricks for exterior masonry. The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Created one brick type for exterior masonry. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

within IDEAS.Buildings.Data.Insulation;
record Rockwool = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.035,
    c=800,
    rho=100,
    epsLw=0.8,
    epsSw=0.8) "Rockwool (board)" annotation (Documentation(info="<html>
<p>
Rockwool insulation thermal properties. 
The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));

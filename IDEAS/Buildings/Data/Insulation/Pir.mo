within IDEAS.Buildings.Data.Insulation;
record Pir = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.025,
    c=1500,
    rho=30) "Polyisocyanuraat foam, PIR" annotation (Documentation(info="<html>
<p>
Polyisocyanurate (PIR) insulation thermal properties. 
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

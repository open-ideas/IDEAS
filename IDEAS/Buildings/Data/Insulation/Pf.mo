within IDEAS.Buildings.Data.Insulation;
record Pf =  IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.020,
    c=1400,
    rho=40) "Phenolic foam, PF"          annotation (Documentation(info="<html>
<p>
Phenolic foam (PF) insulation thermal properties. 
The values are based on those in the ASHRAE 2017 Handbook of Fundamentals, Chapter 26.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));

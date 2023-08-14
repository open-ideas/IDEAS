within IDEAS.Buildings.Components.Interfaces;
expandable connector WindowBus
  "Bus containing inputs/outputs for linear window model"
  parameter Integer nLay = 3 "Number of window layers";

  RealConnector[nLay] AbsQFlow(start=fill(100,nLay)) annotation ();
  RealConnector iSolDir(start=100) annotation ();
  RealConnector iSolDif(start=100) annotation ();

  annotation (Documentation(revisions="<html>
<ul>
<li>
April 20, 2023 by Jelger Jansen:<br/>
Make the connector expandable to avoid (pedantic check) warnings in Dymola 2022x.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/1317>#1317</a>
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
Specialized connector
</p>
</html>"), Icon(graphics={
          Rectangle(
            lineColor={255,204,51},
            lineThickness=0.5,
            extent={{-20,-2},{20,2}}),
          Polygon(
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,
              -40},{-100,30}},
            smooth=Smooth.Bezier),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-65,15},{-55,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-5,15},{5,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{55,15},{65,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-35,-25},{-25,-15}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{25,-25},{35,-15}})}));
end WindowBus;

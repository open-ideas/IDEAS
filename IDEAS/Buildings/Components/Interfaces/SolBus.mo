within IDEAS.Buildings.Components.Interfaces;
connector SolBus
  "Bus containing solar radiation for various incidence angles as well as external convection coefficients"
  parameter Boolean outputAngles = true "Set to false when linearising in Dymola only";
  IDEAS.Buildings.Components.Interfaces.RealConnector HDirTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector HSkyDifTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector HGroDifTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector hForcedConExt(unit="W/(m2.K)",start=10) "Coefficient for forced convection at exterior surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector angInc(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector angZen(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector angAzi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector Tenv(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min = 0.0,
    start = 293.15,
    nominal = 300,
    displayUnit="degC") "Equivalent radiant temperature" annotation ();


  annotation (Documentation(info="<html>
<p>
Connector that contains all solar irridiation information for one inclination and tilt angle.
</p>
</html>", revisions="<html>
<ul>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Add RealConnector for coefficient for forced convection at exterior surface.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
August 24, 2018, by Damien Picard:<br/>
Add start value for linearisation.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed Reals into connectors for JModelica compatibility.
Other compatibility changes. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"), Icon(graphics={
          Rectangle(
            lineColor={255,204,51},
            lineThickness=0.5,
            extent={{-20,-2},{20,2}}),
          Polygon(
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,-40},
              {-100,30}},
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
end SolBus;

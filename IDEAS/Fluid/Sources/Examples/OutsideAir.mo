within IDEAS.Fluid.Sources.Examples;
model OutsideAir
  "Test model for source and sink with outside weather data and coupling with sim"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air "Medium model for air";

  parameter Modelica.Units.SI.Angle incAngSurNor[:]=
    {0, 45, 90, 135, 180, 225, 270, 315}*2*Modelica.Constants.pi/360
    "Wind incidence angles";
  parameter Real Cp[:] = {0.4, 0.1, -0.3, -0.35, -0.2, -0.35, -0.3, 0.1}
    "Cp values";
  IDEAS.Fluid.Sources.OutsideAir     west(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.W) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  IDEAS.Fluid.Sources.OutsideAir     north(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.N) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-4,40},{16,60}})));
  IDEAS.Fluid.Sources.OutsideAir     south(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.S) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
  IDEAS.Fluid.Sources.OutsideAir     east(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.E) "Model with outside conditions"
    annotation (Placement(transformation(extent={{40,-2},{60,18}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  annotation (__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Sources/Examples/OutsideAir.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of a source for ambient conditions that computes
the wind pressure on a facade of a building using a user-defined wind pressure profile.
Weather data are used for San Francisco, for a period of a week
where the wind blows primarily from North-West.
The plot shows that the wind pressure on the north- and west-facing
facade is positive,
whereas it is negative for the south- and east-facing facades.
</p>
</html>", revisions="<html>
<ul>
<li>
February 2, 2022, by Michael Wetter:<br/>
Revised implementation.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1436\">IBPSA, #1436</a>.
</li>
<li>
Jun 28, 2021 by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StartTime=1.728e+07,
      StopTime=1.78848e+07,
      Tolerance=1e-6));
end OutsideAir;

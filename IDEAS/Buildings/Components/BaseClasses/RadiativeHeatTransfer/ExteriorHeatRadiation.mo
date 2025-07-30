within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ExteriorHeatRadiation
  "longwave radiative heat exchange of an exterior surface with the environment"
  parameter Modelica.Units.SI.Area A "Surface area of heat exchange surface";
  parameter Modelica.Units.SI.Temperature Tenv_nom=280
    "Nominal temperature of environment"
    annotation (Dialog(group="Linearisation", enable=linearise));
  parameter Boolean linearise=true "If true, linearise radiative heat transfer";
  parameter Modelica.Units.SI.Emissivity epsLw "Long wave emissivity";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Tenv
    "Radiative temperature of the environment"
    annotation (Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature block"
    annotation (Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.HeatRadiation
    heaRad(
    final R=R,
    final Tzone_nom=Tenv_nom,
    dT_nom=5,
    final linearise=linearise) "Component for computing radiative heat "
    annotation (Placement(visible = true, transformation(origin = {0, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));

protected
  parameter Real R(fixed=false);


initial equation
  R=1/(Modelica.Constants.sigma*A*epsLw);

equation
  connect(preTem.port, heaRad.port_b) annotation (
    Line(points={{-40,0},{-10,0}},                                                    color = {191, 0, 0}));
  connect(heaRad.port_a, port_a) annotation (
    Line(points = {{10, 0}, {100, 0}}, color = {191, 0, 0}));
  connect(preTem.T, Tenv) annotation (
    Line(points = {{-62, 0}, {-100, 0}}, color = {0, 0, 127}));
  annotation (Icon(graphics={
        Line(points={{-40,10},{40,10}}, color={191,0,0}),
        Line(points={{-40,10},{-30,16}}, color={191,0,0}),
        Line(points={{-40,10},{-30,4}}, color={191,0,0}),
        Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
        Line(points={{30,-16},{40,-10}}, color={191,0,0}),
        Line(points={{30,-4},{40,-10}}, color={191,0,0}),
        Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
        Line(points={{-40,30},{40,30}}, color={191,0,0}),
        Line(points={{30,24},{40,30}}, color={191,0,0}),
        Line(points={{30,36},{40,30}}, color={191,0,0}),
        Rectangle(fillColor = {192, 192, 192}, pattern = LinePattern.None, fillPattern = FillPattern.Backward, extent = {{-90, 80}, {-60, -80}}),
        Line(points = {{-60, 80}, {-60, -80}}, thickness = 0.5),
        Rectangle(fillColor = {192, 192, 192}, pattern = LinePattern.None, fillPattern = FillPattern.Backward, extent = {{90, 80}, {60, -80}}),
        Line(points = {{60, 80}, {60, -80}}, thickness = 0.5)}), Documentation(info="<html>
<p>Longwave radiation <i>Q&#775;<sub>lw</sub></i> between the surface and the environment is determined according to the Stefan-Boltzmann law as</p>
<p><i>Q&#775;<sub>lw</sub> = &sigma; &#183; &epsilon;<sub>lw</sub> &#183; A &#183; (T<sub>s</sub><sup>4</sup> - F<sub>sky</sub> &#183; T<sub>sky</sub><sup>4</sup> - (1 - F<sub>sky</sub>) &#183; T<sub>db</sub><sup>4</sup>)</i></p>
<p>where</p>
<ul>
<li><i>&sigma;</i> is the Stefan-Boltzmann constant [Mohr 2008],</li>
<li><i>&epsilon;<sub>lw</sub></i> is the longwave emissivity of the exterior surface <i>A</i>,</li> 
<li><i>F<sub>sky</sub></i> is the radiant-interchange configuration factor between the surface and sky [Hamilton 1952], and the surface and the environment, respectively, and</li> 
<li><i>T<sub>s</sub></i> and <i>T<sub>sky</sub></i> are the exterior surface and sky temperature, respectively.</li>
</ul>
<p>Shortwave solar irradiation absorbed by the exterior surface <i>Q&#775;<sub>sw</sub></i> is determined as </p>
<p><i>Q&#775;<sub>sw</sub> = &epsilon;<sub>sw</sub> &#183; A &#183; E<sub>sw</sub></i></p>
<p>where</p> 
<ul>
<li><i>&epsilon;<sub>sw</sub></i> is the shortwave absorption of the surface <i>A</i>, and</li>
<li><i>E<sub>sw</sub></i> the total irradiation on the depicted surface.</li>
</ul>
<h4>References</h4>
<p>
[Hamilton 1952]: D.C. Hamilton, W.R. Morgan, \"Radiant-interchange configuration factors\", <i>Technical Report &ndash; National Advisory Committee for Aeronautics</i>, 1952.<br>
[Mohr 2008]: P.J. Mohr, B.N. Taylor, D.B. Newell, \"CODATA Recommended values of the fundamental physical constants: 2006\", <i>Review of Modern Physics</i>, vol. 80, pp. 633&ndash;730, 2008.
</p>
</html>", revisions="<html>
<ul>
<li>
June 17, 2025, by Lucas Verleyen:<br/>
Replaced images with inline equations.
See <a href=https://github.com/open-ideas/IDEAS/issues/1440>#1440</a>.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end ExteriorHeatRadiation;

within IDEAS.Fluid.Taps.Examples;
model Tap "Example with two 'Tap' models"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  Modelica.Blocks.Sources.Pulse m_flow_set1(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=5000,
    offset=0) annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Sources.Ramp step(
    startTime=86400,
    height=-30,
    duration=50000,
    offset=273.15 + 70)
    annotation (Placement(transformation(extent={{-90,-14},{-70,6}})));
  IDEAS.Fluid.Taps.Tap tap1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  IDEAS.Fluid.Taps.Tap tap2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium, use_T_in=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Medium,
      nPorts=2)
    annotation (Placement(transformation(extent={{60,10},{40,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_set2(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=2500,
    offset=0)       annotation (Placement(transformation(extent={{-30,-70},{-10,
            -50}})));
equation

  connect(step.y, bou1.T_in)
    annotation (Line(points={{-69,-4},{-62,-4}}, color={0,0,127}));
  connect(m_flow_set1.y, tap1.mDHWSet)
    annotation (Line(points={{-9,60},{0,60},{0,30}},   color={0,0,127}));
  connect(m_flow_set2.y, tap2.mDHWSet)
    annotation (Line(points={{-9,-60},{0,-60},{0,-30}},   color={0,0,127}));
  connect(tap1.port_b, bou2.ports[1]) annotation (Line(points={{10,20},{30,20},
          {30,1},{40,1}}, color={0,127,255}));
  connect(tap2.port_b, bou2.ports[2]) annotation (Line(points={{10,-20},{30,-20},
          {30,-1},{40,-1}}, color={0,127,255}));
  connect(tap1.port_a, bou1.ports[1]) annotation (Line(points={{-10,20},{-30,20},
          {-30,1},{-40,1}}, color={0,127,255}));
  connect(tap2.port_a, bou1.ports[2]) annotation (Line(points={{-10,-20},{-30,
          -20},{-30,-1},{-40,-1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=259200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>Initial implementation.
<br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> 
for more information. </li>
</ul>
</html>"));
end Tap;

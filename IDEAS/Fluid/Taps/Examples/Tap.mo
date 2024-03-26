within IDEAS.Fluid.Taps.Examples;
model Tap "Example with two 'Tap' models"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  Modelica.Blocks.Sources.Pulse mFloSet1(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=5000,
    offset=0) annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Blocks.Sources.Ramp step(
    startTime=86400,
    height=-30,
    duration=50000,
    offset=273.15 + 70)
    annotation (Placement(transformation(extent={{-90,-14},{-70,6}})));
  IDEAS.Fluid.Taps.Tap tap1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  IDEAS.Fluid.Taps.Tap tap2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-10},{40,-30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium, use_T_in=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Medium,
                                       nPorts=2)
    annotation (Placement(transformation(extent={{90,10},{70,-10}})));
  Modelica.Blocks.Sources.Pulse mFloSet2(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=2500,
    offset=0)       annotation (Placement(transformation(extent={{0,-70},{20,
            -50}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation

  connect(tap1.port_cold, bou2.ports[1]) annotation (Line(points={{40,20},{58,
          20},{58,1},{70,1}},
                          color={0,127,255}));
  connect(tap2.port_cold, bou2.ports[2]) annotation (Line(points={{40,-20},{58,
          -20},{58,-1},{70,-1}},
                            color={0,127,255}));
  connect(step.y, bou1.T_in)
    annotation (Line(points={{-69,-4},{-62,-4}}, color={0,0,127}));
  connect(mFloSet1.y, tap1.mDHWSet)
    annotation (Line(points={{21,60},{30,60},{30,30}},color={0,0,127}));
  connect(mFloSet2.y, tap2.mDHWSet)
    annotation (Line(points={{21,-60},{30,-60},{30,-30}},color={0,0,127}));
  connect(senTem1.port_b, tap1.port_hot)
    annotation (Line(points={{0,20},{20,20}}, color={0,127,255}));
  connect(senTem1.T, tap1.THot) annotation (Line(points={{-10,31},{-10,36},{12,
          36},{12,27},{20,27}}, color={0,0,127}));
  connect(senTem2.port_b, tap2.port_hot)
    annotation (Line(points={{0,-20},{20,-20}}, color={0,127,255}));
  connect(senTem2.T, tap2.THot) annotation (Line(points={{-10,-31},{-10,-36},{
          12,-36},{12,-27},{20,-27}}, color={0,0,127}));
  connect(senTem1.port_a, bou1.ports[1]) annotation (Line(points={{-20,20},{-34,
          20},{-34,1},{-40,1}}, color={0,127,255}));
  connect(senTem2.port_a, bou1.ports[2]) annotation (Line(points={{-20,-20},{
          -34,-20},{-34,-1},{-40,-1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=259200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>Initial implementation.<br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for more information. </li>
</ul>
</html>"));
end Tap;

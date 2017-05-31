within IDEAS.Fluid.HeatExchangers.Examples;
model HeatExchanger
  extends Modelica.Icons.Example;

  NTUHeatExchanger hex(
    redeclare package Medium1 = IDEAS.Media.Water,
    redeclare package Medium2 = IDEAS.Media.Water,
    m1_flow_nominal=8,
    m2_flow_nominal=4,
    dp1_nominal=600,
    dp2_nominal=600,
    U=5302,
    A=27.8) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-2})));
  Sources.Boundary_pT primary_a1(
    redeclare package Medium = IDEAS.Media.Water,
    nPorts=1,
    p=200000,
    T=284.15) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Sources.Boundary_pT secondary_a2(
    redeclare package Medium = IDEAS.Media.Water,
    nPorts=1,
    p=200000) annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
  Sources.Boundary_pT primary_b1(redeclare package Medium = IDEAS.Media.Water,
      nPorts=1)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Sources.Boundary_pT secondary_b2(
    redeclare package Medium = IDEAS.Media.Water,
    nPorts=1,
    T=285.15) annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Movers.FlowControlled_m_flow primary_pump(
    redeclare package Medium = IDEAS.Media.Water,
    m_flow_nominal=8,
    constantMassFlowRate=8)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = IDEAS.Media.Water,
    m_flow_nominal=4,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    constantMassFlowRate=4)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Step step(
    startTime=60,
    height=4,
    offset=4) annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
equation
  connect(primary_a1.ports[1], primary_pump.port_a)
    annotation (Line(points={{-60,30},{-52,30},{-40,30}}, color={0,127,255}));
  connect(primary_pump.port_b, hex.port_a1) annotation (Line(points={{-20,30},{
          -20,30},{-6,30},{-6,8}}, color={0,127,255}));
  connect(hex.port_b1, primary_b1.ports[1])
    annotation (Line(points={{-6,-12},{-6,-40},{-60,-40}}, color={0,127,255}));
  connect(secondary_b2.ports[1], fan1.port_b)
    annotation (Line(points={{60,30},{40,30}}, color={0,127,255}));
  connect(fan1.port_a, hex.port_b2)
    annotation (Line(points={{20,30},{6,30},{6,8}}, color={0,127,255}));
  connect(secondary_a2.ports[1], hex.port_a2)
    annotation (Line(points={{60,-40},{6,-40},{6,-12}}, color={0,127,255}));
  connect(step.y, primary_pump.m_flow_in) annotation (Line(points={{-41,70},{
          -30.2,70},{-30.2,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Example of heat exchanger</p>
</html>", revisions="<html>
<ul>
<li>May 29, 2017, by Iago Cupeiro:</li>
</ul>
<p>First implementation. </p>
</html>"));
end HeatExchanger;
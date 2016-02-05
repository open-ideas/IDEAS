within IDEAS.Fluid.Valves.Examples;
model ThreeWayValveMotor
  import IDEAS;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);

protected
  IDEAS.Fluid.Movers.Pump pumpFlow1(
    useInput=true,
    dpFix=0,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    m=1)     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-72,0})));
public
  Modelica.Blocks.Sources.Constant flow_pump(k=1)
        annotation (Placement(transformation(extent={{-98,60},{-78,80}})));
  Modelica.Blocks.Sources.Sine     ctrl(freqHz=0.1,
    amplitude=0.5,
    offset=0.5)
        annotation (Placement(transformation(extent={{-32,58},{-12,78}})));
  Sources.Boundary_pT sink(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{-58,-70},{-78,-50}})));
  Sources.Boundary_pT hot(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=333.15) annotation (Placement(transformation(extent={{78,-10},{58,10}})));
  IDEAS.Fluid.Valves.ThreeWayValveMotor threeWayValveMotor(m_flow_nominal=1,
      redeclare package Medium = Medium,
    m=0.1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Sources.Boundary_pT cold(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=283.15) annotation (Placement(transformation(extent={{80,-70},{60,-50}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-24,-10},{-44,10}})));
equation
  connect(flow_pump.y, pumpFlow1.m_flowSet)
                                         annotation (Line(
      points={{-77,70},{-72,70},{-72,10.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sink.ports[1], pumpFlow1.port_b) annotation (Line(
      points={{-78,-60},{-88,-60},{-88,0},{-82,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(threeWayValveMotor.port_a1, hot.ports[1]) annotation (Line(
      points={{10,0},{58,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cold.ports[1], threeWayValveMotor.port_a2) annotation (Line(
      points={{60,-60},{0,-60},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ctrl.y, threeWayValveMotor.ctrl) annotation (Line(
      points={{-11,68},{1,68},{1,9.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pumpFlow1.port_a, temperature.port_b) annotation (Line(
      points={{-62,0},{-44,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature.port_a, threeWayValveMotor.port_b) annotation (Line(
      points={{-24,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end ThreeWayValveMotor;

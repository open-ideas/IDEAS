within IDEAS.Fluid.Valves.Examples;
model Thermostatic3WayValve "Example of a thermostatic three way valve"
  extends Modelica.Icons.Example;
  IDEAS.Fluid.Valves.Thermostatic3WayValve thermostatic3WayValve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dynamicValve=false,
    m=0.001) annotation (Placement(transformation(extent={{8,8},{28,28}})));
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  parameter SI.MassFlowRate m_flow_nominal=2 "Nominal mass flow rate";
  Movers.Pump pump(redeclare package Medium = Medium, m_flow_nominal=
        m_flow_nominal,
    useInput=true,
    m=0.001)
    annotation (Placement(transformation(extent={{38,8},{58,28}})));
  Sources.Boundary_pT sou1(
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    p=100000,
    T=333.15) annotation (Placement(transformation(extent={{-56,8},{-36,28}})));

  Sensors.TemperatureTwoPort T_out(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0.01) annotation (Placement(transformation(extent={{64,12},{76,24}})));
  inner Modelica.Fluid.System system(
    p_ambient=300000,
    T_ambient=313.15)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Ramp TSou1(
    height=30,
    duration=10,
    offset=283.15)
    annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
  Sources.Boundary_pT sou2(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=2,
    p=100000,
    T=333.15)
    annotation (Placement(transformation(extent={{-56,-30},{-36,-10}})));
  Modelica.Blocks.Sources.Constant
                               TSou2(k=303.15)
    annotation (Placement(transformation(extent={{-92,-26},{-72,-6}})));
  Modelica.Blocks.Sources.Constant mFlowPump(k=1)
    annotation (Placement(transformation(extent={{80,36},{60,56}})));
  Modelica.Blocks.Sources.Constant TSet(k=293.15)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation

  connect(thermostatic3WayValve.port_b, pump.port_a) annotation (Line(
      points={{28,18},{38,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou1.ports[1], thermostatic3WayValve.port_a1) annotation (Line(
      points={{-36,18},{8,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, T_out.port_a) annotation (Line(
      points={{58,18},{64,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSou2.y, sou2.T_in) annotation (Line(
      points={{-71,-16},{-58,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFlowPump.y, pump.m_flowSet) annotation (Line(
      points={{59,46},{48,46},{48,28.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sou2.ports[1], thermostatic3WayValve.port_a2) annotation (Line(
      points={{-36,-18},{18,-18},{18,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_out.port_b, sou2.ports[2]) annotation (Line(
      points={{76,18},{86,18},{86,-22},{-36,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet.y, thermostatic3WayValve.TMixedSet) annotation (Line(
      points={{11,40},{18,40},{18,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSou1.y, sou1.T_in) annotation (Line(
      points={{-71,22},{-58,22}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Documentation(revisions="<html>
<ul>
<li>
March 2014 by Filip Jorissen:<br/>
First implementation.
</li>
<li>
May 2014 by Filip Jorissen:<br/>
Changed implementation for more flexible 3wayvalve
</li>
</ul>
</html>"),
    experiment(StopTime=15),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Valves/Examples/Thermostatic3WayValve.mos"
        "Simulate and plot"));
end Thermostatic3WayValve;

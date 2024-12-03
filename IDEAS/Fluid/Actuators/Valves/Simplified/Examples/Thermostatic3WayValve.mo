within IDEAS.Fluid.Actuators.Valves.Simplified.Examples;
model Thermostatic3WayValve "Example of a thermostatic three way valve"
  extends Modelica.Icons.Example;
  IDEAS.Fluid.Actuators.Valves.Simplified.Thermostatic3WayValve thermostatic3WayValve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dynamicValve=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                        annotation (Placement(transformation(extent={{8,8},{28,28}})));
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  parameter SI.MassFlowRate m_flow_nominal=2 "Nominal mass flow rate";

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    use_riseTime=false,
    m_flow_nominal=m_flow_nominal,
    tau=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
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
  Modelica.Blocks.Sources.Constant mFlowPump(k=m_flow_nominal)
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
  connect(sou2.ports[1], thermostatic3WayValve.port_a2) annotation (Line(
      points={{-36,-21},{18,-21},{18,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_out.port_b, sou2.ports[2]) annotation (Line(
      points={{76,18},{86,18},{86,-19},{-36,-19}},
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
  connect(mFlowPump.y, pump.m_flow_in)
    annotation (Line(points={{59,46},{48,46},{48,30}},     color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),     Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1926\">IBPSA, #1926</a>).
</li>
<li>
May 15, 2018, by Filip Jorissen:<br/>
Changes for setting unique initial conditions.
</li>
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
    experiment(StopTime=15, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Actuators/Valves/Simplified/Examples/Thermostatic3WayValve.mos"
        "Simulate and plot"));
end Thermostatic3WayValve;

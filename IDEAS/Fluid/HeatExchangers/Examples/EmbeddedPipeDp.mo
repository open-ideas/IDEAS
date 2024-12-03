within IDEAS.Fluid.HeatExchangers.Examples;
model EmbeddedPipeDp "Testing pressure drop of embeddedpipe"

  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=0.1,
    dp_nominal=100000,
    m_flow(start=12*24/3600),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=303.15)
    annotation (Placement(transformation(extent={{-36,-14},{-16,6}})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=7200,
    offset=0,
    startTime=0,
    amplitude=0.1)
    annotation (Placement(transformation(extent={{-88,30},{-68,50}})));
  RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    m_flow_nominal=12*24/3600,
    m_flowMin=0.1,
    A_floor=10,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{64,-16},{84,4}})));

  Sources.Boundary_ph bou(nPorts=2, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{120,-70},{100,-50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
                                                   T=60, y_start=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-54,30},{-34,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature prescribedTemperature(
      T=293.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={42,90})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,50})));
  BaseClasses.NakedTabs nakedTabs(redeclare BaseClasses.RadSlaCha_ValidationEmpa radSlaCha,
    C1(each T(fixed=true)),
    C2(each T(fixed=true)))
    annotation (Placement(transformation(extent={{62,16},{82,36}})));
  Modelica.Blocks.Sources.RealExpression convTabs(y=11)
    "\"convection coefficient for the tabs\""
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
equation

  connect(bou.ports[1], pump.port_a) annotation (Line(
      points={{100,-61},{100,-76},{-52,-76},{-52,-4},{-36,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse.y, firstOrder1.u) annotation (Line(
      points={{-67,40},{-56,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_b, embeddedPipe.port_a) annotation (Line(
      points={{-16,-4},{24,-4},{24,-6},{64,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[2], embeddedPipe.port_b) annotation (Line(
      points={{100,-59},{100,-6},{84,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(firstOrder1.y, pump.m_flow_in)
    annotation (Line(points={{-33,40},{-26,40},{-26,8}},     color={0,0,127}));
  connect(convection.fluid,prescribedTemperature. port) annotation (Line(
      points={{42,60},{42,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convection.solid,nakedTabs. port_a) annotation (Line(
      points={{42,40},{42,36},{72,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nakedTabs.port_b,convection. solid) annotation (Line(
      points={{72,16.2},{72,14},{86,14},{86,40},{42,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convTabs.y,convection. Gc) annotation (Line(
      points={{11,50},{32,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(embeddedPipe.heatPortEmb[1],nakedTabs. portCore) annotation (Line(
      points={{74,4},{74,10},{62,10},{62,26}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}})),
    experiment(StopTime=10000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{140,100}})),
    Documentation(revisions="<html>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a>.
</li>
</html>"));
end EmbeddedPipeDp;

within IDEAS.Buildings.Examples;
model ScreenComparison "Comparison between a model with and without screen"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
   replaceable package Medium = IDEAS.Media.Air;
  parameter SI.MassFlowRate m_flow_nominal = zoneWithScreen.V*1.2*ACH/3600
    "Nominal mass flow rate of trickle vent";
  parameter Real ACH = 1
    "Ventilation air change rate";
  IDEAS.Buildings.Validation.Cases.Case900Template zoneWithScreen(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight
      interzonalAirFlow,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingA,
    fracA=0.15,
    shaTypA(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Screen,
      hWin=3,
      wWin=4,
      shaCorr=0.05),
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypA,
    winA(use_trickle_vent=true, m_flow_nominal=m_flow_nominal))
    "Zone with a screen for its window"
    annotation (Placement(transformation(extent={{-40,-12},{-20,8}})));

  Modelica.Blocks.Sources.Constant screenCtrl(k=1) "Screen control signal"
    annotation (Placement(transformation(extent={{-88,-44},{-68,-24}})));

  Validation.Cases.Case900Template zoneWithoutScreen(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight
      interzonalAirFlow,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingA,
    fracA=0.15,
    shaTypA(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.None,
      hWin=3,
      wWin=4),
    redeclare Data.Frames.AluminumInsulated fraTypA,
    winA(use_trickle_vent=true, m_flow_nominal=m_flow_nominal))
    "Zone without a screen for its window"
    annotation (Placement(transformation(extent={{20,-12},{40,8}})));

  IDEAS.Fluid.Sources.OutsideAir outsideAir(
    redeclare package Medium = Medium,
    azi=0,                            nPorts=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_riseTime=false,
    m_flow_nominal=m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=5) "Fan" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));

  IDEAS.Fluid.Movers.FlowControlled_m_flow fan2(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_riseTime=false,
    m_flow_nominal=m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=5) "Fan" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,30})));
equation
  connect(zoneWithScreen.ctrlA, screenCtrl.y);

  connect(zoneWithScreen.ports[1], fan1.port_a)
    annotation (Line(points={{-30,8},{-30,20}}, color={0,127,255}));
  connect(fan1.port_b, outsideAir.ports[1])
    annotation (Line(points={{-30,40},{-30,60},{-1,60}}, color={0,127,255}));
  connect(zoneWithoutScreen.ports[1], fan2.port_a)
    annotation (Line(points={{30,8},{30,20}}, color={0,127,255}));
  connect(fan2.port_b, outsideAir.ports[2])
    annotation (Line(points={{30,40},{30,60},{1,60}}, color={0,127,255}));
  annotation (
    experiment(
      StartTime=10000000,
      StopTime=12000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1926\">IBPSA, #1926</a>).
</li>
<li>
July 18th, 2022 by Filip Jorissen<br/>
First implementation for #1270.
</li>
</ul>
</html>", info="<html>
<p>
Illustration of how the rectangularzonetemplate can be equipped with a screen. 
At the same time, the influence of the screen on the zone temperature is shown.
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/ScreenComparison.mos"
        "Simulate and plot"));
end ScreenComparison;

within IDEAS.Fluid.HeatPumps.Examples;
model HeatPump_AirWater
  "General example and tester for a modulating air-to-water heat pump"
  extends Modelica.Icons.Example;

  package Medium = IDEAS.Media.Water;

  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.2
    "Nominal mass flow rate";

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=30,
    use_riseTime=false,
    m_flow_nominal=m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  IDEAS.Fluid.HeatPumps.HP_AirWater_TSet heaPum(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    tauHeatLoss=3600,
    CDry=10000,
    mWater=4,
    QNom=12000,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-94,-20},{-80,-6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 30)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 35) "Temperature set point"
    annotation (Placement(transformation(extent={{-40,50},{-60,70}})));

equation
  connect(heaPum.heatPort, fixedTemperature.port) annotation (Line(
      points={{-70,20},{-70,-13},{-80,-13}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-79,-50},{-62,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_b,heaPum. port_a) annotation (Line(
      points={{-30,-20},{-60,-20},{-60,24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Tset.y,heaPum. TSet) annotation (Line(points={{-61,60},{-76,60},{-76,42}},
                color={0,0,127}));
  connect(pump.port_a,heaPum. port_b) annotation (Line(points={{-10,-20},{10,-20},{10,36},{-60,36}},
                                  color={0,127,255}));
  connect(bou.ports[1], pump.port_a) annotation (Line(points={{20,-10},{10,-10},{10,-20},{-10,-20}},
                              color={0,127,255}));
  connect(TReturn.port, pump.heatPort) annotation (Line(points={{-40,-50},{-20,-50},{-20,-26.8}},
                             color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=15000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
      100}})),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump_AirWater.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example shows the modulation behaviour of 
an inverter controlled air-to-water heat pump when the inlet water temperature is changed.
</p>
<p>
The modulation level can be seen from <code>heaPum.heatSource.modulation</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 27, 2026, by Jelger Jansen:<br/>
Revise and clean up model.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1485\">#1485</a>.
</li>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1926\">IBPSA, #1926</a>).
</li>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end HeatPump_AirWater;

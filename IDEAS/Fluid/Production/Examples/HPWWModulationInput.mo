within IDEAS.Fluid.Production.Examples;
model HPWWModulationInput "Test of a heat pump using a temperature setpoint"
  import Buildings;
  import IDEAS;
  extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  constant SI.MassFlowRate m_flow_nominal=0.3 "Nominal mass flow rate";

  Movers.Pump             pump(
    m=1,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    useInput=true,
    filteredMassFlowRate=true,
    riseTime=10)
    annotation (Placement(transformation(extent={{46,-30},{26,-10}})));
  FixedResistances.Pipe_Insulated             pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    UA=100)
    annotation (Placement(transformation(extent={{90,-24},{70,-16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
  inner SimInfoManager       sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 15)
    annotation (Placement(transformation(extent={{12,-70},{32,-50}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={94,42})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 30)
    annotation (Placement(transformation(extent={{72,50},{52,70}})));
  Sensors.TemperatureTwoPort             senTemBoiler_out(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,18},{30,38}})));
  Sensors.TemperatureTwoPort             senTemBoiler_in(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{20,-28},{4,-12}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    startTime=2000,
    amplitude=-1,
    period=500,
    offset=1) annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Blocks.Sources.BooleanPulse
                                pulse(
    startTime=2000,
    period=500)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-84,-34},{-76,-26}})));
  IDEAS.Fluid.Production.HeatPumpWaterWater heatPumpWaterWater(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    QNom=10000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-26,0})));
  Buildings.Controls.Continuous.LimPID conPID(yMax=100)
    annotation (Placement(transformation(extent={{30,50},{10,70}})));
  IDEAS.Fluid.Movers.Pump
                    pump1(
    m=1,
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    useInput=true)
    annotation (Placement(transformation(extent={{-74,10},{-54,30}})));
  IDEAS.Fluid.Sources.Boundary_pT
                      bou1(         redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-86,12},{-78,4}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=4,
    offset=273.15 + 10,
    freqHz=1/300,
    startTime=0)
    annotation (Placement(transformation(extent={{-116,-4},{-108,4}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort
                             TBrine_out(redeclare package Medium = Medium,
      m_flow_nominal=4200/3600)
    annotation (Placement(transformation(extent={{-44,-30},{-64,-10}})));
  Sensors.TemperatureTwoPort T1in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-48,16},{-40,24}})));
equation
  connect(TReturn.port,pipe. heatPort) annotation (Line(
      points={{72,-60},{80,-60},{80,-24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y,TReturn. T) annotation (Line(
      points={{33,-60},{50,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b,pump. port_a) annotation (Line(
      points={{70,-20},{46,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b,pipe. port_a) annotation (Line(
      points={{30,28},{100,28},{100,-20},{90,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b,senTemBoiler_in. port_a) annotation (Line(
      points={{26,-20},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse1.y,pump. m_flowSet) annotation (Line(
      points={{49,0},{36,0},{36,-9.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y,not1. u) annotation (Line(
      points={{-99,-30},{-84.8,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(heatPumpWaterWater.port_b2, senTemBoiler_out.port_a)
    annotation (Line(points={{-20,10},{-20,28},{10,28}}, color={0,127,255}));
  connect(heatPumpWaterWater.port_a2, senTemBoiler_in.port_b)
    annotation (Line(points={{-20,-10},{-20,-20},{4,-20}}, color={0,127,255}));
  connect(heatPumpWaterWater.heatPort, fixedTemperature.port) annotation (Line(
        points={{-16,-4.44089e-016},{-10,-4.44089e-016},{-10,0},{-10,-60},{-24,
          -60}}, color={191,0,0}));
  connect(realExpression.y, conPID.u_s)
    annotation (Line(points={{51,60},{32,60}}, color={0,0,127}));
  connect(senTemBoiler_out.T, conPID.u_m)
    annotation (Line(points={{20,39},{20,48}}, color={0,0,127}));
  connect(conPID.y, heatPumpWaterWater.uModulation) annotation (Line(points={{9,
          60},{-52,60},{-52,6},{-36.8,6}}, color={0,0,127}));
  connect(sine1.y,bou1. T_in) annotation (Line(
      points={{-107.6,0},{-100,0},{-100,6.4},{-86.8,6.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou1.ports[1], pump1.port_a)
    annotation (Line(points={{-78,8},{-74,8},{-74,20}}, color={0,127,255}));
  connect(pulse1.y, pump1.m_flowSet) annotation (Line(points={{49,0},{0,0},{0,
          36},{-64,36},{-64,30.4}}, color={0,0,127}));
  connect(not1.y, heatPumpWaterWater.on) annotation (Line(points={{-75.6,-30},{
          -66,-30},{-66,2},{-36.8,2}}, color={255,0,255}));
  connect(heatPumpWaterWater.port_b1, TBrine_out.port_a) annotation (Line(
        points={{-32,-10},{-32,-20},{-44,-20}}, color={0,127,255}));
  connect(TBrine_out.port_b, pump1.port_a) annotation (Line(points={{-64,-20},{
          -74,-20},{-74,20}}, color={0,127,255}));
  connect(bou.ports[1], pipe.port_a) annotation (Line(points={{94,36},{94,28},{
          100,28},{100,-20},{90,-20}}, color={0,127,255}));
  connect(pump1.port_b, T1in.port_a)
    annotation (Line(points={{-54,20},{-48,20}}, color={0,127,255}));
  connect(T1in.port_b, heatPumpWaterWater.port_a1)
    annotation (Line(points={{-40,20},{-32,20},{-32,10}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}})),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Production/Examples/HeatPump_WaterWaterTSet.mos"
        "Simulate and plot"),  Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>", info="<html>
<p>This model demonstrates the use of a heat pump with a temperature set point.</p>
</html>"),
    experiment(
      StopTime=5000,
      __Dymola_fixedstepsize=1,
      __Dymola_Algorithm="Radau"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-120,-100},{120,100}})));
end HPWWModulationInput;

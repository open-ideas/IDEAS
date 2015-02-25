within IDEAS.Fluid.Production.Examples;
model Boiler
  "General example and tester for a modulating air-to-water heat pump"
  import IDEAS;

  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);

  IDEAS.Fluid.Movers.Pump pump(
    m=1,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    useInput=true,
    filteredMassFlowRate=true,
    riseTime=10)
    annotation (Placement(transformation(extent={{10,-22},{-10,-2}})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    UA=100)
    annotation (Placement(transformation(extent={{56,-22},{36,-2}})));
  IDEAS.Fluid.Production.Boiler                    heater(
    tauHeatLoss=3600,
    cDry=10000,
    mWater=4,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    QNom=5000,
    redeclare
      IDEAS.Fluid.Production.BaseClasses.HeatSources.PerformanceMap3DHeatSource
      heatSource,
    use_onOffSignal=true)
    annotation (Placement(transformation(extent={{-50,36},{-32,16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-70,38},{-56,52}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
  //  Real PElLossesInt( start = 0, fixed = true);
  //  Real PElNoLossesInt( start = 0, fixed = true);
  //  Real QUsefulLossesInt( start = 0, fixed = true);
  //  Real QUsefulNoLossesInt( start = 0, fixed = true);
  //  Real SPFLosses( start = 0);
  //  Real SPFNoLosses( start = 0);
  //
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 15)
    annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
  Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium,
    p=200000)
    annotation (Placement(transformation(extent={{16,10},{-4,30}})));
  constant SI.MassFlowRate m_flow_nominal=0.15 "Nominal mass flow rate";
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 50)
    annotation (Placement(transformation(extent={{-72,-2},{-52,18}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemBoiler_out(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,28},{-6,48}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemBoiler_in(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-14,-20},{-30,-4}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    startTime=2000,
    amplitude=-1,
    period=500,
    offset=1) annotation (Placement(transformation(extent={{58,6},{38,26}})));
  Modelica.Blocks.Sources.BooleanPulse
                                pulse(
    startTime=2000,
    period=500)
    annotation (Placement(transformation(extent={{-92,-22},{-72,-2}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-58,-16},{-50,-8}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;

  connect(heater.heatPort, fixedTemperature.port) annotation (Line(
      points={{-44.6,36},{-44,36},{-44,44},{-50,44},{-50,45},{-56,45}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TReturn.port, pipe.heatPort) annotation (Line(
      points={{4,-50},{46,-50},{46,-22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-37,-50},{-18,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, pump.port_a) annotation (Line(
      points={{36,-12},{10,-12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(bou.ports[1], heater.port_a) annotation (Line(
      points={{-4,20},{-18,20},{-18,30},{-32,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression.y, heater.TSet) annotation (Line(
      points={{-51,8},{-38.03,8},{-38.03,15.3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heater.port_b, senTemBoiler_out.port_a) annotation (Line(
      points={{-32,22},{-32,38},{-26,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b, pipe.port_a) annotation (Line(
      points={{-6,38},{72,38},{72,-12},{56,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{-10,-12},{-14,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_in.port_b, heater.port_a) annotation (Line(
      points={{-30,-12},{-32,-12},{-32,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse1.y, pump.m_flowSet) annotation (Line(
      points={{37,16},{24,16},{24,4},{0,4},{0,-1.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, not1.u) annotation (Line(
      points={{-71,-12},{-58.8,-12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, heater.on) annotation (Line(
      points={{-49.6,-12},{-42,-12},{-42,-2},{-42.8,-2},{-42.8,15.2}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(StopTime=15000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Commands(file="Scripts/Tester_Boiler.mos" "TestModel"),
    Documentation(info="<html>
<p>This example shows the modulation behaviour of an inverter controlled air-to-water heat pump when the inlet water temperature is changed. </p>
<p>The modulation level can be seen from heater.heatSource.modulation.</p>
</html>", revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end Boiler;

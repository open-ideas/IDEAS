within IDEAS.Fluid.Production.Examples;
model NewBoiler
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
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-94,6},{-80,20}})));
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
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{16,10},{-4,30}})));
  constant SI.MassFlowRate m_flow_nominal=0.15 "Nominal mass flow rate";
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 50)
    annotation (Placement(transformation(extent={{-84,44},{-64,64}})));
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
  IDEAS.Fluid.Production.NewHeatPumpAirWater newBoiler(m_flow_nominal=
        m_flow_nominal, QNom=1500)
    annotation (Placement(transformation(extent={{-58,10},{-38,30}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;

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
  connect(senTemBoiler_out.port_b, pipe.port_a) annotation (Line(
      points={{-6,38},{72,38},{72,-12},{56,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{-10,-12},{-14,-12}},
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
  connect(newBoiler.port_b, senTemBoiler_out.port_a) annotation (Line(
      points={{-38,24},{-32,24},{-32,38},{-26,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(newBoiler.port_a, senTemBoiler_in.port_b) annotation (Line(
      points={{-38,16},{-32,16},{-32,-12},{-30,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(not1.y, newBoiler.u1) annotation (Line(
      points={{-49.6,-12},{-44,-12},{-44,16},{-62,16},{-62,28.4},{-49.2,28.4}},

      color={255,0,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, newBoiler.heatPort) annotation (Line(
      points={{-80,13},{-74,13},{-74,12},{-66,12},{-66,4},{-51,4},{-51,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, newBoiler.u) annotation (Line(
      points={{-63,54},{-54,54},{-54,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[1], senTemBoiler_out.port_a) annotation (Line(
      points={{-4,20},{-32,20},{-32,38},{-26,38}},
      color={0,127,255},
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
end NewBoiler;

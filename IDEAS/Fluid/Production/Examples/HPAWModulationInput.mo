within IDEAS.Fluid.Production.Examples;
model HPAWModulationInput
  "General example and tester for a modulating air-water heat pump with a modulation input"
  import IDEAS;
  import Buildings;

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
    annotation (Placement(transformation(extent={{36,-22},{16,-2}})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    UA=100)
    annotation (Placement(transformation(extent={{80,-16},{60,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15
         + 20)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
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
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 15)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,54})));
  constant SI.MassFlowRate m_flow_nominal=0.15 "Nominal mass flow rate";
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemBoiler_out(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{0,28},{20,48}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemBoiler_in(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,-20},{-6,-4}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    startTime=2000,
    amplitude=-1,
    offset=1,
    period=500)
              annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Blocks.Sources.BooleanPulse
                                pulse(
    startTime=2000, period=500)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-64,6},{-56,14}})));
  IDEAS.Fluid.Production.HeatPumpAirWater HPAW(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    dp_nominal=0,
    useQSet=false,
    modulationInput=true,
    use_modulation_security=true,
    QNom=10000)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,12})));
  Buildings.Controls.Continuous.LimPID conPID(yMax=100, Ti=180)
    annotation (Placement(transformation(extent={{20,60},{0,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 55)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;

  connect(TReturn.port, pipe.heatPort) annotation (Line(
      points={{60,-50},{70,-50},{70,-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{21,-50},{38,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, pump.port_a) annotation (Line(
      points={{60,-12},{36,-12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b, pipe.port_a) annotation (Line(
      points={{20,38},{98,38},{98,-12},{80,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{16,-12},{10,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse1.y, pump.m_flowSet) annotation (Line(
      points={{39,10},{26,10},{26,-1.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, not1.u) annotation (Line(
      points={{-79,10},{-64.8,10}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(bou.ports[1], senTemBoiler_out.port_a) annotation (Line(
      points={{-20,44},{-20,38},{0,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HPAW.port_b, senTemBoiler_out.port_a) annotation (Line(
      points={{-30,22},{-30,38},{0,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HPAW.port_a, senTemBoiler_in.port_b) annotation (Line(
      points={{-30,2},{-30,-12},{-6,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, HPAW.heatPort) annotation (Line(
      points={{-40,-30},{-12,-30},{-12,12},{-20,12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(not1.y, HPAW.on) annotation (Line(
      points={{-55.6,10},{-40.8,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.T, conPID.u_m) annotation (Line(
      points={{10,49},{10,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, HPAW.uModulation) annotation (Line(
      points={{-1,70},{-50,70},{-50,6},{-40.8,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_s, realExpression.y) annotation (Line(
      points={{22,70},{39,70}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(StopTime=30000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
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
end HPAWModulationInput;

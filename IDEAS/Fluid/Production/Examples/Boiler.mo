within IDEAS.Fluid.Production.Examples;
model Boiler
  "General example and tester for a modulating air-to-water heat pump"
  extends Modelica.Icons.Example;

  constant SI.MassFlowRate m_flow_nominal=0.15 "Nominal mass flow rate";
  package Medium = IDEAS.Media.Water
    annotation (__Dymola_choicesAllMatching=true);

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-76,52},{-60,68}})));
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
    annotation (Placement(transformation(extent={{-24,12},{-32,20}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 50)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
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
    offset=1) annotation (Placement(transformation(extent={{32,2},{20,14}})));
  Modelica.Blocks.Sources.BooleanPulse
                                pulse(
    startTime=2000,
    period=500)
    annotation (Placement(transformation(extent={{-92,-22},{-72,-2}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-62,-16},{-54,-8}})));
  IDEAS.Fluid.Production.Boiler boiler(modulationInput=false, redeclare package
      Medium = IDEAS.Media.Water)
    annotation (Placement(transformation(extent={{-56,48},{-36,28}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Annex60.Media.Water, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{22,-22},{2,-2}})));
  IDEAS.Fluid.FixedResistances.InsulatedPipe insulatedPipe(
    redeclare package Medium = Annex60.Media.Water,
    m_flow_nominal=0.1,
    UA=100) annotation (Placement(transformation(extent={{62,-2},{42,-22}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;

  connect(sine.y, TReturn.T) annotation (Line(
      points={{-37,-50},{-18,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, not1.u) annotation (Line(
      points={{-71,-12},{-62.8,-12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, boiler.heatPort) annotation (Line(
      points={{-60,60},{-46,60},{-46,48}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, boiler.u) annotation (Line(
      points={{-59,10},{-44,10},{-44,27.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(not1.y, boiler.on) annotation (Line(
      points={{-53.6,-12},{-48,-12},{-48,27.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(boiler.port_b, senTemBoiler_out.port_a) annotation (Line(
      points={{-36,38},{-26,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_in.port_b, boiler.port_a) annotation (Line(
      points={{-30,-12},{-40,-12},{-40,20},{-56,20},{-56,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], boiler.port_a) annotation (Line(
      points={{-32,16},{-40,16},{-40,20},{-56,20},{-56,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fan.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{2,-12},{-14,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse1.y, fan.m_flow_in) annotation (Line(
      points={{19.4,8},{12.2,8},{12.2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(insulatedPipe.port_b, fan.port_a) annotation (Line(
      points={{42,-12},{22,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port, insulatedPipe.heatPort) annotation (Line(
      points={{4,-50},{52,-50},{52,-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b, insulatedPipe.port_a) annotation (Line(
      points={{-6,38},{70,38},{70,-12},{62,-12}},
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
end Boiler;

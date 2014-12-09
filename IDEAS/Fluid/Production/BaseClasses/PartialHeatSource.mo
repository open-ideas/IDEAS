within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"
  extends IDEAS.Fluid.Interfaces.OnOffInterface;

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter SI.Frequency riseTime=120
    "The time it takes to reach full/zero power when switching"
    annotation(Dialog(tab="Advanced", group="Events", enable=avoidEvents));

  //Data parameters
  parameter Modelica.SIunits.Power QNomRef = data.QNomRef
    "Nominal power of the production unit for which the data is given";
  parameter Real etaRef = data.etaRef
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Modelica.SIunits.Temperature TMax = data.TMax
    "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin = data.TMin
    "Minimum set point temperature";

  //Scalable parameters
  parameter Modelica.SIunits.Power QNom = data.QNomRef
    "The power at nominal conditions";
  parameter Real scaler = QNom/QNomRef "The scaling factor of the boiler data";
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";

  //Variables
  Real eta "Final efficiency of the heat source";
  Real release(min=0, max=1) "Stop heat production when the mass flow is zero";

  Modelica.SIunits.Power QLossesToCompensate
    "Artificial heat losses to correct the heat balance";
    Modelica.Blocks.Interfaces.RealOutput PFuel(unit="W")
    "Resulting fuel consumption" annotation (Placement(transformation(extent={{100,40},{120,60}})));

  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flow, x2=0,deltaX=m_flow_nominal/10000) * 1/scaler
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";

  //Components
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"  annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  //Inputs
  Modelica.Blocks.Interfaces.RealInput hIn "Specific enthalpy at the inlet" annotation (Placement(transformation(
          extent={{-128,60},{-88,100}}), iconTransformation(extent={{-120,48},{-96,
            72}})));
  Modelica.Blocks.Interfaces.RealInput m_flow "Condensor mass flow rate" annotation (Placement(transformation(
          extent={{-128,20},{-88,60}}), iconTransformation(extent={{-120,8},{-96,
            32}})));
  Modelica.Blocks.Interfaces.RealInput THxIn "Condensor temperature" annotation (Placement(transformation(
          extent={{-128,-60},{-88,-20}}), iconTransformation(extent={{-120,-32},
            {-96,-8}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set point temperature"
                                                                   annotation (Placement(transformation(
          extent={{-126,-102},{-86,-62}}),iconTransformation(extent={{-120,-72},
            {-96,-48}})));

  //Modulation parameters
  parameter Boolean avoidEvents = true
    "Set to true to switch heat pumps on using a continuous transition"
    annotation(Dialog(tab="Advanced", group="Events"));

  parameter Real modulationMin = data.modulationMin
    "Minimal modulation percentage";
  parameter Real modulationStart(min=modulationMin + 5) = data.modulationStart
    "Starting modulation percentage";

  //Modulation variables
  Real modulationInit
    "Initial modulation, decides on start/stop of the production unit";
  Real modulation(min=0, max=100) "Current modulation percentage";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";

  //Components
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=modulationMin,
    uHigh=modulationStart)
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal if avoidEvents
    annotation (Placement(transformation(extent={{14,46},{34,66}})));
  Modelica.Blocks.Continuous.Filter modulationRate(f_cut=5/(2*Modelica.Constants.pi*riseTime),
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    final order=2,
    final gain=1.0) if                                                                                  avoidEvents
    "Fictive modulation rate to avoid non-smooth on/off transitions causing events."
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  Modelica.Blocks.Logical.And and1 if avoidEvents
    annotation (Placement(transformation(extent={{-20,46},{0,66}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=on_internal) if avoidEvents
    annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
  Modelica.Blocks.Math.Product product if avoidEvents
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-2})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - release) if
                                                                      avoidEvents
    annotation (Placement(transformation(extent={{-40,12},{-20,32}})));
protected
  Modelica.Blocks.Interfaces.RealOutput onOff_internal_filtered;
public
  replaceable parameter PartialData                                              data constrainedby
    PartialData
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-88},
            {90,-68}})));

equation
    //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
  modulationInit = QAsked/QMax*100;
  hysteresis.u = modulationInit;
  modulation =   if avoidEvents then onOff_internal_filtered * IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) elseif hysteresis.y and noEvent(release<0.5) then IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) else 0;

  //Calcualation of the heat powers
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;

  //Final heat power of the heat source
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  if avoidEvents then
    connect(onOff_internal_filtered,modulationRate.y);
    connect(and1.y, booleanToReal.u) annotation (Line(
        points={{1,56},{12,56}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(hysteresis.y, and1.u1) annotation (Line(
        points={{-33,70},{-28,70},{-28,56},{-22,56}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(booleanExpression.y, and1.u2) annotation (Line(
        points={{-33,48},{-22,48}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(modulationRate.u, product.y) annotation (Line(
        points={{34,-20},{-2,-20},{-2,-13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(booleanToReal.y, product.u1) annotation (Line(
        points={{35,56},{42,56},{42,16},{4,16},{4,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, product.u2) annotation (Line(
        points={{-19,22},{-8,22},{-8,10}},
        color={0,0,127},
        smooth=Smooth.None));
  else
    onOff_internal_filtered = 1;
  end if;
    annotation (Placement(transformation(extent={{66,74},{86,94}})),
              Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                   graphics={
        Line(
          points={{-98,60},{-66,60},{-40,60},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-60},{-68,-60},{-40,-60},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,20},{-38,20},{-6,20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-20},{-40,-20},{-2,-20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{28,0},{90,0},{98,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None),
      Polygon(
        origin={65.533,-20.062},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points={{-60.062,-105.533},{-20.062,-65.533},{19.938,-105.533},{19.938,-45.533},
              {-20.062,-5.533},{-60.062,-45.533},{-60.062,-105.533}},
          rotation=270)}),       Diagram(coordinateSystem(extent={{-100,-100},{
            100,100}},
                   preserveAspectRatio=false), graphics));
end PartialHeatSource;

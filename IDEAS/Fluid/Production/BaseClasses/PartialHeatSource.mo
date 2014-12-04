within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"
  extends IDEAS.Fluid.Interfaces.OnOffInterface;

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  parameter Boolean modulating = true "true if the heatsource can modulate";
  parameter Boolean avoidEvents = false
    "Set to true to switch heat pumps on using a continuous transition"
    annotation(Dialog(tab="Advanced", group="Events"));
  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter SI.Frequency riseTime=120
    "The time it takes to reach full/zero power when switching"
    annotation(Dialog(tab="Advanced", group="Events", enable=avoidEvents));

  //Data parameters
  parameter Modelica.SIunits.Power QNomRef
    "Nominal power of the production unit for which the data is given";
  parameter Real etaRef
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin if modulating "Minimal modulation percentage";
  parameter Real modulationStart(min=modulationMin + 5) if modulating
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

  //Scalable parameters
  parameter Modelica.SIunits.Power QNom "The power at nominal conditions";
  parameter Real scaler = QNom/QNomRef "The scaling factor of the boiler data";
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";

  //Variables
  Real eta "Final efficiency of the heat source";
  Real release(min=0, max=1) "Stop heat production when the mass flow is zero";

  Real modulationInit if modulating
    "Initial modulation, decides on start/stop of the production unit";
  Real modulation(min=0, max=100) if modulating "Current modulation percentage";
  Modelica.SIunits.Power QMax if modulating
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) if modulating
    "Desired power of the heatsource";

  Modelica.SIunits.Power QLossesToCompensate
    "Artificial heat losses to correct the heat balance";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";

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

   Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=modulationMin,
    uHigh=modulationStart)
    annotation (Placement(transformation(extent={{-68,74},{-48,94}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal if avoidEvents
    annotation (Placement(transformation(extent={{-18,62},{-6,74}})));
  Modelica.Blocks.Continuous.Filter modulationRate(f_cut=5/(2*Modelica.Constants.pi*riseTime)) if avoidEvents
    "Fictive modulation rate to avoid non-smooth on/off transitions causing events."
    annotation (Placement(transformation(extent={{16,46},{28,58}})));
  Modelica.Blocks.Logical.And and1 if avoidEvents
    annotation (Placement(transformation(extent={{-40,60},{-26,74}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=on_internal) if avoidEvents
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Math.Product product if avoidEvents
    annotation (Placement(transformation(extent={{0,48},{10,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - release) if
                                                                      avoidEvents
    annotation (Placement(transformation(extent={{-30,36},{-10,56}})));
protected
  Modelica.Blocks.Interfaces.RealOutput onOff_internal_filtered;
equation
  if avoidEvents then
    connect(onOff_internal_filtered,modulationRate.y);
    connect(and1.y, booleanToReal.u) annotation (Line(
        points={{-25.3,67},{-22.65,67},{-22.65,68},{-19.2,68}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(hysteresis.y, and1.u1) annotation (Line(
        points={{-47,84},{-44,84},{-44,67},{-41.4,67}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(booleanExpression.y, and1.u2) annotation (Line(
        points={{-49,60},{-46,60},{-46,61.4},{-41.4,61.4}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(modulationRate.u, product.y) annotation (Line(
        points={{14.8,52},{14,52},{14,53},{10.5,53}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(booleanToReal.y, product.u1) annotation (Line(
        points={{-5.4,68},{-4,68},{-4,56},{-1,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, product.u2) annotation (Line(
        points={{-9,46},{-4,46},{-4,50},{-1,50}},
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
          rotation=270)}),       Diagram(coordinateSystem(extent={{-100,-100},{100,
            100}}, preserveAspectRatio=false), graphics));
end PartialHeatSource;

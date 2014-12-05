within IDEAS.Fluid.Production.BaseClasses;
partial model PartialModulatingHeatSource
  "Partial for a modulating heat source production component"
  extends PartialHeatSource;

  //Modulation parameters
  parameter Boolean avoidEvents = true
    "Set to true to switch heat pumps on using a continuous transition"
    annotation(Dialog(tab="Advanced", group="Events"));

  parameter Real modulationMin "Minimal modulation percentage";
  parameter Real modulationStart(min=modulationMin + 5)
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
  Modelica.Blocks.Continuous.Filter modulationRate(f_cut=5/(2*Modelica.Constants.pi*riseTime)) if avoidEvents
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
equation
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
          rotation=270)}),       Diagram(coordinateSystem(extent={{-100,-100},{100,
            100}}, preserveAspectRatio=false), graphics));
end PartialModulatingHeatSource;

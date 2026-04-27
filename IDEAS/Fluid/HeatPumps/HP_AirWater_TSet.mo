within IDEAS.Fluid.HeatPumps;
model HP_AirWater_TSet "Air-to-water heat pump with temperature set point"
  extends IDEAS.Fluid.HeatPumps.Interfaces.PartialDynamicHeaterWithLosses(
    final allowFlowReversal=false);

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter Modelica.Units.SI.Power QDesign=0
    "Overrules QNom if different from 0. Design heat load, typically at -8°C in Belgium"
    annotation (Dialog(group="Design load"));
  final parameter Boolean useQDesign=abs(QDesign) > Modelica.Constants.small
    "= true, QDesign is used to determine the heat pump's nominal thermal power";
  parameter Real fraLosDesNom=0.68
    "Ratio of power at design conditions over power at 2/35°C. Only used if QDesign is bigger than 0."
    annotation (Dialog(group="Design load", enable=useQDesign));
  parameter Real betaFactor=0.8
    "Relative sizing compared to design heat load. Only used if QDesign is bigger than 0."
    annotation (Dialog(group="Design load", enable=useQDesign));
  final parameter Modelica.Units.SI.Power QNomFinal=
    if not useQDesign then QNom
    else QDesign/fraLosDesNom*betaFactor
    "Used nominal thermal power of the heat pump in the heatSource model";

  parameter Boolean useMinMod = true
    "=true, the heat pump has a minimum modulation degree";
  parameter Real modulation_min=20
    "Minimal modulation percentage"
    annotation (Dialog(group="Nominal condition"));
  parameter Real modulation_start=35
    "Minimal estimated modulation level required for start of HP"
    annotation (Dialog(group="Nominal condition"));
  Real COP "Instanteanous COP";
  Real modulation(max=100) = IDEAS.Utilities.Math.Functions.smoothMax(0, heatSource.modulation, 1)
    "Current modulation percentage";
  IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW heatSource(
    redeclare final package Medium = Medium,
    final QNom=QNomFinal,
    final UALoss=UALoss,
    final modulation_min=modulation_min,
    final modulation_start=modulation_start,
    final useMinMod=useMinMod)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tenv annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-90})));
  Modelica.Blocks.Sources.RealExpression Teva(y=sim.Te) annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
equation
  PEl = heatSource.PEl;
  QCon_flow = if noEvent(PEl > 0) then vol.heatPort.Q_flow else 0;
  COP =if noEvent(PEl > 0) then vol.heatPort.Q_flow/PEl else 0;
  connect(TSet, heatSource.TCondensor_set) annotation (Line(
      points={{-106,0},{-60,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo.m_flow, heatSource.m_flowCondensor) annotation (Line(
      points={{9,-30},{-52,-30},{-52,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tin.T, heatSource.TCondensor_in) annotation (Line(
      points={{40,-49},{40,-44},{-55,-44},{-55,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanExpression.y, heatSource.on) annotation (Line(
      points={{-69,20},{-66,20},{-66,3},{-60,3}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(heatSource.heatPort, vol.heatPort) annotation (Line(points={{-40,0},{-20,0},{-20,-10},{10,-10}}, color={191,0,0}));
  connect(Tenv.port, heatPort) annotation (Line(points={{-20,-90},{0,-90},{0,-100}}, color={191,0,0}));
  connect(Tenv.T, heatSource.TEnvironment) annotation (Line(points={{-41,-90},{-58,-90},{-58,-10}}, color={0,0,127}));
  connect(Teva.y, heatSource.TEvaporator) annotation (Line(points={{-69,40},{-58,40},{-58,10}}, color={0,0,127}));
    annotation (Dialog(group="Nominal condition"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Polygon(
          points={{-52,100},{-32,100},{-32,80},{28,80},{28,-80},{-2,-80},{-2,
              -72},{-12,-80},{-22,-72},{-22,-80},{-52,-80},{-52,100}},
          smooth=Smooth.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{78,70},{78,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{96,60},{80,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{96,-60},{80,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{78,-50},{78,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Ellipse(extent={{-82,50},{-22,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,20},{-70,20},{-42,32},{-62,8},{-34,20},{-22,20}},
          color={0,127,255},
          smooth=Smooth.None),
        Ellipse(extent={{-2,-10},{58,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-2,-40},{10,-40},{38,-28},{18,-52},{40,-44},{40,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,-50},{80,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,70},{80,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-22,20},{-12,20},{-32,-40},{-100,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{-2,-40},{-12,-40},{20,60},{78,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-22,-72},{-22,-88},{-2,-72},{-2,-88},{-22,-72}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-52,-10},{-52,-80},{-22,-80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{-2,-80},{28,-80},{28,-70}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{-52,50},{-52,100},{-32,100}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{28,-10},{28,80},{8,80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Polygon(
          points={{-22,120},{-2,120},{6,118},{8,110},{8,70},{6,62},{-2,60},{-22,
              60},{-30,62},{-32,70},{-32,110},{-30,118},{-22,120}},
          smooth=Smooth.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{12,100},{8,110}},
          lineColor={95,95,95},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,-60},{78,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-80,20},{-160,20},{-160,0},{-100,0},{-100,-20},{-160,-20},{
              -160,-40},{-80,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{-152,30},{-152,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-142,30},{-142,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-132,30},{-132,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-122,30},{-122,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-112,30},{-112,-52}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<h4>
Description
</h4>
<p>
Dynamic heat pump model, based on interpolation in performance tables for a Daikin Altherma heat pump.
These tables are encoded in the <a href=\"modelica://IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW\">
IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW</a> model.
If a different heat pump is to be simulated, create a different heatSource model with adapted interpolation tables.
</p>
<p>
The nominal power of the heat pump can be adapted.
This will NOT influence the efficiency as a function of ambient air temperature, condenser temperature and modulation level.
</p>
<p>
The heat pump has thermal losses to the environment which are often not mentioned in the performance tables.
Therefore, the additional environmental heat losses are added to the heat production
in order to ensure the same performance as in the manufacturers data, 
while still obtaining a dynamic model with heat losses (also when heat pump is off).
The <code>heatSource</code> component will compute the required power and the environmental heat losses, 
and try to reach the setpoint. 
</p>
<p>
See <a href=\"modelica://IDEAS.Fluid.HeatPumps.Interfaces.PartialDynamicHeaterWithLosses\"> 
IDEAS.Fluid.HeatPumps.Interfaces.PartialDynamicHeaterWithLosses</a> 
for more details about the heat losses and dynamics.
</p>
<h4>
Assumptions and limitations
</h4>
<ul>
<li>
Dynamic model based on water content and lumped dry capacity
</li>
<li>
Inverter-controlled heat pump with limited power (based on <code>QNom</code> and interpolation tables in 
<a href=\"modelica://IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW\">heatSource</a>)
</li>
<li>
Heat losses to environment which are compensated 'artifically' to meet the manufacturers data in steady state conditions
</li>
<li>
No defrosting taken into account
</li>
<li>
No enforced minimum on or minimum off time.
Hysteresis on start/stop thanks to different parameters for minimum modulation to start and stop the heat pump
</li>
</ul>
<h4>
Model use
</h4>
<ol>
<li>
Specify medium and initial temperature (of the water + dry mass)
</li>
<li>
Specify the nominal power <code>QNom</code>. There are two options:
<ol>
<li>
Specify <code>QNom</code> and put <code>QDesign</code> = 0
</li>
<li>
Specify <code>QDesign</code> greater than 0 and </code>QNom</code> wil be calculated from <code>QDesign</code> as follows:
<i>QNom = QDesign * betaFactor / fraLosDesNom</i>
</li>
</ol>
<li>
Connect <code>TSet</code>, the flowPorts and the heatPort to environment.
</li>
<li>
Specify the minimum required modulation level for the heat pump to start (<code>modulation_start</code>) 
and the minimum modulation level when the heat pump is operating (<code>modulation_min</code>).
The difference between both will ensure some off-time in case of low heat demands
</li>
</ol>
<p>
Note that this model is based on performance tables of a specific heat pump,
as specified by the <a href=\"modelica://IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW\">
IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW</a> model.
If a different heat pump is to be simulated, create a different heatSource model with adapted interpolation tables.
</p>
<h4>
Validation
</h4>
<h4>
Example
</h4>
<p>
A specific heat pump example is given in <a href=\"modelica://IDEAS.Fluid.HeatPumps.Examples.HeatPump_AirWater\">
IDEAS.Fluid.HeatPumps.Examples.HeatPump_AirWater</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 27, 2026, by Jelger Jansen:<br/>
Revise and clean up model.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1485\">#1485</a>.
</li>
<li>
February 4, 2025, by Jelger Jansen:<br/>
Added <code>Modelica.Units.</code> to one or multiple parameter(s) due to the removal of <code>import</code> in IDEAS/package.mo.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1415\">#1415</a> .
</li>
<li>
September 10, 2020 by Filip Jorissen:<br/>
Fixed real equality comparison for
<a href=\"https://github.com/open-ideas/IDEAS/issues/1172\">#1172</a>.
</li>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
March, 2014, by Filip Jorissen:<br/>
Annex60 compatibility
</li>
<li>
May, 2013, by Roel De Coninck:<br/>
Propagation of heatSource parameters and better definition of QNom used.  Documentation and example added
</li>
<li>
2011, by Roel De Coninck:<br/>
First version
</li>
</ul>
</html>"));
end HP_AirWater_TSet;

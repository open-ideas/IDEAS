within IDEAS.Fluid.HeatPumps.BaseClasses;
model HeatSource_HP_AW
  "Computation of theoretical condensation power of the refrigerant based on interpolation data. Takes into account losses of the heat pump to the environment"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  final parameter Modelica.Units.SI.Power QNomRef=7177
    "Nominal power of the Daikin Altherma.  See datafile";
  parameter Modelica.Units.SI.Power QNom
    "The power at nominal conditions (2/35)";

  parameter Boolean useMinMod = true;
  parameter Real modulation_min(max=29) = 20
    "Minimal modulation percentage. Don't set this to 0 or very low values, you might get negative P at very low modulations because of wrong extrapolation";
  parameter Real modulation_start(min=min(30, modulation_min + 5)) = 35
    "Min estimated modulation level required for start of HP";
  final parameter Real[5] mod_vector={0,30,50,90,100}
    "5 modulation steps, %";

  parameter Modelica.Units.SI.ThermalConductance UALoss
    "UA of heat losses of HP to environment";

  Modelica.Units.SI.HeatFlowRate QAsked(start=0);
  Modelica.Units.SI.HeatFlowRate QMax
    "Maximum thermal power at specified evaporator and condensor temperatures, in W";
  Modelica.Units.SI.HeatFlowRate QLossesToCompensate "Environment losses";
  Real[5] Q_vector
    "Thermal power for 5 modulation steps, in kW";

  Modelica.Units.SI.Power PEl
    "Resulting electrical power";
  Real[5] P_vector
    "Electrical power for 5 modulation steps, in kW";

  Real modulationInit
    "Initial modulation, decides on start/stop of the HP";
  Real modulation(min=0, max=100)
    "Current modulation percentage";

  Modelica.Blocks.Interfaces.BooleanInput on
    annotation (Placement(
        transformation(extent={{-120,40},{-80,80}}), iconTransformation(extent={{-110,20},
        {-90,40}})));
  Modelica.Blocks.Interfaces.RealInput TCondensor_set
    annotation (Placement(
        transformation(extent={{-120,-50},{-80,-10}}),iconTransformation(extent={{-110,
      -10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput TCondensor_in
    annotation (Placement(transformation(
          extent={{-120,-80},{-80,-40}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-100})));
  Modelica.Blocks.Interfaces.RealInput m_flowCondensor
    annotation (Placement(transformation(
          extent={{-120,-110},{-80,-70}}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-100})));
  Modelica.Blocks.Interfaces.RealInput TEvaporator
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealInput TEnvironment
    annotation (Placement(transformation(extent={{-120,10},{-80,50}}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-100})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Tables.CombiTable2Ds P100(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,1.96,2.026,2.041,2.068,2.075,2.28,
        2.289,2.277,2.277; 35,2.08,2.174,2.199,2.245,2.266,2.508,2.537,2.547,
        2.547; 40,2.23,2.338,2.374,2.439,2.473,2.755,2.804,2.838,2.838; 45,2.39,
        2.519,2.566,2.65,2.699,3.022,3.091,3.149,3.149; 50,2.56,2.718,2.777,
        2.88,2.942,3.309,3.399,3.481,3.481])
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Tables.CombiTable2Ds P90(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,1.76,1.79,1.8,1.81,1.81,1.94,1.93,
        1.9,1.9; 35,1.88,1.96,1.98,1.98,1.99,2.19,2.16,2.15,2.15; 40,2.01,2.11,
        2.14,2.16,2.18,2.42,2.4,2.41,2.41; 45,2.16,2.28,2.32,2.39,2.39,2.66,
        2.71,2.69,2.69; 50,2.32,2.46,2.51,2.6,2.61,2.92,2.99,3.05,3.05])
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Tables.CombiTable2Ds P50(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,1.14,1.11,1.09,1.02,0.98,0.98,
        0.92,0.81,0.81; 35,1.26,1.24,1.22,1.16,1.12,1.14,1.09,0.98,0.98; 40,
        1.39,1.39,1.37,1.35,1.28,1.36,1.28,1.21,1.21; 45,1.54,1.55,1.53,1.49,
        1.46,1.52,1.49,1.38,1.38; 50,1.68,1.73,1.72,1.68,1.66,1.75,1.72,1.62,
        1.62]) annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Blocks.Tables.CombiTable2Ds P30(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,0.78,0.7,0.62,0.534,0.496,0.494,
        0.416,0.388,0.388; 35,0.9,0.82,0.71,0.602,0.561,0.563,0.477,0.453,0.453;
        40,1.04,0.97,0.88,0.696,0.65,0.653,0.552,0.531,0.531; 45,1.17,1.13,1.04,
        0.86,0.774,0.773,0.646,0.625,0.625; 50,1.35,1.28,1.23,1.11,0.96,0.931,
        0.765,0.739,0.739])
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  Modelica.Blocks.Tables.CombiTable2Ds Q100(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,4.82,5.576,6.023,6.892,7.642,
        10.208,11.652,13.518,13.518; 35,4.59,5.279,5.685,6.484,7.177,9.578,
        10.931,12.692,12.692; 40,4.43,5.056,5.43,6.174,6.824,9.1,10.386,12.072,
        12.072; 45,4.32,4.906,5.255,5.957,6.576,8.765,10.008,11.647,11.647; 50,
        4.27,4.824,5.155,5.828,6.426,8.564,9.786,11.408,11.408])
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Blocks.Tables.CombiTable2Ds Q90(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,4.338,5.019,5.42,6.203,6.877,
        9.188,10.486,12.166,12.166; 35,4.131,4.751,5.117,5.836,6.459,8.62,9.838,
        11.423,11.423; 40,3.987,4.551,4.887,5.556,6.141,8.19,9.348,10.865,
        10.865; 45,3.888,4.415,4.73,5.361,5.918,7.888,9.007,10.483,10.483; 50,
        3.843,4.342,4.639,5.245,5.784,7.708,8.807,10.267,10.267])
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Tables.CombiTable2Ds Q50(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,2.41,2.788,3.011,3.446,3.821,
        5.104,5.826,6.759,6.759; 35,2.295,2.639,2.843,3.242,3.589,4.789,5.466,
        6.346,6.346; 40,2.215,2.528,2.715,3.087,3.412,4.55,5.193,6.036,6.036;
        45,2.16,2.453,2.628,2.979,3.288,4.382,5.004,5.824,5.824; 50,2.135,2.412,
        2.577,2.914,3.213,4.282,4.893,5.704,5.704])
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Blocks.Tables.CombiTable2Ds Q30(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0,-15,-10,-7,-2,2,7,12,18,30; 30,1.446,1.673,1.807,2.068,2.292,
        3.063,3.495,4.055,4.055; 35,1.377,1.584,1.706,1.945,2.153,2.873,3.279,
        3.808,3.808; 40,1.329,1.517,1.629,1.852,2.047,2.73,3.116,3.622,3.622;
        45,1.296,1.472,1.577,1.787,1.973,2.629,3.002,3.494,3.494; 50,1.281,
        1.447,1.546,1.748,1.928,2.569,2.936,3.422,3.422])
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));

  Controls.Discrete.HysteresisRelease_boolean onOff(
    enableRelease=true,
    y(start=0),
    release(start=false))
    annotation (Placement(transformation(extent={{-10,66},{10,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=modulationInit)
    annotation (Placement(transformation(extent={{-53,86},{-31,106}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=modulation_start)
    annotation (Placement(transformation(extent={{-52,72},{-32,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=modulation_min)
    annotation (Placement(transformation(extent={{-52,58},{-32,78}})));

protected
  parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    p=Medium.p_default,
    T=Medium.T_default,
    X=Medium.X_default[1:Medium.nXi])
    "Medium state at default properties";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default =
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity at default properties";

equation
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flowCondensor*cp_default*(TCondensor_set-TCondensor_in), 10);

  // Temperatures
  P100.u1 = heatPort.T - 273.15;
  P100.u2 = TEvaporator - 273.15;
  P90.u1 = heatPort.T - 273.15;
  P90.u2 = TEvaporator - 273.15;
  P50.u1 = heatPort.T - 273.15;
  P50.u2 = TEvaporator - 273.15;
  P30.u1 = heatPort.T - 273.15;
  P30.u2 = TEvaporator - 273.15;
  Q100.u1 = heatPort.T - 273.15;
  Q100.u2 = TEvaporator - 273.15;
  Q90.u1 = heatPort.T - 273.15;
  Q90.u2 = TEvaporator - 273.15;
  Q50.u1 = heatPort.T - 273.15;
  Q50.u2 = TEvaporator - 273.15;
  Q30.u1 = heatPort.T - 273.15;
  Q30.u2 = TEvaporator - 273.15;

  // Heat and power flows; all these are in kW
  Q_vector[1] = 0;
  Q_vector[2] = Q30.y*QNom/QNomRef;
  Q_vector[3] = Q50.y*QNom/QNomRef;
  Q_vector[4] = Q90.y*QNom/QNomRef;
  Q_vector[5] = Q100.y*QNom/QNomRef;
  P_vector[1] = 0;
  P_vector[2] = P30.y*QNom/QNomRef;
  P_vector[3] = P50.y*QNom/QNomRef;
  P_vector[4] = P90.y*QNom/QNomRef;
  P_vector[5] = P100.y*QNom/QNomRef;
  QMax = 1000*Q100.y*QNom/QNomRef;

  // Modulation degree
  modulationInit = QAsked/QMax*100;
  if useMinMod then
    modulation = onOff.y*IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100,1);
  else
    modulation = IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100,1);
  end if;

  // Compensation of heat losses (only when the heat pump is operating)
  QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T - TEnvironment) else 0;
  heatPort.Q_flow = -1000*Modelica.Math.Vectors.interpolate(
    mod_vector,
    Q_vector,
    modulation) - QLossesToCompensate;
  PEl = 1000*Modelica.Math.Vectors.interpolate(
    mod_vector,
    P_vector,
    modulation);

  // Others
  connect(realExpression.y, onOff.u) annotation (Line(
      points={{-29.9,96},{-20,96},{-20,76},{-12,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression1.y, onOff.uHigh) annotation (Line(
      points={{-31,82},{-24,82},{-24,72},{-12,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression2.y, onOff.uLow) annotation (Line(
      points={{-31,68},{-12,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(on, onOff.release) annotation (Line(
      points={{-100,60},{0,60},{0,64}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(
          points={{-70,-20},{30,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-70,20},{30,20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,20}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{30,0},{30,40},{60,20},{30,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-40},{30,0},{60,-20},{30,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,40},{80,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,-40},{30,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{24,74},{44,54},{40,50},{20,70},{24,74}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}),
Documentation(info="<html>
<h4>
Model description
</h4>
<p>
This model is based on data received from Daikin from an Altherma heat pump, 
and the full heat pump is implemented as <a href=\"modelica://IDEAS.Fluid.HeatPumps.HP_AirWater_TSet\">
IDEAS.Fluid.HeatPumps.HP_AirWater_TSet</a>.
<p>
The nominal power of the original heat pump is 7177 W at 2/35 degC.
</p>
<p>
First, the thermal power and electricity consumption are interpolated
for the evaporator and condensing temperature at 4 different modulation levels.
The results are rescaled to the nominal power of the modelled heat pump (with QNom/QNom_data)
and stored in 2 different vectors, <code>Q_vector</code> and <code>P_vector</code>.
</p>
<p>
Finally, the modulation is calculated based on the asked power and the max power at operating conditions:
<ul>
<li>
if <code>modulation_init < modulation_min</code>, the heat pump is OFF, modulation = 0. 
</li>
<li>
if <code>modulation_init > 100%</code>, the modulation is 100%
</li>
<li>
if <code>modulation_init</code> between <code>modulation_min</code> and <code>modulation_start</code>: hysteresis for on/off cycling.
</li>
</ul>
</p>
<p>
If the heat pump is on another modulation level, interpolation is made to get <i>P</i> and <i>Q</i> at the real modulation.
</p>
<p>
This model takes into account environmental heat losses of the heat pump.
In order to keep the same nominal efficiency during operation, these heat losses are added to the computed power. 
Therefore, the heat losses are only really &apos;losses&apos; when the heat pump is NOT operating.
</p>
<p>
The COP is calculated as the heat delivered to the condensor divided by the electrical power consumption.
</p>
<h4>
Assumptions and limitations
</h4>
<ol>
<li>
Based on interpolation in manufacturer data for Daikin Altherma heat pump
</li>
<li>
Ensure not to operate the heat pump outside of the manufacturer data.
No check is made if this happens, and this can lead to strange and wrong results.
</li>
</ol>
<h4>
Model use
</h4>
<p>
This model is used in the <a href=\"Modelica://IDEAS.Fluid.HeatPumps.HP_AirWater_TSet\"> IDEAS.Fluid.HeatPumps.HP_AirWater_TSet</a> model.
If a different heat pump is to be simulated, copy this model and adapt the interpolation tables.
</p>
<h4>
</html>", revisions="<html>
<ul>
<li>
April 27, 2026, by Jelger Jansen:<br/>
Revise and clean up model.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1485\">#1485</a>.
</li>
<li>
2011, by Roel De Coninck:<br/>
First version
</li>
</ul>
</html>"));
end HeatSource_HP_AW;

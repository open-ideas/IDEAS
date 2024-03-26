within IDEAS.Fluid.Taps.BaseClasses;
partial model PartialTap "Partial model for a (DHW) tap"

  parameter Modelica.Units.SI.Temperature TSet(max=273.15 + 60) = 273.15 +
    45 "Temperature setpoint of DHW at tap";
  parameter Modelica.Units.SI.Temperature TCold=273.15 + 10
    "Temperature of cold water";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";

protected
  Modelica.Units.SI.MassFlowRate mFloSet "DHW mass flow rate at TSet";

public
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_hot(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_cold(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  IDEAS.Fluid.Interfaces.IdealSource idealSource(
    redeclare package Medium = Medium,
    control_m_flow=true,
    allowFlowReversal=false,
    control_dp=false)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    nPorts=2,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    V=1) "Mixing volume for heat injection"
    annotation (Placement(transformation(extent={{60,0},{80,-20}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.RealExpression TCold_expr(y=TCold)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Modelica.Blocks.Sources.RealExpression mFloDiscomfort(y=mFloSet)
    "DHW mass flow rate if THot < TSet. If the temperature of the hot water supply 
    is lower than the set point temperature of the DHW, the mass flow from the tank
    to the tap equals the mass flow rate at the set point temperature. In this case,
    the user will experience discomfort at the tap."
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.RealExpression mFloComfort(y=mFloSet*(TSet-TCold)/(
        deltaT_for_scaling.y))
    "Required mass flow rate from the tank based on current THot. If THot > TSet
    mixing will occur and cold water will be mixed with hot water from the tank. 
    mFloComfort is the required mass flow rate from the tank at Thot and is related
    to mFloSet at TSet via conservation of energy."
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  IDEAS.Utilities.Math.SmoothMin mFloHot(deltaX=1e-3*m_flow_nominal)
    "Hot water mass flow rate. If THot > TSet, mFloHot = mFloComfort.
    If THot < TSet, mFloHot = mFloDiscomfort."
    annotation (Placement(transformation(extent={{0,20},{20,40}})));

  Modelica.Blocks.Sources.RealExpression deltaT(y=THot - TCold) "THot-TCold"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Sources.RealExpression deltaT_min(y=0.1)
    "Minimal value of the temperature difference, to avoid division by zero."
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  IDEAS.Utilities.Math.SmoothMax deltaT_for_scaling(deltaX=0.1)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));

  Modelica.Blocks.Interfaces.RealInput THot(
    each final quantity="ThermodynamicTemperature",
    each unit="K",
    each displayUnit="degC",
    each min=0)
    "Temperature measurement of domestic hot water supply (e.g. temperature in DHW storage tank)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,70}),
                         iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,70})));
  Modelica.Blocks.Logical.GreaterEqualThreshold comfort(threshold=TSet)
    "Block operator to check whether there is DHW comfort or not. True = comfort, false = discomfort."
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(preTem.port, vol.heatPort) annotation (Line(
      points={{40,-40},{60,-40},{60,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TCold_expr.y, preTem.T) annotation (Line(
      points={{1,-40},{18,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloHot.y, idealSource.m_flow_in) annotation (Line(
      points={{21,30},{24,30},{24,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(idealSource.port_b, vol.ports[1]) annotation (Line(points={{40,0},{69,0}}, color={0,127,255}));
  connect(vol.ports[2], port_cold) annotation (Line(points={{71,0},{100,0}}, color={0,127,255}));
  connect(mFloComfort.y, mFloHot.u2) annotation (Line(points={{-19,20},{-10,20},
          {-10,24},{-2,24}},                     color={0,0,127}));
  connect(mFloDiscomfort.y, mFloHot.u1) annotation (Line(points={{-19,40},{-10,
          40},{-10,36},{-2,36}},
                              color={0,0,127}));
  connect(deltaT.y, deltaT_for_scaling.u1) annotation (Line(points={{-19,90},{
          -12,90},{-12,86},{-2,86}},
                                  color={0,0,127}));
  connect(deltaT_min.y, deltaT_for_scaling.u2) annotation (Line(points={{-19,70},
          {-10,70},{-10,74},{-2,74}},  color={0,0,127}));

  connect(idealSource.port_a, port_hot)
    annotation (Line(points={{20,0},{-100,0}}, color={0,127,255}));
  connect(THot, comfort.u) annotation (Line(points={{-100,70},{-92,70},{-92,50},
          {-82,50}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=
            false), graphics={
        Line(
          points={{0,40},{0,0}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,0},{20,0}},
          color={244,125,35},
          thickness=1),
        Polygon(
          points={{-80,20},{-80,-20},{-20,20},{-20,-20},{-80,20}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Polygon(
          points={{20,20},{20,-20},{80,20},{80,-20},{20,20}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Line(
          points={{-90,0},{-80,0}},
          color={238,46,47},
          thickness=1),
        Line(
          points={{80,0},{90,0}},
          color={28,108,200},
          thickness=1),
        Polygon(
          points={{-20,40},{20,40},{12,80},{-12,80},{-20,40}},
          lineColor={0,0,0},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Line(points={{-8,80},{-14,40}}, color={162,162,162}),
        Line(points={{0,80},{0,78},{0,40}}, color={162,162,162}),
        Line(points={{8,80},{14,40}}, color={162,162,162}),
        Line(points={{-4,80},{-8,40}}, color={162,162,162}),
        Line(points={{4,80},{8,40}}, color={162,162,162}),
        Polygon(
          points={{-70,68},{-70,48},{-76,42},{-76,32},{-70,26},{-62,26},{-56,32},
              {-56,42},{-62,48},{-62,68},{-70,68}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-70,86},{-70,48},{-76,42},{-76,32},{-70,26},{-62,26},{-56,32},
              {-56,42},{-62,48},{-62,86},{-66,90},{-70,86}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-70,76},{-66,76}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-66,72},{-70,72}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-66,68},{-70,68}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,64},{-66,64}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,60},{-66,60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,56},{-66,56}},
          color={0,0,0},
          thickness=0.5)}),
    Documentation(info="<html>
<p><b>Description</b></p>
<p>Partial model of a domestic hot water (DHW) tap. The tap is modelled as a thermostatic mixing valve.</p>
<p>The model has two flowPorts and a realInput: </p>
<ul>
<li><i>port_hot</i>: connection to the hot water source (designation: <i>hot</i> )</li>
<li><i>port_cold</i>: connection to the inlet of cold water in the hot water source (designation: <i>cold </i>)</li>
<li><i>mFloSet</i>: desired flowrate of DHW water, equivalent at a user defined set point temperature</li>
</ul>
<p>The model tries to reach the given DHW flow rate at a the desired mixing temperature <i>TSet </i>by mixing the hot water with cold water. The resulting hot flowrate (<i>mFloHot </i>) will be extracted automatically from the hot source (via <i>port_hot </i>). This same flow rate will be injected at <i>TCold</i> in the production system through the connection of <i>port_cold</i> to the hot source. </p>
<p><b>Assumptions and limitations </b></p>
<ol>
<li>No heat losses.</li>
<li>Inertia is foreseen through the inclusion of a water volume on the hot water side (default=1 m3). <br>This parameter is not propagated to the interface, but it can be changed by modifying vol.V. <br>Putting this water content to zero may lead to numerical problems (not tested)</li>
<li>If <i>THot</i> is smaller than <i>TSet</i>, there is no mixing and <i>TMixed</i> = <i>THot</i>.</li>
<li>Fixed <i>TSet</i> and <i>TCold </i>as parameters.</li>
<li>The mixed DHW is not available as an outlet or flowPort. It is assumed to be &apos;consumed&apos;. </li>
</ol>
<p><b>Model use</b></p>
<ol>
<li>Set the parameters for cold water supply temperature <i>TCold</i> and the DHW set temperature <i>TSet</i> (mixed).</li>
<li>Connect <i>port_hot </i>to the hot water source.</li>
<li>Connect <i>port_</i>c<i>old</i> to the cold water inlet of the hot water source.</li>
<li>Depending on the implementation: fill out the table or provide a realInput for <i>mFloSet.</i></li>
<li>Thanks to the use of an <a href=\"IDEAS.Fluid.Interfaces.IdealSource\">IdealSource</a> in this model, it is <b>NOT</b> required to add additional pumps, ambients or AbsolutePressure to the DHW circuit.</li>
</ol>
<p><b>Validation </b></p>
<p>The model is verified to work properly by simulation of the different operating conditions.</p>
<p><b>Examples</b></p>
<p>An example of this model is given in <a href=\"IDEAS.Fluid.Taps.Examples.DHW_example\">IDEAS.Fluid.Taps.Examples.DHW_example</a>.</p>
</html>", revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>Adaptations to make the model more clear (change variable names, set allowFlowReversal=false, update icon).<br>Include a user-defined DHW setpoint temperature.<br>Add indicator for comfort or discomfort at DHW tap.<br>Update documentation. <br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for more information. </li>
<li>2013 June, Roel De Coninck: documentation.</li>
<li>2012 September, Roel De Coninck, simplification of equations.</li>
<li>2012 August, Roel De Coninck, first implementation.</li>
</ul>
</html>"));
end PartialTap;

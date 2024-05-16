within IDEAS.Fluid.Taps.BaseClasses;
partial model PartialTap "Partial model for a (DHW) tap"
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(m_flow_nominal=0.2);

  parameter Modelica.Units.SI.Temperature TSet=273.15+45
    "Temperature setpoint of DHW at the tap";
  parameter Modelica.Units.SI.Temperature TCol=273.15+10
    "Temperature of cold water";


protected
  Modelica.Units.SI.MassFlowRate m_flow_set "DHW mass flow rate at TSet";

public
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  IDEAS.Fluid.Interfaces.IdealSource mFloSou(
    redeclare package Medium = Medium,
    final control_m_flow=true,
    allowFlowReversal=false,
    final control_dp=false)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

  Modelica.Blocks.Sources.RealExpression TCol_in(y=TCol)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));

  Modelica.Blocks.Sources.RealExpression mFloDis(y=m_flow_set)
    "DHW mass flow rate if THot < TSet. If the hot water supply temperature is
    lower than the DHW setpoint temperature, the mass flow from the tank to the 
    tap equals the mass flow rate at the setpoint temperature. In this case, the
    user will experience DHW discomfort at the tap."
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.RealExpression mFloCom(y=m_flow_set*(TSet - TCol)/(
        delTSca.y)) "Required mass flow rate from the tank based on current THot. If THot > TSet
    mixing will occur and cold water will be mixed with hot water from the tank. 
    mFloCom is the required mass flow rate from the tank at THot and is related
    to mFloSet at TSet via conservation of energy."
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  IDEAS.Utilities.Math.SmoothMin mFloHot(deltaX=1e-3*m_flow_nominal)
    "Hot water mass flow rate. If THot > TSet, mFloHot = mFloCom.
    If THot < TSet, mFloHot = mFloDis."
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));

  Modelica.Blocks.Sources.RealExpression delT(y=THot - TCol) "THot-TCol"
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Sources.RealExpression delT_min(y=0.1)
    "Minimal value of the temperature difference, to avoid division by zero."
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  IDEAS.Utilities.Math.SmoothMax delTSca(deltaX=0.1)
    annotation (Placement(transformation(extent={{50,20},{70,40}})));

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
  Modelica.Blocks.Logical.GreaterEqualThreshold com(threshold=TSet)
    "Block operator to check whether there is DHW comfort or not. True = comfort, false = discomfort."
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Interfaces.BooleanOutput yCom
    "Boolean output signal to indicate whether there is DHW comfort (true) or discomfort (false)"
    annotation (Placement(transformation(extent={{90,60},{110,80}})));
  Modelica.Fluid.Sources.Boundary_pT hot_out(redeclare package Medium = Medium,
      nPorts=1) "Sink to model the hot water offtake from the system"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-30})));
  Modelica.Fluid.Sources.Boundary_pT col_in(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Supply to model the cold water injection into the system"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-30})));
equation
  connect(mFloHot.y, mFloSou.m_flow_in) annotation (Line(
      points={{-29,30},{-26,30},{-26,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloCom.y, mFloHot.u2) annotation (Line(points={{-69,20},{-60,20},{
          -60,24},{-52,24}},
                        color={0,0,127}));
  connect(mFloDis.y, mFloHot.u1) annotation (Line(points={{-69,40},{-60,40},{
          -60,36},{-52,36}},
                        color={0,0,127}));
  connect(delT.y, delTSca.u1) annotation (Line(points={{31,40},{38,40},{38,36},
          {48,36}},     color={0,0,127}));
  connect(delT_min.y, delTSca.u2) annotation (Line(points={{31,20},{40,20},{40,
          24},{48,24}}, color={0,0,127}));

  connect(THot, com.u) annotation (Line(points={{-100,70},{-22,70}},
                color={0,0,127}));
  connect(com.y, yCom)
    annotation (Line(points={{1,70},{100,70}}, color={255,0,255}));
  connect(port_a, mFloSou.port_a)
    annotation (Line(points={{-100,0},{-30,0}},color={0,127,255}));
  connect(mFloSou.port_b, hot_out.ports[1])
    annotation (Line(points={{-10,0},{10,0},{10,-20}}, color={0,127,255}));
  connect(port_b, col_in.ports[1])
    annotation (Line(points={{100,0},{70,0},{70,-20}}, color={0,127,255}));
  connect(TCol_in.y, col_in.T_in)
    annotation (Line(points={{61,-60},{66,-60},{66,-42}}, color={0,0,127}));
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
<li><i>m_flow_set</i>: desired flowrate of DHW water, equivalent at a user defined set point temperature</li>
</ul>
<p>The model tries to reach the given DHW flow rate at a the desired mixing temperature <i>TSet </i>by mixing the hot water with cold water. The resulting hot flowrate (<i>m_flow_Hot </i>) will be extracted automatically from the hot source (via <i>port_hot </i>). This same flow rate will be injected at <i>TCol</i> in the production system through the connection of <i>port_cold</i> to the hot source. </p>
<p><b>Assumptions and limitations </b></p>
<ol>
<li>No heat losses.</li>
<li>Inertia is foreseen through the inclusion of a water volume on the hot water side (default=1 m3). <br>This parameter is not propagated to the interface, but it can be changed by modifying vol.V. <br>Putting this water content to zero may lead to numerical problems (not tested)</li>
<li>If <i>THot</i> is smaller than <i>TSet</i>, there is no mixing and <i>TMixed</i> = <i>THot</i>.</li>
<li>Fixed <i>TSet</i> and <i>TCol</i>as parameters.</li>
<li>The mixed DHW is not available as an outlet or flowPort. It is assumed to be &apos;consumed&apos;. </li>
</ol>
<p><b>Model use</b></p>
<ol>
<li>Set the parameters for cold water supply temperature <i>TCol</i> and the DHW set temperature <i>TSet</i> (mixed).</li>
<li>Connect <i>port_hot </i>to the hot water source.</li>
<li>Connect <i>port_</i>c<i>old</i> to the cold water inlet of the hot water source.</li>
<li>Depending on the implementation: fill out the table or provide a realInput for <i>m_flow_set.</i></li>
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

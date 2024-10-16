within IDEAS.Fluid.Taps.BaseClasses;
partial model PartialTap "Partial model for a (DHW) tap"
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(m_flow_nominal=0.2);

  parameter Modelica.Units.SI.Temperature TSet=318.15
    "Temperature setpoint of DHW at the tap";
  parameter Modelica.Units.SI.Temperature TCol=283.15
    "Temperature of cold supply water";

protected
  Modelica.Units.SI.MassFlowRate m_flow_set "DHW mass flow rate at TSet";

public
  IDEAS.Fluid.Interfaces.IdealSource mFloSouHot(
    redeclare final package Medium = Medium,
    final control_m_flow=true,
    final allowFlowReversal=false,
    final control_dp=false)
    "Ideal mass flow source to model the hot water offtake from the system"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  IDEAS.Fluid.Sources.Boundary_pT bouHot(
    redeclare final package Medium = Medium,
    nPorts=1) "Sink to model the hot water offtake from the system"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-30})));
  Modelica.Blocks.Sources.RealExpression TCol_in(y=TCol)
    "Temperature of the cold water injected into the system"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  IDEAS.Fluid.Sources.Boundary_pT bouCol(
    redeclare final package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Supply to model the cold water injection into the system"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-30})));
  IDEAS.Fluid.Interfaces.IdealSource mFloSouCol(
    redeclare final package Medium = Medium,
    final control_m_flow=true,
    final allowFlowReversal=false,
    final control_dp=false)
    "Ideal mass flow source to model the cold water injection into the system"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Sources.RealExpression mFloHot(
    y=smooth(2, if noEvent(THot.T <= TSet) then m_flow_set else m_flow_set*(TSet - TCol)/(THot.T - TCol)))
    "Required flow rate from the hot water source"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort THot(
    redeclare final package Medium = Medium,
    final allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    tau=0) "Temperature sensor"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold com(threshold=TSet)
    "Block operator to check whether there is DHW comfort or not. True = comfort, false = discomfort."
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Interfaces.BooleanOutput DHWCom
    "Boolean output signal to indicate whether there is DHW comfort (true) or discomfort (false)"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));

equation
  connect(mFloSouHot.port_b, bouHot.ports[1])
    annotation (Line(points={{0,0},{20,0},{20,-20}}, color={0,127,255}));
  connect(TCol_in.y,bouCol. T_in)
    annotation (Line(points={{51,-60},{56,-60},{56,-42}}, color={0,0,127}));
  connect(com.y,DHWCom)
    annotation (Line(points={{1,70},{110,70}}, color={255,0,255}));
  connect(bouCol.ports[1], mFloSouCol.port_a)
    annotation (Line(points={{60,-20},{60,0},{70,0}}, color={0,127,255}));
  connect(mFloSouCol.port_b, port_b)
    annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
  connect(THot.port_a, port_a)
    annotation (Line(points={{-90,0},{-100,0}}, color={0,127,255}));
  connect(THot.port_b, mFloSouHot.port_a)
    annotation (Line(points={{-70,0},{-20,0}}, color={0,127,255}));
  connect(THot.T, com.u)
    annotation (Line(points={{-80,11},{-80,70},{-22,70}}, color={0,0,127}));
  connect(mFloHot.y, mFloSouCol.m_flow_in)
    annotation (Line(points={{-19,30},{74,30},{74,8}}, color={0,0,127}));
  connect(mFloHot.y, mFloSouHot.m_flow_in)
    annotation (Line(points={{-19,30},{-16,30},{-16,8}}, color={0,0,127}));
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
<p>Partial model of a domestic hot water (DHW) tap, including a cold water 
supply to have a closed system. The tap is modelled as a thermostatic mixing 
valve.</p>
<p>The model has two flowPorts and a realInput: </p>
<ul>
<li><i>port_a</i>: connection to the hot water source (designation: <i>hot</i>)</li>
<li><i>port_b</i>: connection to the inlet of cold water in the hot water source 
(designation: <i>cold</i>)</li>
<li><i>m_flow_set</i>: desired DHW mass flow rate, equivalent at a user 
defined set point temperature</li>
</ul>
<p>The model tries to reach the given DHW flow rate at a the desired mixing 
temperature <i>TSet</i> by mixing the hot water with cold water. The resulting 
hot flow rate (<i>mFloHot</i>) will be extracted automatically from the hot 
source (via <i>port_a </i>). This same flow rate will be injected at <i>TCol</i> 
in the production system through the connection of <i>port_b</i> to the hot 
source. </p>
<p><b>Assumptions and limitations </b></p>
<ol>
<li>No heat losses.</li>
<li>If <i>THot</i> is smaller than <i>TSet</i>, there is no mixing and the 
supply temperature at the tap equals <i>THot</i>.</li>
<li>Fixed <i>TSet</i> and <i>TCol</i> as parameters.</li>
<li>The mixed DHW is not available as an outlet or flowPort. It is assumed to be
&apos;consumed&apos;. </li>
</ol>
<p><b>Model use</b></p>
<ol>
<li>Set the parameters for cold water supply temperature <i>TCol</i> and the DHW
setpoint temperature <i>TSet</i> (mixed, at the tap).</li>
<li>Connect <i>port_a</i> to the hot water source.</li>
<li>Connect <i>port_b</i> to the cold water inlet of the hot water source.</li>
<li>Depending on the implementation: fill out the table or provide a realInput 
for <i>m_flow_set.</i></li>
<li>Thanks to the use of an <a href=\"IDEAS.Fluid.Interfaces.IdealSource\">IdealSource</a> 
in this model, it is <b>NOT</b> required to add additional pumps, ambients or 
AbsolutePressure to the DHW circuit.</li>
</ol>
<p><b>Examples</b></p>
<p>An example of this model is given in <a href=\"IDEAS.Fluid.Taps.Examples.DHW_example\">IDEAS.Fluid.Taps.Examples.DHW_example</a>.</p>
</html>", revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>Major refactoring. 
<br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for more information.</li>
<li>June, 2013, by Roel De Coninck:<br>Documentation.</li>
<li>September, 2012, by Roel De Coninck:<br> simplification of equations.</li>
<li>August, 2012, by Roel De Coninck:<br>Initial implementation.</li>
</ul>
</html>"));
end PartialTap;

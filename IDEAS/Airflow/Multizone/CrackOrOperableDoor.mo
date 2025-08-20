within IDEAS.Airflow.Multizone;
model CrackOrOperableDoor
 "Infiltration or large opening model used for the embeded airflow implementation in IDEAS.Buildings.Components"
 extends IDEAS.Fluid.Interfaces.PartialFourPortInterface(
		redeclare final package Medium1 = Medium,
		redeclare final package Medium2 = Medium,
		final allowFlowReversal1=true,
		final allowFlowReversal2=true,
		final m1_flow_nominal=10/3600*rho_default,
		final m2_flow_nominal=m1_flow_nominal,
		final m1_flow_small=1E-4*abs(m1_flow_nominal),
		final m2_flow_small=1E-4*abs(m2_flow_nominal));
 extends IDEAS.Airflow.Multizone.BaseClasses.ErrorControl(forceErrorControlOnFlow=true); //force error control on flow rates

 replaceable package Medium =Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation (choices(choice(redeclare package Medium = IDEAS.Media.Air "Moist air")));
 parameter IDEAS.BoundaryConditions.Types.InterZonalAirFlow interZonalAirFlowType "Interzonal air flow type";
 parameter Modelica.Units.SI.Angle inc=Modelica.Constants.pi/2 "inclination angle (vertical=pi/2)";
 parameter Modelica.Units.SI.Area A_q50 "Surface area for leakage computation (closed door)" annotation (Dialog(group="Crack or Closed door",enable=not useDoor or use_y));
 parameter Real q50(unit="m3/(h.m2)") "Surface air tightness" annotation (Dialog(group="Crack or Closed door",enable=not useDoor or use_y));
 parameter Modelica.Units.SI.Length wOpe=0.9 "Width of opening"   annotation (Dialog(group="Open door",enable=useDoor));
 parameter Modelica.Units.SI.Length hOpe=2.1 "Height of opening" annotation (Dialog(group="Open door",enable=useDoor));
 parameter Integer nCom=if abs(hOpe*sin(inc)) < 0.01 then 1 else max(2,integer(abs(hOpe*sin(inc))/4))
	"Number of compartments for the discretization"
		annotation (Dialog(group="Open door",enable=useDoor));

 parameter Modelica.Units.SI.Length h_b1=0
	"Height of crack at port b1 (hasCavity=false), center of conected zone is 0" 
		annotation (Dialog(group="Density Column Heights",enable= interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
 parameter Modelica.Units.SI.Length h_b2 = 0
	"Height of crack at port b2(hasCavity=false), center of conected zone is 0" 
		annotation (Dialog(group="Density Column Heights",enable= interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
 parameter Modelica.Units.SI.Length h_a1 = 0
	"Height of crack at port a1(hasCavity=false), center of conected zone is 0" 
		annotation (Dialog(group="Density Column Heights",enable= interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
 parameter Modelica.Units.SI.Length h_a2=0
	"Height at of crack port a2(hasCavity=false), center of conected zone is 0" 
		annotation (Dialog(group="Density Column Heights",enable= interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));

 parameter Modelica.Units.SI.Length hA=(h_a1 + h_b2)/2
	"Height of reference pressure at port a1 for opening (hasCavity=true) model, opening starting height is 0" 
		annotation (Dialog(group="Density Column Heights",enable=useDoorModel));
 parameter Modelica.Units.SI.Length hB=(h_a2 + h_b1)/2
	"Height of reference pressure at port b1 for opening (hasCavity=true) model, opening starting height is 0"
		annotation (Dialog(group="Density Column Heights",enable=useDoorModel));

 final parameter Modelica.Units.SI.PressureDifference dpCloRat(displayUnit="Pa")=50
	"Pressure drop at rating condition of closed door" 
		annotation (Dialog(group="Rating conditions"));
 final parameter Real CDCloRat(min=0, max=1)=1
	"Discharge coefficient at rating conditions of closed door" 
		annotation (Dialog(group="Rating conditions"));
 final parameter Modelica.Units.SI.Area LClo(min=0) = ((q50*A_q50/3600)/(dpCloRat)^mClo)/(((dpCloRat)^(0.5-mClo))*sqrt(2/rho_default))
	"Effective leakage area of internal wall (when door is fully closed)" 
		annotation (Dialog(group="Crack or Closed door"));
 parameter Real CDOpe=0.78 "Discharge coefficient of open door" 
		annotation (Dialog(group="Open door",enable=useDoor));
 parameter Real mOpe = 0.5 "Flow exponent for door of open door" 
		annotation (Dialog(group="Open door",enable=useDoor));
 parameter Real mClo= 0.65 "Flow exponent for crack or crack of closed door" 
		annotation (Dialog(group="Crack or Closed door",enable=not useDoor or use_y));

 parameter Boolean useDoor=false
	"Model a large opening instead of a crack";
 final parameter Boolean useDoorModel = useDoor and interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
	"=true, to use operable door instead of a crack";
 parameter Boolean use_y = true
	"=true, to use control input for the operable door" 
		annotation (Dialog(group="Open door",enable=useDoorModel));
 final parameter Boolean openDoorOnePort = useDoor and interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort
  "Sets whether a door is open or closed in one port configuration" ;

 parameter Modelica.Units.SI.PressureDifference dp_turbulent(min=0,displayUnit="Pa") = 
	if useDoor then (MFtrans/(rho_default*(CDOpe * hOpe*wOpe * sqrt(2/rho_default))))^(1/mOpe) else 0.01
	"Pressure difference where laminar and turbulent flow relation coincide for large cavities"
		annotation (Dialog(tab="Advanced",group="Model regularisation", enable=useDoor));
 parameter Modelica.Units.SI.MassFlowRate MFtrans=(hOpe*wOpe)*VItrans*REtrans/DOpe
	"Mass flow rate used for reguralisation"
		annotation (Dialog(tab="Advanced",group="Model regularisation", enable=useDoor));
 parameter Modelica.Units.SI.Length DOpe=4*hOpe*wOpe/(2*hOpe+2*wOpe)
	"Hydraulic diameter of the opening used for reguralisation, 4*area/perimeter"
		annotation (Dialog(tab="Advanced",group="Model regularisation", enable=useDoor));
 constant Modelica.Units.SI.ReynoldsNumber REtrans=30 "Assumed Reynolds number at transition";
 constant Modelica.Units.SI.DynamicViscosity VItrans=0.0000181625 "Assumed dynamic viscosity of air at transition";

 final parameter Medium.ThermodynamicState state_default=Medium.setState_pTX(
		T=Medium.T_default,
		p=Medium.p_default,
		X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
 final parameter Modelica.Units.SI.Density rho_default=Medium.density(state=state_default) "Medium default density";

 Modelica.Blocks.Interfaces.RealInput y(min=0, max=1, unit="1") if useDoorModel and use_y
	"Opening signal, 0=closed, 1=open"
		annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
 IDEAS.Airflow.Multizone.Point_m_flow point_m_flow1(
	redeclare package Medium = Medium,
	dp_turbulent=dp_turbulent,
	dpMea_nominal = dpCloRat,
	forceErrorControlOnFlow=forceErrorControlOnFlow,
	mMea_flow_nominal=
		if openDoorOnePort then wOpe*hOpe*rho_default*CDCloRat*(2*dpCloRat/rho_default)^mClo
		else (if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then 0.5 else 1)*(q50/3600*rho_default)*A_q50,
	m = if openDoorOnePort then mOpe else mClo,
	useDefaultProperties = false)
	if not useDoorModel
	"Pressure drop equation" 
		annotation (Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 IDEAS.Airflow.Multizone.MediumColumnReversible col_b1(
	redeclare package Medium = Medium, h=h_b1)
	if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and not useDoorModel 
	"Column for port b1"
		annotation (Placement(visible=true,
         transformation(
         origin={0,70},
         extent={{50,-10},{70,10}},
         rotation=0)));
 IDEAS.Airflow.Multizone.MediumColumnReversible col_a1(
	redeclare package Medium = Medium, h=h_a1)
	if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and not useDoorModel
	"Column for port a1"
		annotation (Placement(visible=true,
         transformation(
         origin={0,70},
         extent={{-70,-10},{-50,10}},
         rotation=0)));
 IDEAS.Airflow.Multizone.MediumColumnReversible col_b2(
	redeclare package Medium = Medium, h=h_b2)
	if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and not useDoorModel 
	"Column for port b2"
		annotation (Placement(visible=true,
         transformation(
         origin={0,-50},
         extent={{-70,-10},{-50,10}},
         rotation=0)));
 IDEAS.Airflow.Multizone.MediumColumnReversible col_a2(
	redeclare package Medium = Medium, h=h_a2)
	if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and not useDoorModel 
	"Column for port a2" 
		annotation (Placement(visible=true,
         transformation(
         origin={0,-50},
         extent={{50,-10},{70,10}},
         rotation=0)));
 IDEAS.Airflow.Multizone.Point_m_flow point_m_flow2(
	redeclare package Medium = Medium,
	dp_turbulent=dp_turbulent,
	dpMea_nominal = dpCloRat,
	forceErrorControlOnFlow=forceErrorControlOnFlow,
	m = mClo,
	mMea_flow_nominal = (q50/3600*rho_default)*A_q50*0.5,
	useDefaultProperties = false)
	if interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and not useDoorModel
	"Pressure drop equation" 
		annotation (Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 IDEAS.Airflow.Multizone.DoorDiscretizedOperable doo(
	forceErrorControlOnFlow=forceErrorControlOnFlow,
	final dh=
		if IDEAS.Utilities.Math.Functions.isAngle(inc,IDEAS.Types.Tilt.Ceiling) or IDEAS.Utilities.Math.Functions.isAngle(inc,IDEAS.Types.Tilt.Floor) then 0 
		else doo.hOpe*sin(inc)/nCom,
	redeclare package Medium = Medium,
	final hA=hA,
	final hB=hB,
	dp_turbulent=dp_turbulent,
	nCom=nCom,
	CDOpe=CDOpe,
	CDClo=CDCloRat,
	mOpe=mOpe,
	mClo=mClo,
	CDCloRat=CDCloRat,
	wOpe=wOpe,
	hOpe=hOpe,
	dpCloRat=dpCloRat,
	LClo=LClo,
	vZer=MFtrans/(rho_default*doo.wOpe*doo.hOpe)/1000)
	if useDoorModel
		annotation (Placement(visible = true, transformation(origin={-2,0},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 IDEAS.Fluid.Sources.Boundary_pT bou(
	redeclare package Medium = Medium,
	nPorts = 2)
	if interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
	"Sets absolute pressure when the ports are not connected externally"
		annotation (Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
 Modelica.Blocks.Sources.Constant constOne(final k=1)
	if not use_y
	"Door constantly opened"
		annotation (Placement(visible = true, transformation(origin = {-54, -14}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));

initial equation
  assert( not (interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts and useDoorModel and use_y),
  "In " +getInstanceName() + ": Cannot use a controllable door unless interZonalAirFlowType == TwoPorts.");

  assert(interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
  "In " +getInstanceName() + ": Needs the interZonalAirFlowType to be different from interZonalAirFlowType == None.");
equation
 connect(col_a1.port_a, point_m_flow1.port_a) annotation (Line(points = {{-60, 80}, {-60, 84}, {-20, 84}, {-20, 60}, {-10, 60}}, color = {0, 127, 255}));
 connect(col_b1.port_a, point_m_flow1.port_b) annotation (Line(points = {{60, 80}, {60, 84}, {20, 84}, {20, 60}, {10, 60}}, color = {0, 127, 255}));
 connect(col_b2.port_a, point_m_flow2.port_a) annotation (Line(points = {{-60, -40}, {-60, -36}, {-20, -36}, {-20, -60}, {-10, -60}}, color = {0, 127, 255}));
 connect(col_a2.port_a, point_m_flow2.port_b) annotation (Line(points = {{60, -40}, {60, -36}, {20, -36}, {20, -60}, {10, -60}}, color = {0, 127, 255}));
 connect(col_b2.port_b, port_b2) annotation (Line(points = {{-60, -60}, {-100, -60}}, color = {0, 127, 255}));
 connect(col_a2.port_b, port_a2) annotation (Line(points = {{60, -60}, {100, -60}}, color = {0, 127, 255}));
 connect(col_b1.port_b, port_b1) annotation (Line(points = {{60, 60}, {100, 60}}, color = {0, 127, 255}));
 connect(col_a1.port_b, port_a1) annotation (Line(points = {{-60, 60}, {-100, 60}}, color = {0, 127, 255}));
 connect(y, doo.y) annotation (Line(points={{-110,0},{-13,0}},color = {0, 0, 127}));
 connect(bou.ports[1], port_a2) annotation (Line(points={{-1,-80},{100,-80},{100,-60}},color = {0, 127, 255}));
 if  interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then
	connect(point_m_flow1.port_a, port_a1) annotation (Line(points = {{-10, 60}, {-100, 60}}, color = {0, 127, 255}));
	connect(point_m_flow1.port_b, port_b1) annotation (Line(points = {{10, 60}, {100, 60}}, color = {0, 127, 255}));
 end if;
 connect(constOne.y, doo.y) annotation (Line(points={{-47.4,-14},{-32,-14},{-32,0},{-13,0}},color = {0, 0, 127}));
 connect(bou.ports[2], port_b2) annotation (Line(points={{1,-80},{-100,-80},{-100,-60}},color = {0, 127, 255}));
 connect(doo.port_a1, port_a1) annotation (Line(points={{-12,6},{-30,6},{-30,60},{-100,60}},color = {0, 127, 255}));
 connect(doo.port_b1, port_b1) annotation (Line(points={{8,6},{30,6},{30,60},{100,60}},color = {0, 127, 255}));
 connect(doo.port_b2, port_b2) annotation (Line(points={{-12,-6},{-20,-6},{-20,-34},{-100,-34},{-100,-60}},color = {0, 127, 255}));
 connect(doo.port_a2, port_a2) annotation (Line(points={{8,-6},{20,-6},{20,-34},{100,-34},{100,-60}},color = {0, 127, 255}));

annotation(Documentation(info="<html>
<p>
This component models infiltration or a large opening in a wall and 
mainly used for the embedded airflow implementation in 
<a href=\"IDEAS.Buildings.Components\">IDEAS.Buildings.Components</a>. 
More information on the consequences of selecting an <code>interZonalAirFlowType</code> 
can be found in the documentation of 
<a href=\"IDEAS.BoundaryConditions.SimInfoManager\">IDEAS.BoundaryConditions.SimInfoManager</a>. 
Based on the selected <b><code>interZonalAirFlowType</code></b> either 1 fluid port of 2 fluid ports 
are used in this model where the 2-port configuration includes 
<a href=\"IDEAS.Airflow.Multizone.MediumColumnReversible\">density columns</a> 
to model stack-effect.Then, you can choose if the model needs to 
represent a large opening or cracks infiltration. 
</p>
<p>
for <code>interZonalAirFlowType=</code><b><code>OnePort</code></b>
</p>
<ul>
<li>
Both the crack or the large opening are represented by a single 
<a href=\"IDEAS.Airflow.Multizone.Point_m_flow\">airflow path</a> 
but the inputs to the used model are different. If it is modelled as a large opening, 
it can not be configured to be an operable. 
</li>
</ul>
<p>
for <code>interZonalAirFlowType=<code><b><code>TwoPort</code></b>
</p>
<ul>
<li>
The cracks are represented by two airflow paths with variable relative stack-effect 
heights based on parameters <code>h_b1, h_b2, h_a1, h_a2</code>. 
These parameters are the vertical height difference between the reference pressure 
(typically the middle of the zone) 
and the airflow path, where height zero is at the reference pressure.
</li>
<li>
When the component is configured to represent a large opening, 
the two airflow path models are replaced by a 
<a href=\"IDEAS.Airflow.Multizone.DoorDiscretizedOperable\">IDEAS.Airflow.Multizone.DoorDiscretizedOperable</a> 
model. 
In this case the relative stack-effect heights follow the convention as set by 
the underlying model and <code>hA and hB </code>need to be set, 
where height zero is at the bottom point of the large opening.
Furthermore, this large opening model can be configured to to be operable. 
</li>
</ul>
<p>
for <code>interZonalAirFlowType=</code><b><code>None</code></b> 
the model can not be used.
</p>
</html>",
revisions="<html>
<ul>
<li>
August 13, 2025, by Klaas De Jonge:<br>
Added documentation and cleaned up conditional statements, 
including enabling relevant parameters in the dialog box.
</li>
<li>
February 4, 2025, by Jelger Jansen:<br>
Added <code>Modelica.Units.</code> 
to one or multiple parameter(s) due to the removal of 
<code>import</code> in IDEAS/package.mo. 
See <a href=\"\\\"https://github.com/open-ideas/IDEAS/issues/1415\\\"\">#1415</a> . 
</li>
<li>
January 30, 2025, by Klaas De Jonge:<br>
Changed wrong parameter declaration <code>doo.vZer</code> 
to have compatible units. 
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1402\">#1402</a>.
</li>
<li>
October 30, 2024, by Klaas De Jonge:<br>
Changes for column heights,used default density and transition point to laminar flow at low dp.
</li>
<li>
October 20, 2023 by Filip Jorissen:<br>
First documented version.
</li>
</ul>
</html>"),
    Diagram,
 Icon(graphics={  Polygon(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-30, -10}, {-16, -8}, {-16, -14}, {-30, -16}, {-30, -10}}), Line(points = {{-54, 48}, {-36, 48}}), Line(points = {{-54, 20}, {-36, 20}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{-54, -58}, {-36, -58}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 128, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-46, -16}, {-20, -20}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {85, 75, 55}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, 80}, {60, -84}}), Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-54, 72}, {56, -84}}), Polygon(fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{56, 72}, {-36, 66}, {-36, -90}, {56, -84}, {56, 72}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 128, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 2}, {-46, -2}}), Polygon(visible = false, origin = {75, 50}, rotation = 360, lineColor = {0, 128, 255}, fillColor = {0, 128, 255}, fillPattern = FillPattern.Solid, points = {{-5, 10}, {25, 10}, {-5, -10}, {-5, 10}}), Text(textColor = {0, 0, 127}, extent = {{-118, 34}, {-98, 16}}, textString = "y"), Line(points = {{-54, -6}, {-36, -6}}), Line(points = {{-54, -32}, {-36, -32}}), Polygon(visible = false, origin = {-79, -50}, rotation = 360, lineColor = {0, 128, 255}, fillColor = {0, 128, 255}, fillPattern = FillPattern.Solid, points = {{10, 10}, {-20, -10}, {10, -10}, {10, 10}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 128, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-46, 2}, {-40, -16}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end CrackOrOperableDoor;

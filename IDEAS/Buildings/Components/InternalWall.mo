within IDEAS.Buildings.Components;

model InternalWall "interior opaque wall between two zones"
  extends IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface(
    final use_custom_q50=true,
    custom_q50=if IDEAS.Utilities.Math.Functions.isAngle(incInt, 0) or IDEAS.Utilities.Math.Functions.isAngle(incInt, Modelica.Constants.pi) then 0 else 2,
    final nWin=1,
    dT_nominal_a=1,
    E(y=if sim.computeConservationOfEnergy then layMul.E else 0),
    Qgai(y=(if sim.openSystemConservationOfEnergy or not sim.computeConservationOfEnergy
           then 0 else sum(port_emb.Q_flow))),
	final QTra_design(fixed=false),
    q50_zone(v50_surf=0, nDum=4),
    crackOrOperableDoor(
      h_b1=-0.5*hzone_a + 0.75*hVertical + hRelSurfBot_a + hThCor,
      h_a1=-0.5*hzone_b + 0.75*hVertical + hRelSurfBot_b - hThCor,
      h_b2=-0.5*hzone_b + 0.25*hVertical + hRelSurfBot_b - hThCor,
      h_a2=-0.5*hzone_a + 0.25*hVertical + hRelSurfBot_a + hThCor,
      hA=0.5*hzone_b - hRelSurfBot_b - hRelOpeBot_b + hThCor,
      hB=0.5*hzone_a - hRelSurfBot_a - hRelOpeBot_a - hThCor,
      openDoorOnePort=true,
      useDoor=hasCavity,
      use_y=use_y_doo,
      wOpe=w,
      hOpe=h,
      CDOpe=CD));
  //using custom q50 since this model is not an external component

  parameter Boolean linIntCon_b=sim.linIntCon
    "= true, if convective heat transfer should be linearised"
    annotation(Dialog(tab="Convection"));
  parameter Modelica.Units.SI.TemperatureDifference dT_nominal_b=1
    "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder"
    annotation (Dialog(tab="Convection"));
  Modelica.Units.SI.Temperature TRef_b = propsBus_b.TRefZon
    "Reference temperature of zone on side of propsBus_b, for calculation of design heat loss";

  // open door modelling
  parameter Boolean hasCavity = false
    "=true, to model open door or cavity in wall"
    annotation(Dialog(group="Cavity or open door"));
  parameter Modelica.Units.SI.Length h = 2
    "Height of (rectangular) cavity in wall"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door"));
  parameter Modelica.Units.SI.Length w = 1
    "Width of (rectangular) cavity in wall"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door"));

  parameter  Modelica.Units.SI.Length hRelOpeBot_a=0 "Vertical distance at propsbus a between the bottom of the surface that contains an (operable) opening and the bottom of the opening" annotation(Dialog(group="Cavity or open door"));
  parameter  Modelica.Units.SI.Length hRelOpeBot_b=0 "Vertical distance at propsbus b between the bottom of the surface that contains an (operable) opening and the bottom of the opening" annotation(Dialog(group="Cavity or open door"));
  parameter Modelica.Units.SI.Acceleration g = Modelica.Constants.g_n
    "Gravity, for computation of buoyancy"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.Units.SI.Pressure p=101300
    "Absolute pressure for computation of buoyancy"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.Units.SI.Density rho = p/r/T
    "Nominal density for computation of buoyancy mass flow rate"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p = 1013
    "Nominal heat capacity for computation of buoyancy heat flow rate"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.Units.SI.Temperature T=293
    "Nominal temperature for linearising heat flow rate"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.Units.SI.TemperatureDifference dT = 1
    "Nominal temperature difference when linearising heat flow rate"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Boolean use_y_doo = false
    "=true, to enable controllable cavity (door) input"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Boolean CheckVH=true "Enable to not check vertical heights, if an internal floor or element is connected to the same zone at both sides this should be set to false" annotation(Dialog(group="Vertical height check",tab="Airflow"));

  IDEAS.Buildings.Components.Interfaces.ZoneBus propsBus_b(
    redeclare final package Medium = Medium,
    numIncAndAziInBus=sim.numIncAndAziInBus,
    outputAngles=sim.outputAngles,
    final use_port_1=sim.use_port_1,
    final use_port_2=sim.use_port_2)
    "If inc = Floor, then propsbus_b should be connected to the zone below this floor.
      If inc = Ceiling, then propsbus_b should be connected to the zone above this ceiling." 
      annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-100, 20}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-50, 20})));
  parameter Real CD = 0.78
    "Discharge coefficient of cavity" 
    annotation(Dialog(group="Cavity or open door",tab="Advanced"));
  final parameter Real hzone_b(fixed=false);
  final parameter Real hAbs_floor_b(fixed=false);


  parameter Modelica.Units.SI.Length hRelSurfBot_b=if
      IDEAS.Utilities.Math.Functions.isAngle(incInt, IDEAS.Types.Tilt.Floor)
       then hzone_b else 0
    "Height above the zone floor at propsbus_b. Height where the surface starts. e.g. 0 for walls at floor level and floors.  ";
  Modelica.Blocks.Interfaces.RealInput y_doo(min = 0, max = 1) if use_y_doo and useDooOpe 
    "Control input for the door" annotation(
    Placement(visible = true, transformation(origin = {-80, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-64, 88}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary3_a(
    redeclare package Medium = Medium, 
    m_flow = 1e-10, 
    nPorts = 1)  if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
     "Boundary for bus a" annotation(
    Placement(transformation(origin = {48, -4}, extent = {{-28, -76}, {-8, -56}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary3_b(
    redeclare package Medium = Medium, 
    m_flow = 1e-10, 
    nPorts = 1)  if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts 
    "Boundary for bus b" annotation(
    Placement(transformation(origin = {-48, -4}, extent = {{28, -76}, {8, -56}}, rotation = -0)));
protected
  parameter Real Ope_hvert = sin(incInt)*h "Vertical opening height, height of the surface projected to the vertical, 0 for openings in horizontal floors and ceilings" annotation (
    Dialog(enable=hasCavity,group="Cavity or open door"));
  final parameter Real U_value = 1/(1/8 + sum(constructionType.mats.R) + 1/8) "Wall U-value";
  constant Real r = 287 "Gas constant";
  Modelica.Blocks.Sources.Constant constOne(final k = 1) if useDooOpe and not use_y_doo "Constant value of one";
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection intCon_b(
    linearise=linIntCon_b or sim.linearise,
    dT_nominal=dT_nominal_b,
    final inc=incInt + Modelica.Constants.pi,
    final A=A)
    "convective surface heat transimission on the interior side of the wall"
    annotation (Placement(transformation(extent={{-22,-10},{-42,10}})));
  Modelica.Blocks.Sources.RealExpression QDesign_b(y=-QTra_design);
  //Negative, because of its losses from zone side b to zone side a, opposite of calculation of QTra_design

  Modelica.Blocks.Sources.RealExpression incExp1(y=incInt + Modelica.Constants.pi)
    "Inclination angle";
  Modelica.Blocks.Sources.RealExpression aziExp1(y=aziInt + Modelica.Constants.pi)
    "Azimuth angle expression";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDif1(final Q_flow=0);
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDir1(final Q_flow=0);
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Qgai_b(final Q_flow=0);
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.PrescribedEnergy E_b;
  Modelica.Blocks.Sources.Constant E0(final k=0)
    "All internal energy is assigned to right side"; 
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow theConDoor(
    linearise=sim.linearise or linIntCon_a or linIntCon_b,
    h=h,
    w=w,
    g=g,
    p=p,
    rho=rho,
    c_p=c_p,
    T=T,
    dT=dT)
    if hasCavity and sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
    "Thermal-only model for open door"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  final parameter Boolean useDooOpe = hasCavity and sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts;
  final parameter Real hThCor=cos(incInt)*sum(constructionType.mats.d)/2 "Vertically projected internal wall thickness";

initial equation
  hzone_b = propsBus_b.hzone;
  hAbs_floor_b = propsBus_b.hfloor;
  QTra_design=U_value*A*(TRefZon - TRef_b)
    "TRefZon is the reference temperature for heat loss calculations of the zone connected to propsbus_a,
     TRef_b is the reference temperature for heat loss calculations of the zone connected to propsBus_b";

  if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None and hasCavity == true then
    assert(IDEAS.Utilities.Math.Functions.isAngle(incInt, IDEAS.Types.Tilt.Wall), "In " + getInstanceName() + ": Cavities without airflow are only supported for vertical walls, but inc=" + String(incInt) + ". The model is not accurate.", level = AssertionLevel.warning);
  end if;

  if CheckVH and sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None and IDEAS.Utilities.Math.Functions.isAngle(incInt,0) then
    assert(hAbs_floor_a<hAbs_floor_b, getInstanceName()+ " is a ceiling, but the floor of the zone at probsbus_b (hfloor="+String(hAbs_floor_b) +") does not lie below the floor of zone at probsbus_a (hfloor="+String(hAbs_floor_a) +"), this should be fixed",level=AssertionLevel.error);
  elseif CheckVH and sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None and IDEAS.Utilities.Math.Functions.isAngle(incInt,Modelica.Constants.pi) then
    assert(hAbs_floor_a>hAbs_floor_b, getInstanceName()+ " is a floor, but the floor of the zone at probsbus_a (hfloor="+String(hAbs_floor_a) +") does not lie below the floor of zone at probsbus_b (hfloor="+String(hAbs_floor_b) +"), this should be fixed",level=AssertionLevel.error);
  end if;

  if CheckVH and sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then
  assert(Modelica.Math.isEqual(hAbs_floor_a+hRelSurfBot_a+hThCor,hAbs_floor_b+hRelSurfBot_b-hThCor,0.15),"The absolute height of internal wall (centerline) "+ getInstanceName() +" does not match within a 15cm margin between both sides of the wall, check the input for the floor thickness and hfloor,hzone of the corresponding zones. At propsbus_a the absolute surface centerline height is "+String(hAbs_floor_a+hRelSurfBot_a+hThCor)+"m while at propsbus_b the absolute surface centerline height is "+String(hAbs_floor_b+hRelSurfBot_b-hThCor)+"m",level=AssertionLevel.error);
  assert(Modelica.Math.isEqual(hAbs_floor_a+hRelSurfBot_a+hRelOpeBot_a+hThCor,hAbs_floor_b+hRelSurfBot_b+hRelOpeBot_b-hThCor,0.15),"The absolute height of the large cavity in internal wall "+ getInstanceName() +" does not match within a 15cm margin between both sides of the wall, check the input for the relative opening height, the floor thickness and hfloor,hzone of the corresponding zones. At propsbus_a the opening its absolute starting height is "+String(hAbs_floor_a+hRelSurfBot_a+hRelOpeBot_a+hThCor)+"m while at propsbus_b the opening its absolute starting height is "+String(hAbs_floor_b+hRelSurfBot_b+hRelOpeBot_b-hThCor)+"m",level=AssertionLevel.error);
  end if;

  if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then
  assert(CheckVH,"Vertical height check was disabled for "+getInstanceName()+" but InterZonalAirFlow.TwoPorts is active",AssertionLevel.warning);
  end if;

equation
  connect(constOne.y, crackOrOperableDoor.y);
  connect(layMul.port_b, propsBus_b.surfRad) annotation(
    Line(points = {{-10, 0}, {-18, 0}, {-18, 20.1}, {-100.1, 20.1}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(propsBus_b.surfCon, intCon_b.port_b) annotation(
    Line(points = {{-100.1, 20.1}, {-48, 20.1}, {-48, 0}, {-42, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(layMul.port_b, intCon_b.port_a) annotation(
    Line(points = {{-10, 0}, {-22, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(layMul.iEpsSw_b, propsBus_b.epsSw) annotation(
    Line(points = {{-10, 4}, {-22, 4}, {-22, 20.1}, {-100.1, 20.1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(layMul.iEpsLw_b, propsBus_b.epsLw) annotation(
    Line(points = {{-10, 8}, {-20, 8}, {-20, 20.1}, {-100.1, 20.1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(layMul.area, propsBus_b.area) annotation(
    Line(points = {{0, 10}, {0, 20.1}, {-100.1, 20.1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(iSolDif1.port, propsBus_b.iSolDif);
  connect(iSolDir1.port, propsBus_b.iSolDir);
  connect(QDesign_b.y, propsBus_b.QTra_design);
  connect(incExp1.y, propsBus_b.inc);
  connect(aziExp1.y, propsBus_b.azi);
  connect(Qgai_b.port, propsBus_b.Qgai);
  connect(E_b.port, propsBus_b.E);
  connect(E_b.E, E0.y);
  connect(theConDoor.port_a, propsBus_b.surfCon) annotation(
    Line(points = {{-10, 40}, {-48, 40}, {-48, 20.1}, {-100.1, 20.1}}, color = {191, 0, 0}));
  connect(theConDoor.port_b, propsBusInt.surfCon) annotation(
    Line(points = {{10, 40}, {46, 40}, {46, 19.91}, {56.09, 19.91}}, color = {191, 0, 0}));
  connect(q50_zone.v50, propsBus_b.v50) annotation(
    Line(points = {{79, -58}, {56, -58}, {56, 20.1}, {-100.1, 20.1}}, color = {0, 0, 127}));
  connect(q50_zone.using_custom_q50, propsBus_b.use_custom_q50) annotation(
    Line(points = {{79, -52}, {56, -52}, {56, 20.1}, {-100.1, 20.1}}, color = {0, 0, 127}));
   if sim.use_port_1 then
    connect(crackOrOperableDoor.port_a1, propsBus_b.port_1) annotation(
      Line(points = {{20, -46}, {-60, -46}, {-60, 20}, {-100, 20}}, color = {0, 127, 255}));
  end if;
  if sim.use_port_2 then
    connect(crackOrOperableDoor.port_b2, propsBus_b.port_2) annotation(
      Line(points = {{20, -58}, {-58, -58}, {-58, 20}, {-100, 20}}));
  end if;
  connect(y_doo, crackOrOperableDoor.y) annotation(
    Line(points = {{-80, 90}, {-52, 90}, {-52, -52}, {20, -52}}, color = {0, 0, 127}));
  connect(boundary3_b.ports[1], propsBus_b.port_3) annotation(
    Line(points = {{-40, -70}, {-52, -70}, {-52, 20}, {-100, 20}}, color = {0, 127, 255}));
  connect(boundary3_a.ports[1], propsBusInt.port_3) annotation(
    Line(points = {{40, -70}, {56, -70}, {56, 20}}, color = {0, 127, 255}));
  connect(q50_zone.dummy_h[3], propsBus_b.hzone);
  connect(q50_zone.dummy_h[4], propsBus_b.hfloor);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-60,-100},{60,100}}),
        graphics={
        Rectangle(
          extent={{-52,-90},{48,-70}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,80},{50,100}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-70}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(points={{-50,80},{50,80}}, color={175,175,175}),
        Line(points={{-50,-70},{50,-70}}, color={175,175,175}),
        Line(points={{-50,-90},{50,-90}}, color={175,175,175}),
        Line(points={{-50,100},{50,100}}, color={175,175,175}),
        Line(
          points={{-10,80},{-10,-70}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,80},{10,-70}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-60,-100},{60,
            100}})),
    Documentation(info="<html>
<p>
This is a wall model that should be used
to simulate a wall or floor between two zones.
See <a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface>IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface</a> 
for equations, options, parameters, validation and dynamics that are common for all surfaces.
</p>
<h4>Typical use and important parameters</h4>
<p>
Each propsbus needs to be connected to a zone, which may be the same zone.
</p>
<p>
Note that this model is not symmetric: the convection equations depend on the inclination <code>inc</code>,
which is turned 180 degrees between both side. The value of <code>inc</code> is applied to the right side of the model (propsBus_a).
</p>
<p>
Parameter <code>hasCavity</code> can be set to <code>true</code> to simulate heat transfer
through a cavity such as an open door in a simplified way.
The cavity height <code>h</code> and width <code>w</code> then have to be specified.
We assume that the value of <code>A</code> excludes the surface area of the cavity.
</p>
</html>", revisions = "<html>
<ul>
<li>
February 5, 2025, by Klaas De Jonge:<br/>
Support was added to the twoport airflow implementation that acounts for the floor thickness.
</li>
<li>
February 4, 2025, by Klaas De Jonge:<br/>
Boolean to disable vertical height check was added
</li>
<li>
January 24, 2025, by Klaas De Jonge:<br/>
Add dummy connections for <code>hzone</code> and <code>hfloor</code> in <code>propsbus_b</code> to avoid translation warnings.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1402\">#1402</a>
</li>
<li>
November 7, 2024, by Anna Dell'Isola and Jelger Jansen:<br/>
Update calculation of transmission design losses.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1337\">#1337</a>
</li>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
Modifications for stack-effect interzonal airflow heights.
</li>
<li>
Februari 18, 2024, by Filip Jorissen:<br/>
Modifications for supporting trickle vents and interzonal airflow.
</li>
<li>
July 9, 2023, by Filip Jorissen:<br/>
Replaced door by operable door.
</li>
<li>
August 2, 2022, by Filip Jorissen:<br/>
Activating thermal model when using OnePorts.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1291\">
#1291</a>
</li>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
July 29, 2020, by Filip Jorissen:<br/>
Removed duplicate definition of <code>port_emb</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1158\">
#1158</a>
</li>
<li>
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
Set nWin final to 1 as this should only be used for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>. 
</li>
<li>
May 21, 2018, by Filip Jorissen:<br/>
Added model for air flow through cavity.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/822\">#822</a>.
</li>
<li>
January 2, 2017, by Filip Jorissen:<br/>
Updated icon layer.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
</ul>
</html>"));
end InternalWall;
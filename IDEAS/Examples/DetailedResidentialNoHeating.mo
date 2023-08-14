within IDEAS.Examples;
model DetailedResidentialNoHeating
  "Detailed model of a residential building envelope without heating"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager sim(
    lineariseJModelica=false,
    interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort,
    incAndAziInBus={{IDEAS.Types.Tilt.Ceiling,0},{IDEAS.Types.Tilt.Wall,downAngle},{IDEAS.Types.Tilt.Wall,leftAngle},{IDEAS.Types.Tilt.Wall,upAngle},{IDEAS.Types.Tilt.Wall,rightAngle}, {IDEAS.Types.Tilt.Floor,0}})
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));


  parameter Real mSenFac = 5;
  parameter Modelica.Units.SI.Temperature T_start = Modelica.Units.Conversions.from_degC(22);
  replaceable package MediumAir = IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Air medium";
  replaceable package MediumWater = IDEAS.Media.Water "Water medium";

  constant Modelica.Units.SI.Angle upAngle = IDEAS.Types.Azimuth.N + (-4.029663118524404);
  constant Modelica.Units.SI.Angle rightAngle = IDEAS.Types.Azimuth.E + (-4.029663118524404);
  constant Modelica.Units.SI.Angle downAngle = IDEAS.Types.Azimuth.S + (-4.029663118524404);
  constant Modelica.Units.SI.Angle leftAngle = IDEAS.Types.Azimuth.W + (-4.029663118524404);

  // control inputs

  Modelica.Blocks.Interfaces.RealInput window_living_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__living'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_hall_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__hall'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_diner_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__diner'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_bed_strt1_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__bed_strt1'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_box_2_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__box_2'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_box_mid_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__box_mid'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_bathroom_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__bathroom'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_bed_garden2_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__bed_garden2'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_bed_garden1_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__bed_garden1'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_bed_strt2_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__bed_strt2'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_hall_2_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__hall__2'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_living_slide_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__living_slide'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput window_kitchen_slide_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'window__kitchen_slide'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput skylight_zone_polyvalent_skylight_type_1_controlsignal(min=0, max=1) "Screen control signal, 1 means closed 'skylight_zone__polyvalent__skylight_type_1'"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput extractionfan_extraction_fan_1_controlsignal(min=0, max=1000) "Control signal for extraction fan extractionFan__extraction_fan_1"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_kitchen_vavr_type_1_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__kitchen__vavr_type_1"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_storage_vavr_type_2_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__storage__vavr_type_2"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_toilet_vavr_type_3_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__toilet__vavr_type_3"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_bathroom_vavr_type_2_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__bathroom__vavr_type_2"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_bed_garden_vavr_type_4_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__bed_garden__vavr_type_4"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_bed_street_vavr_type_4_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__bed_street__vavr_type_4"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_polyvalent_vavr_type_4_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__polyvalent__vavr_type_4"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput returnvav_zone_toilet2_vavr_type_3_controlsignal(min=0, max=1) "Control signal for extraction VAV returnVav_zone__toilet2__vavr_type_3"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));


  // records
  record constructiontype__outer_wall
     "Outer wall"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Wall,
    final mats={
      IDEAS.Buildings.Data.Materials.Brick(d=0.08),
      IDEAS.Buildings.Data.Materials.Air(d=0.04),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.1),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01)});
  end constructiontype__outer_wall;

  record constructiontype__brick_internal_wall
     "Brick internal wall"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Wall,
    final mats={
      IDEAS.Buildings.Data.Materials.Brick(d=0.08)});
  end constructiontype__brick_internal_wall;

  record constructiontype__floor_outer
     "Susp. flr. on concrete"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Floor,
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.15),
      IDEAS.Buildings.Data.Materials.Air(d=0.3),
      IDEAS.Buildings.Data.Materials.Plywood(d=0.02)});
  end constructiontype__floor_outer;

  record constructiontype__wall
     "Custom wall"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Wall,
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.04),
      IDEAS.Buildings.Data.Insulation.Pur(d=0.16),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.12),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.04)});
  end constructiontype__wall;

  record constructiontype__roof
     "Custom roof"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Ceiling,
    final mats={
      IDEAS.Buildings.Data.Insulation.Pur(d=0.12),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.2),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.04)});
  end constructiontype__roof;

  record constructiontype__floor
     "Custom floor"
    extends IDEAS.Buildings.Data.Interfaces.Construction(
     incLastLay=IDEAS.Types.Tilt.Floor,
    final mats={
      IDEAS.Buildings.Data.Insulation.Pur(d=0.14),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.1)});
  end constructiontype__floor;

  //components

  IDEAS.Buildings.Components.SlabOnGround slabonground__1(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=65.375)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={54.705882352941174,0.0})));
  IDEAS.Buildings.Components.SlabOnGround slabonground__2(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=9.3125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={37.69230769230769,-16.73076923076923})));
  IDEAS.Buildings.Components.SlabOnGround slabonground__3(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=3.0625)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={30.0,1.25})));
  IDEAS.Buildings.Components.SlabOnGround slabonground__4(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=12.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={14.166666666666664,-15.0})));
  IDEAS.Buildings.Components.SlabOnGround slabonground__5(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=2.625)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={30.0,-15.0})));
  IDEAS.Buildings.Components.OuterWall ceiling__1(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__roof constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=2.2535221886551824,
    T_start=T_start,
    A=36.0)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.OuterWall ceiling__2(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__roof constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=2.2535221886551824,
    T_start=T_start,
    A=22.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={271.25,-12.083333333333332})));
  IDEAS.Buildings.Components.OuterWall ceiling__3(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__roof constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=2.2535221886551824,
    T_start=T_start,
    A=24.125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={265.6818181818182,30.909090909090907})));
  IDEAS.Buildings.Components.OuterWall ceiling__4(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__roof constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=2.2535221886551824,
    T_start=T_start,
    A=13.125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={215.35714285714283,35.0})));
  IDEAS.Buildings.Components.OuterWall ceiling__5(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__roof constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=2.2535221886551824,
    T_start=T_start,
    A=1.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={205.0,15.0})));
  IDEAS.Buildings.Components.InternalWall floor__1(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=6.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.InternalWall floor__2(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=9.3125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.InternalWall floor__3(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=3.0625)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.InternalWall floor__4(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=12.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.InternalWall floor__5(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=2.625)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.InternalWall floor__6(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=20.375)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={271.25,-12.083333333333332})));
  IDEAS.Buildings.Components.InternalWall floor__7(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=24.125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={265.6818181818182,30.909090909090907})));
  IDEAS.Buildings.Components.InternalWall floor__8(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=13.125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={215.35714285714283,35.0})));
  IDEAS.Buildings.Components.InternalWall floor__9(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor_outer constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=1.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={205.0,15.0})));
  IDEAS.Buildings.Components.OuterWall floor__10(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=2.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={228.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.OuterWall floor__11(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__floor constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=5.3951148422449755,
    T_start=T_start,
    A=2.125)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={271.25,-12.083333333333332})));
  model ExtractionFan
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "Pressure drop at nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_fan
    "Fan head set point";
  parameter IDEAS.Fluid.Types.InputType inputType
    "Control input type";
  parameter Real etaHydPar=0.5 "Hydraulic efficiency";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  IDEAS.Fluid.Sources.OutsideAir outsideAir(
    redeclare package Medium = Medium,
    azi=0,
    nPorts=1,
    CpAct=-0.4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,52})));
  IDEAS.Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    inputType=inputType,
    riseTime=90,
    per(hydraulicEfficiency(V_flow={1}, eta={etaHydPar})),
    dp_nominal=dp_fan)     "Fan" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  IDEAS.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    from_dp=true,
    dp_nominal=dp_nominal) "Series pressure drop" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));


  Modelica.Blocks.Interfaces.RealInput dp_in
    if inputType == IDEAS.Fluid.Types.InputType.Continuous
    "Fan head"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));
  equation
  connect(fan.port_b, outsideAir.ports[1])
    annotation (Line(points={{0,0},{0,42}}, color={0,127,255}));
  connect(port_a, res.port_a) annotation (Line(points={{0,-100},{0,-81},{-5.55112e-16,
          -81},{-5.55112e-16,-60}}, color={0,127,255}));
  connect(res.port_b, fan.port_a) annotation (Line(points={{6.10623e-16,-40},{6.10623e-16,
          -31},{0,-31},{0,-20}}, color={0,127,255}));
  connect(fan.dp_in, dp_in)
    annotation (Line(points={{-12,-10},{-120,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-110,-1},{48,-1}},color={28,108,200},
          origin={-1,10},
          rotation=90),
        Ellipse(
          extent={{-20,-24},{20,-64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Ellipse(
          extent={{-36,100},{36,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,127,255}),
        Polygon(
          points={{-14,19},{-14,-17},{16,1},{-14,19}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          origin={1,-40},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
April 12 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
  end ExtractionFan;

  IDEAS.Buildings.Components.Zone zone__kitchen(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=23,
    nPorts=1,
    V=169.975)
    "Kitchen"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={4.705882352941177,0.0})));
  IDEAS.Buildings.Components.Zone zone__entrance(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    nSurf=12,
    nPorts=0,
    V=24.212500000000002)
    "Entrance"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-12.307692307692308,-16.73076923076923})));
  IDEAS.Buildings.Components.Zone zone__hallway(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    nSurf=8,
    nPorts=0,
    V=7.9625)
    "Hallway"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-20.0,1.25})));
  IDEAS.Buildings.Components.Zone zone__storage(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=8,
    nPorts=1,
    V=32.5)
    "Storage room"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-35.833333333333336,-15.0})));
  IDEAS.Buildings.Components.Zone zone__toilet(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=8,
    nPorts=1,
    V=6.825)
    "Toilet"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-20.0,-15.0})));

  IDEAS.Buildings.Components.OuterWall outerwall__1(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    A=8.999999999999998)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={-2.5,55.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__2(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=5.550000000000001)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={47.5,32.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__3(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=13.05)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-52.5,32.5})));
  IDEAS.Buildings.Components.InternalWall internalwall__1(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=339.0600353877945,
    A=1.9500000000000002)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-1.25,10.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__4(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=14.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-52.5,-15.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__2(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=2,
    A=8.450000000000001)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={2.5,-6.25})));
  IDEAS.Buildings.Components.OuterWall outerwall__5(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=1.9250000000000005)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={45.0,-6.25})));
  IDEAS.Buildings.Components.OuterWall outerwall__6(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=10.149999999999999)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={27.5,-37.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__7(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=4.35)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={45.0,-30.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__8(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=7.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-40.0,-40.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__3(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=2,
    A=4.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-27.5,-31.25})));
  IDEAS.Buildings.Components.InternalWall internalwall__4(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=2,
    A=1.3)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={-25.0,-22.5})));
  IDEAS.Buildings.Components.InternalWall internalwall__5(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=3.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-16.25,-7.5})));
  IDEAS.Buildings.Components.InternalWall internalwall__6(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=2,
    A=4.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-10.0,1.25})));
  IDEAS.Buildings.Components.InternalWall internalwall__7(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=204.2360212326767,
    A=3.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-16.25,10.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__8(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=204.2360212326767,
    A=3.25)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={-16.25,-22.5})));
  IDEAS.Buildings.Components.InternalWall internalwall__9(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=2,
    A=3.9000000000000004)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-10.0,-15.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__10(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=1.3)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-25.0,-7.5})));
  IDEAS.Buildings.Components.InternalWall internalwall__11(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    custom_q50=2,
    A=3.9000000000000004)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={-27.5,-15.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__12(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=6.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-40.0,10.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__13(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=146.45430088048337,
    A=4.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={-27.5,1.25})));
  IDEAS.Buildings.Components.InternalWall internalwall__14(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=1.3)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-25.0,10.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__9(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=2.175)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={6.25,-40.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__10(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=4.75)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-10.0,-40.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__15(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=146.45430088048337,
    A=4.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={2.5,-31.25})));

  IDEAS.Buildings.Components.Zone zone__polyvalent(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=25,
    nPorts=1,
    V=93.60000000000001)
    "Polyvalent room"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={178.15789473684214,-3.552631578947368})));
  IDEAS.Buildings.Components.Zone zone__bed_street(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=11,
    nPorts=1,
    V=58.5)
    "Bedroom at the street side of the building"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={221.25,-12.083333333333332})));
  IDEAS.Buildings.Components.Zone zone__bed_garden(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=13,
    nPorts=1,
    V=62.725)
    "Bedroom at the garden side of the building"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={215.68181818181816,30.909090909090907})));
  IDEAS.Buildings.Components.Zone zone__bathroom(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=9,
    nPorts=1,
    V=34.125)
    "Bathroom"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={165.35714285714283,35.0})));
  IDEAS.Buildings.Components.Zone zone__toilet2(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow,
    allowFlowReversal=true,
    n50=3,
    final mSenFac=mSenFac,
    T_start=T_start,
    redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum,
    nSurf=6,
    nPorts=1,
    V=3.9000000000000004)
    "Toilet 2"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={155.0,15.0})));

  IDEAS.Buildings.Components.OuterWall outerwall__15(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=13.5)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={247.5,-15.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__16(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=10.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={225.0,-40.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__18(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    custom_q50=79.78308508949104,
    A=8.450000000000001)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={202.5,-6.25})));
  IDEAS.Buildings.Components.OuterWall outerwall__17(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=2.9)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={247.5,15.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__18(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    A=10.149999999999999)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={247.5,37.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__19(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    A=5.45)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={232.5,55.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__19(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=114.35334512926484,
    A=5.8500000000000005)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={213.75,10.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__20(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    custom_q50=2,
    A=2.6)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={225.0,15.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__21(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=339.0600353877945,
    A=1.9500000000000002)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={221.25,20.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__22(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=2,
    A=5.8500000000000005)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={236.25,10.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__20(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    A=5.074999999999999)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={156.25,55.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__21(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=2.9)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={147.5,15.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__22(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=10.149999999999999)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={147.5,37.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__23(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    A=5.45)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={202.5,55.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__23(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=2,
    A=7.800000000000001)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={202.5,20.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__24(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=254.7950265408459,
    A=2.6)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={162.5,15.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__25(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    custom_q50=2,
    A=3.9000000000000004)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={155.0,20.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__26(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=2,
    A=3.9000000000000004)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={155.0,10.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__24(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=2.9)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={142.5,-22.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__25(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=5.074999999999999)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={147.5,-31.25})));
  IDEAS.Buildings.Components.OuterWall outerwall__26(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=2.9)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={147.5,5.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__27(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    A=1.5250000000000001)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={137.5,-11.25})));
  IDEAS.Buildings.Components.InternalWall internalwall__27(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    T_start=T_start,
    custom_q50=74.22715044024169,
    A=9.1)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={185.0,37.5})));
  IDEAS.Buildings.Components.OuterWall outerwall__28(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    T_start=T_start,
    A=2.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={175.0,55.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__28(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    custom_q50=128.39751327042296,
    A=5.2)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={175.0,20.0})));
  IDEAS.Buildings.Components.OuterWall outerwall__29(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    T_start=T_start,
    A=12.325)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={168.75,-40.0})));
  IDEAS.Buildings.Components.InternalWall internalwall__29(
    redeclare package Medium=MediumAir,
    redeclare constructiontype__brick_internal_wall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    T_start=T_start,
    custom_q50=2,
    A=4.55)
    "Opaque wall model"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={202.5,-31.25})));

  IDEAS.Buildings.Components.Window window__living(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    use_trickle_vent=true,
    dp_nominal=10,
    m_flow_nominal=0.05,
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    nWin=1,
    A=7.5)
    "0.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={47.5,25.0})));
  IDEAS.Buildings.Components.Window window__hall(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    nWin=1,
    A=2.5)
    "-90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={-2.5,-40.0})));
  IDEAS.Buildings.Components.Window window__diner(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.Overhang stateShading2(haveBoundaryPorts=false, hWin=2.5, wWin=3, wLeft=10, wRight=10, dep=0.5, gap=0)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    nWin=1,
    A=7.5)
    "0.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={45.0,-10.0})));
  IDEAS.Buildings.Components.Window window__bed_strt1(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.Box stateShading2(haveBoundaryPorts=false, hWin=1, wWin=2.5, wLeft=10, wRight=10, ovDep=0.2, ovGap=0, hFin=10, finDep=0.2, finGap=0)),
    use_trickle_vent=true,
    dp_nominal=10,
    m_flow_nominal=0.041666666666666664,
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    nWin=1,
    A=2.5)
    "-90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={235.0,-40.0})));
  IDEAS.Buildings.Components.Window window__box_2(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=2.5)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={142.5,0.0})));
  IDEAS.Buildings.Components.Window window__box_mid(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=3.824318515450079,
    nWin=1,
    A=5.0)
    "-180.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-180.0,
        origin={137.5,-12.5})));
  IDEAS.Buildings.Components.Window window__bathroom(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=3.25)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={170.0,55.0})));
  IDEAS.Buildings.Components.Window window__bed_garden2(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    use_trickle_vent=true,
    dp_nominal=10,
    m_flow_nominal=0.041666666666666664,
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=3.25)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={225.0,55.0})));
  IDEAS.Buildings.Components.Window window__bed_garden1(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    use_trickle_vent=true,
    dp_nominal=10,
    m_flow_nominal=0.041666666666666664,
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=3.25)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={197.5,55.0})));
  IDEAS.Buildings.Components.Window window__bed_strt2(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.Box stateShading2(haveBoundaryPorts=false, hWin=1, wWin=1, wLeft=10, wRight=10, ovDep=0.2, ovGap=0, hFin=10, finDep=0.2, finGap=0)),
    use_trickle_vent=true,
    dp_nominal=10,
    m_flow_nominal=0.016666666666666666,
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=0.6827258618602858,
    nWin=1,
    A=1)
    "0.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=0.0,
        origin={247.5,-30.0})));
  IDEAS.Buildings.Components.Window window__hall__2(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.None stateShading2(haveBoundaryPorts=false)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=2.2535221886551824,
    nWin=1,
    A=2.5)
    "-90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=-90.0,
        origin={197.5,-40.0})));
  IDEAS.Buildings.Components.Window window__living_slide(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.Overhang stateShading2(haveBoundaryPorts=false, hWin=2.5, wWin=4, wLeft=10, wRight=10, dep=1.7, gap=0)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=10.0)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={22.5,55.0})));
  IDEAS.Buildings.Components.Window window__kitchen_slide(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading shaType(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(shaCorr=0.04),
      redeclare IDEAS.Buildings.Components.Shading.Overhang stateShading2(haveBoundaryPorts=false, hWin=2.5, wWin=4, wLeft=10, wRight=10, dep=1.7, gap=0)),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Wall,
    azi=5.3951148422449755,
    nWin=1,
    A=10.0)
    "90.0"
      annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90.0,
        origin={-20.0,55.0})));
  IDEAS.Buildings.Components.Window skylight_zone__polyvalent__skylight_type_1(
    redeclare package Medium=MediumAir,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType(U_value=1.5),
    redeclare IDEAS.Buildings.Components.Shading.Screen shaType(shaCorr=0.1),
    frac=0.15,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=downAngle,
    nWin=1,
    A=3.6) "Skylight model";
  ExtractionFan extractionFan__extraction_fan_1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    dp_nominal=100,
    dp_fan=200,
    etaHydPar=0.35,
    inputType=IDEAS.Fluid.Types.InputType.Continuous) annotation(Placement(transformation(extent={{297.5,-40.0},{317.5,-20.0}})));
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__kitchen__vavr_type_1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.025,
    dpDamper_nominal=15,
    dpFixed_nominal=26,
    fraMin=0.09999999999999999);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__storage__vavr_type_2(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.0166667,
    dpDamper_nominal=15,
    dpFixed_nominal=13,
    fraMin=0.0995998008003984);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__toilet__vavr_type_3(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.00833333,
    dpDamper_nominal=15,
    dpFixed_nominal=83,
    fraMin=0.09999603999841601);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__bathroom__vavr_type_2(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.0166667,
    dpDamper_nominal=15,
    dpFixed_nominal=101,
    fraMin=0.0995998008003984);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__bed_garden__vavr_type_4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.01,
    dpDamper_nominal=15,
    dpFixed_nominal=42,
    fraMin=0.1);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__bed_street__vavr_type_4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.01,
    dpDamper_nominal=15,
    dpFixed_nominal=42,
    fraMin=0.1);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__polyvalent__vavr_type_4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.01,
    dpDamper_nominal=15,
    dpFixed_nominal=55,
    fraMin=0.1);
  IDEAS.Fluid.Actuators.Dampers.Vav returnVav_zone__toilet2__vavr_type_3(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.00833333,
    dpDamper_nominal=15,
    dpFixed_nominal=85,
    fraMin=0.09999603999841601);

equation
  connect(window_living_controlsignal,window__living.Ctrl);
  connect(window_hall_controlsignal,window__hall.Ctrl);
  connect(window_diner_controlsignal,window__diner.Ctrl);
  connect(window_bed_strt1_controlsignal,window__bed_strt1.Ctrl);
  connect(window_box_2_controlsignal,window__box_2.Ctrl);
  connect(window_box_mid_controlsignal,window__box_mid.Ctrl);
  connect(window_bathroom_controlsignal,window__bathroom.Ctrl);
  connect(window_bed_garden2_controlsignal,window__bed_garden2.Ctrl);
  connect(window_bed_garden1_controlsignal,window__bed_garden1.Ctrl);
  connect(window_bed_strt2_controlsignal,window__bed_strt2.Ctrl);
  connect(window_hall_2_controlsignal,window__hall__2.Ctrl);
  connect(window_living_slide_controlsignal,window__living_slide.Ctrl);
  connect(window_kitchen_slide_controlsignal,window__kitchen_slide.Ctrl);
  connect(skylight_zone_polyvalent_skylight_type_1_controlsignal,skylight_zone__polyvalent__skylight_type_1.Ctrl);
  connect(skylight_zone__polyvalent__skylight_type_1.propsBus_a,zone__polyvalent.propsBus[1]);
  connect(extractionfan_extraction_fan_1_controlsignal,extractionFan__extraction_fan_1.dp_in);
  connect(returnVav_zone__kitchen__vavr_type_1.port_a,zone__kitchen.ports[1]);
  connect(returnVav_zone__kitchen__vavr_type_1.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_kitchen_vavr_type_1_controlsignal,returnVav_zone__kitchen__vavr_type_1.y);
  connect(returnVav_zone__storage__vavr_type_2.port_a,zone__storage.ports[1]);
  connect(returnVav_zone__storage__vavr_type_2.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_storage_vavr_type_2_controlsignal,returnVav_zone__storage__vavr_type_2.y);
  connect(returnVav_zone__toilet__vavr_type_3.port_a,zone__toilet.ports[1]);
  connect(returnVav_zone__toilet__vavr_type_3.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_toilet_vavr_type_3_controlsignal,returnVav_zone__toilet__vavr_type_3.y);
  connect(returnVav_zone__bathroom__vavr_type_2.port_a,zone__bathroom.ports[1]);
  connect(returnVav_zone__bathroom__vavr_type_2.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_bathroom_vavr_type_2_controlsignal,returnVav_zone__bathroom__vavr_type_2.y);
  connect(returnVav_zone__bed_garden__vavr_type_4.port_a,zone__bed_garden.ports[1]);
  connect(returnVav_zone__bed_garden__vavr_type_4.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_bed_garden_vavr_type_4_controlsignal,returnVav_zone__bed_garden__vavr_type_4.y);
  connect(returnVav_zone__bed_street__vavr_type_4.port_a,zone__bed_street.ports[1]);
  connect(returnVav_zone__bed_street__vavr_type_4.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_bed_street_vavr_type_4_controlsignal,returnVav_zone__bed_street__vavr_type_4.y);
  connect(returnVav_zone__polyvalent__vavr_type_4.port_a,zone__polyvalent.ports[1]);
  connect(returnVav_zone__polyvalent__vavr_type_4.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_polyvalent_vavr_type_4_controlsignal,returnVav_zone__polyvalent__vavr_type_4.y);
  connect(returnVav_zone__toilet2__vavr_type_3.port_a,zone__toilet2.ports[1]);
  connect(returnVav_zone__toilet2__vavr_type_3.port_b,extractionFan__extraction_fan_1.port_a);
  connect(returnvav_zone_toilet2_vavr_type_3_controlsignal,returnVav_zone__toilet2__vavr_type_3.y);
  connect(slabonground__1.propsBus_a,zone__kitchen.propsBus[1]);
  connect(slabonground__2.propsBus_a,zone__entrance.propsBus[1]);
  connect(slabonground__3.propsBus_a,zone__hallway.propsBus[1]);
  connect(slabonground__4.propsBus_a,zone__storage.propsBus[1]);
  connect(slabonground__5.propsBus_a,zone__toilet.propsBus[1]);
  connect(ceiling__1.propsBus_a,zone__polyvalent.propsBus[2]);
  connect(ceiling__2.propsBus_a,zone__bed_street.propsBus[1]);
  connect(ceiling__3.propsBus_a,zone__bed_garden.propsBus[1]);
  connect(ceiling__4.propsBus_a,zone__bathroom.propsBus[1]);
  connect(ceiling__5.propsBus_a,zone__toilet2.propsBus[1]);
  connect(floor__1.propsBus_a,zone__polyvalent.propsBus[3]);
  connect(floor__1.propsBus_b,zone__kitchen.propsBus[2]);
  connect(floor__2.propsBus_a,zone__polyvalent.propsBus[4]);
  connect(floor__2.propsBus_b,zone__entrance.propsBus[2]);
  connect(floor__3.propsBus_a,zone__polyvalent.propsBus[5]);
  connect(floor__3.propsBus_b,zone__hallway.propsBus[2]);
  connect(floor__4.propsBus_a,zone__polyvalent.propsBus[6]);
  connect(floor__4.propsBus_b,zone__storage.propsBus[2]);
  connect(floor__5.propsBus_a,zone__polyvalent.propsBus[7]);
  connect(floor__5.propsBus_b,zone__toilet.propsBus[2]);
  connect(floor__6.propsBus_a,zone__bed_street.propsBus[2]);
  connect(floor__6.propsBus_b,zone__kitchen.propsBus[3]);
  connect(floor__7.propsBus_a,zone__bed_garden.propsBus[2]);
  connect(floor__7.propsBus_b,zone__kitchen.propsBus[4]);
  connect(floor__8.propsBus_a,zone__bathroom.propsBus[2]);
  connect(floor__8.propsBus_b,zone__kitchen.propsBus[5]);
  connect(floor__9.propsBus_a,zone__toilet2.propsBus[2]);
  connect(floor__9.propsBus_b,zone__kitchen.propsBus[6]);
  connect(floor__10.propsBus_a,zone__polyvalent.propsBus[8]);
  connect(floor__11.propsBus_a,zone__bed_street.propsBus[3]);
  connect(outerwall__1.propsBus_a,zone__kitchen.propsBus[7]);
  connect(outerwall__2.propsBus_a,zone__kitchen.propsBus[8]);
  connect(outerwall__3.propsBus_a,zone__kitchen.propsBus[9]);
  connect(internalwall__1.propsBus_a,zone__kitchen.propsBus[10]);
  connect(internalwall__1.propsBus_b,zone__entrance.propsBus[3]);
  connect(outerwall__4.propsBus_a,zone__storage.propsBus[3]);
  connect(internalwall__2.propsBus_a,zone__kitchen.propsBus[11]);
  connect(internalwall__2.propsBus_b,zone__entrance.propsBus[4]);
  connect(outerwall__5.propsBus_a,zone__kitchen.propsBus[12]);
  connect(outerwall__6.propsBus_a,zone__kitchen.propsBus[13]);
  connect(outerwall__7.propsBus_a,zone__kitchen.propsBus[14]);
  connect(outerwall__8.propsBus_a,zone__storage.propsBus[4]);
  connect(internalwall__3.propsBus_a,zone__entrance.propsBus[5]);
  connect(internalwall__3.propsBus_b,zone__storage.propsBus[5]);
  connect(internalwall__4.propsBus_a,zone__entrance.propsBus[6]);
  connect(internalwall__4.propsBus_b,zone__toilet.propsBus[3]);
  connect(internalwall__5.propsBus_a,zone__hallway.propsBus[3]);
  connect(internalwall__5.propsBus_b,zone__toilet.propsBus[4]);
  connect(internalwall__6.propsBus_a,zone__entrance.propsBus[7]);
  connect(internalwall__6.propsBus_b,zone__hallway.propsBus[4]);
  connect(internalwall__7.propsBus_a,zone__kitchen.propsBus[15]);
  connect(internalwall__7.propsBus_b,zone__hallway.propsBus[5]);
  connect(internalwall__8.propsBus_a,zone__entrance.propsBus[8]);
  connect(internalwall__8.propsBus_b,zone__toilet.propsBus[5]);
  connect(internalwall__9.propsBus_a,zone__entrance.propsBus[9]);
  connect(internalwall__9.propsBus_b,zone__toilet.propsBus[6]);
  connect(internalwall__10.propsBus_a,zone__hallway.propsBus[6]);
  connect(internalwall__10.propsBus_b,zone__toilet.propsBus[7]);
  connect(internalwall__11.propsBus_a,zone__storage.propsBus[6]);
  connect(internalwall__11.propsBus_b,zone__toilet.propsBus[8]);
  connect(internalwall__12.propsBus_a,zone__kitchen.propsBus[16]);
  connect(internalwall__12.propsBus_b,zone__storage.propsBus[7]);
  connect(internalwall__13.propsBus_a,zone__hallway.propsBus[7]);
  connect(internalwall__13.propsBus_b,zone__storage.propsBus[8]);
  connect(internalwall__14.propsBus_a,zone__kitchen.propsBus[17]);
  connect(internalwall__14.propsBus_b,zone__hallway.propsBus[8]);
  connect(outerwall__9.propsBus_a,zone__kitchen.propsBus[18]);
  connect(outerwall__10.propsBus_a,zone__entrance.propsBus[10]);
  connect(internalwall__15.propsBus_a,zone__kitchen.propsBus[19]);
  connect(internalwall__15.propsBus_b,zone__entrance.propsBus[11]);
  connect(outerwall__15.propsBus_a,zone__bed_street.propsBus[4]);
  connect(outerwall__16.propsBus_a,zone__bed_street.propsBus[5]);
  connect(internalwall__18.propsBus_a,zone__polyvalent.propsBus[9]);
  connect(internalwall__18.propsBus_b,zone__bed_street.propsBus[6]);
  connect(outerwall__17.propsBus_a,zone__bed_garden.propsBus[3]);
  connect(outerwall__18.propsBus_a,zone__bed_garden.propsBus[4]);
  connect(outerwall__19.propsBus_a,zone__bed_garden.propsBus[5]);
  connect(internalwall__19.propsBus_a,zone__polyvalent.propsBus[10]);
  connect(internalwall__19.propsBus_b,zone__bed_street.propsBus[7]);
  connect(internalwall__20.propsBus_a,zone__polyvalent.propsBus[11]);
  connect(internalwall__20.propsBus_b,zone__bed_garden.propsBus[6]);
  connect(internalwall__21.propsBus_a,zone__polyvalent.propsBus[12]);
  connect(internalwall__21.propsBus_b,zone__bed_garden.propsBus[7]);
  connect(internalwall__22.propsBus_a,zone__bed_street.propsBus[8]);
  connect(internalwall__22.propsBus_b,zone__bed_garden.propsBus[8]);
  connect(outerwall__20.propsBus_a,zone__bathroom.propsBus[3]);
  connect(outerwall__21.propsBus_a,zone__toilet2.propsBus[3]);
  connect(outerwall__22.propsBus_a,zone__bathroom.propsBus[4]);
  connect(outerwall__23.propsBus_a,zone__bed_garden.propsBus[9]);
  connect(internalwall__23.propsBus_a,zone__polyvalent.propsBus[13]);
  connect(internalwall__23.propsBus_b,zone__bed_garden.propsBus[10]);
  connect(internalwall__24.propsBus_a,zone__polyvalent.propsBus[14]);
  connect(internalwall__24.propsBus_b,zone__toilet2.propsBus[4]);
  connect(internalwall__25.propsBus_a,zone__bathroom.propsBus[5]);
  connect(internalwall__25.propsBus_b,zone__toilet2.propsBus[5]);
  connect(internalwall__26.propsBus_a,zone__polyvalent.propsBus[15]);
  connect(internalwall__26.propsBus_b,zone__toilet2.propsBus[6]);
  connect(outerwall__24.propsBus_a,zone__polyvalent.propsBus[16]);
  connect(outerwall__25.propsBus_a,zone__polyvalent.propsBus[17]);
  connect(outerwall__26.propsBus_a,zone__polyvalent.propsBus[18]);
  connect(outerwall__27.propsBus_a,zone__polyvalent.propsBus[19]);
  connect(internalwall__27.propsBus_a,zone__bed_garden.propsBus[11]);
  connect(internalwall__27.propsBus_b,zone__bathroom.propsBus[6]);
  connect(outerwall__28.propsBus_a,zone__bathroom.propsBus[7]);
  connect(internalwall__28.propsBus_a,zone__polyvalent.propsBus[20]);
  connect(internalwall__28.propsBus_b,zone__bathroom.propsBus[8]);
  connect(outerwall__29.propsBus_a,zone__polyvalent.propsBus[21]);
  connect(internalwall__29.propsBus_a,zone__polyvalent.propsBus[22]);
  connect(internalwall__29.propsBus_b,zone__bed_street.propsBus[9]);
  connect(window__living.propsBus_a,zone__kitchen.propsBus[20]);
  connect(window__hall.propsBus_a,zone__entrance.propsBus[12]);
  connect(window__diner.propsBus_a,zone__kitchen.propsBus[21]);
  connect(window__bed_strt1.propsBus_a,zone__bed_street.propsBus[10]);
  connect(window__box_2.propsBus_a,zone__polyvalent.propsBus[23]);
  connect(window__box_mid.propsBus_a,zone__polyvalent.propsBus[24]);
  connect(window__bathroom.propsBus_a,zone__bathroom.propsBus[9]);
  connect(window__bed_garden2.propsBus_a,zone__bed_garden.propsBus[12]);
  connect(window__bed_garden1.propsBus_a,zone__bed_garden.propsBus[13]);
  connect(window__bed_strt2.propsBus_a,zone__bed_street.propsBus[11]);
  connect(window__hall__2.propsBus_a,zone__polyvalent.propsBus[25]);
  connect(window__living_slide.propsBus_a,zone__kitchen.propsBus[22]);
  connect(window__kitchen_slide.propsBus_a,zone__kitchen.propsBus[23]);


  annotation (Diagram(coordinateSystem(extent={{-52.5,-40.0},{317.5,55.0}},initialScale=0.1),
    graphics={
      Line(points={{-52.5,55.0},{47.5,55.0}},  color={28,108,200}),
      Line(points={{47.5,55.0},{47.5,10.0}},  color={28,108,200}),
      Line(points={{-52.5,10.0},{-52.5,55.0}},  color={28,108,200}),
      Line(points={{47.5,10.0},{45.0,10.0}},  color={28,108,200}),
      Line(points={{10.0,-37.5},{10.0,-40.0}},  color={28,108,200}),
      Line(points={{-5.0,10.0},{-7.5,10.0}},  color={28,108,200}),
      Line(points={{2.5,10.0},{-5.0,10.0}},  color={28,108,200}),
      Line(points={{-52.5,-40.0},{-52.5,10.0}},  color={28,108,200}),
      Line(points={{-22.5,-40.0},{-25.0,-40.0}},  color={28,108,200}),
      Line(points={{2.5,10.0},{2.5,-22.5}},  color={28,108,200}),
      Line(points={{45.0,-22.5},{45.0,10.0}},  color={28,108,200}),
      Line(points={{10.0,-37.5},{45.0,-37.5}},  color={28,108,200}),
      Line(points={{45.0,-37.5},{45.0,-22.5}},  color={28,108,200}),
      Line(points={{-52.5,-40.0},{-27.5,-40.0}},  color={28,108,200}),
      Line(points={{-27.5,-40.0},{-27.5,-22.5}},  color={28,108,200}),
      Line(points={{-27.5,-22.5},{-22.5,-22.5}},  color={28,108,200}),
      Line(points={{-25.0,-40.0},{-27.5,-40.0}},  color={28,108,200}),
      Line(points={{-22.5,-7.5},{-10.0,-7.5}},  color={28,108,200}),
      Line(points={{-10.0,-7.5},{-10.0,10.0}},  color={28,108,200}),
      Line(points={{-10.0,10.0},{-22.5,10.0}},  color={28,108,200}),
      Line(points={{-22.5,-22.5},{-10.0,-22.5}},  color={28,108,200}),
      Line(points={{-10.0,-22.5},{-10.0,-7.5}},  color={28,108,200}),
      Line(points={{-7.5,10.0},{-10.0,10.0}},  color={28,108,200}),
      Line(points={{-27.5,-7.5},{-22.5,-7.5}},  color={28,108,200}),
      Line(points={{-27.5,-7.5},{-27.5,-22.5}},  color={28,108,200}),
      Line(points={{-27.5,10.0},{-52.5,10.0}},  color={28,108,200}),
      Line(points={{-27.5,10.0},{-27.5,-7.5}},  color={28,108,200}),
      Line(points={{-22.5,10.0},{-27.5,10.0}},  color={28,108,200}),
      Line(points={{2.5,-40.0},{10.0,-40.0}},  color={28,108,200}),
      Line(points={{-22.5,-40.0},{2.5,-40.0}},  color={28,108,200}),
      Line(points={{2.5,-40.0},{2.5,-22.5}},  color={28,108,200}),
      Line(points={{247.5,10.0},{247.5,-40.0}},  color={28,108,200}),
      Line(points={{247.5,-40.0},{202.5,-40.0}},  color={28,108,200}),
      Line(points={{202.5,10.0},{202.5,-22.5}},  color={28,108,200}),
      Line(points={{192.5,-40.0},{202.5,-40.0}},  color={28,108,200}),
      Line(points={{247.5,10.0},{247.5,20.0}},  color={28,108,200}),
      Line(points={{247.5,20.0},{247.5,55.0}},  color={28,108,200}),
      Line(points={{247.5,55.0},{217.5,55.0}},  color={28,108,200}),
      Line(points={{202.5,10.0},{225.0,10.0}},  color={28,108,200}),
      Line(points={{225.0,10.0},{225.0,20.0}},  color={28,108,200}),
      Line(points={{225.0,20.0},{217.5,20.0}},  color={28,108,200}),
      Line(points={{225.0,10.0},{247.5,10.0}},  color={28,108,200}),
      Line(points={{165.0,55.0},{147.5,55.0}},  color={28,108,200}),
      Line(points={{147.5,20.0},{147.5,10.0}},  color={28,108,200}),
      Line(points={{147.5,20.0},{147.5,55.0}},  color={28,108,200}),
      Line(points={{217.5,55.0},{187.5,55.0}},  color={28,108,200}),
      Line(points={{217.5,20.0},{187.5,20.0}},  color={28,108,200}),
      Line(points={{162.5,20.0},{162.5,10.0}},  color={28,108,200}),
      Line(points={{147.5,20.0},{162.5,20.0}},  color={28,108,200}),
      Line(points={{162.5,10.0},{147.5,10.0}},  color={28,108,200}),
      Line(points={{165.0,20.0},{162.5,20.0}},  color={28,108,200}),
      Line(points={{137.5,-22.5},{147.5,-22.5}},  color={28,108,200}),
      Line(points={{147.5,-22.5},{147.5,-40.0}},  color={28,108,200}),
      Line(points={{147.5,10.0},{147.5,0.0}},  color={28,108,200}),
      Line(points={{147.5,0.0},{137.5,0.0}},  color={28,108,200}),
      Line(points={{137.5,0.0},{137.5,-22.5}},  color={28,108,200}),
      Line(points={{185.0,20.0},{185.0,55.0}},  color={28,108,200}),
      Line(points={{187.5,55.0},{185.0,55.0}},  color={28,108,200}),
      Line(points={{185.0,55.0},{165.0,55.0}},  color={28,108,200}),
      Line(points={{187.5,20.0},{185.0,20.0}},  color={28,108,200}),
      Line(points={{185.0,20.0},{165.0,20.0}},  color={28,108,200}),
      Line(points={{147.5,-40.0},{190.0,-40.0}},  color={28,108,200}),
      Line(points={{192.5,-40.0},{190.0,-40.0}},  color={28,108,200}),
      Line(points={{202.5,-40.0},{202.5,-22.5}},  color={28,108,200})}),
    uses(Modelica(version="4.0.0"),
         IDEAS(version="3.0.0")),
    experiment(
      StopTime=86400,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>
Example model of a detailed residential building structure consisting of 10 thermal zones.
This model only contains the building structure. The user can implement its own control algorithm using the real inputs of the model.
</p>
</html>", revisions="<html>
<ul>
<li>
January 5, 2023 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end DetailedResidentialNoHeating;

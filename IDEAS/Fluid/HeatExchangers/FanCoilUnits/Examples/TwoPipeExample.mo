within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Examples;
model TwoPipeExample
  extends Modelica.Icons.Example
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

  IDEAS.Buildings.Components.RectangularZoneTemplate       rectangularZoneTemplate(
    h=2.7,
    redeclare Buildings.Components.ZoneAirModels.WellMixedAir airModel(
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState),
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    hasWinCei=false,
    redeclare Buildings.Validation.Data.Constructions.LightRoof conTypCei,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare Buildings.Validation.Data.Constructions.HeavyFloor conTypFlo,
    redeclare Buildings.Validation.Data.Constructions.HeavyWall conTypA,
    redeclare Buildings.Validation.Data.Constructions.HeavyWall conTypB,
    redeclare Buildings.Validation.Data.Constructions.HeavyWall conTypC,
    redeclare Buildings.Validation.Data.Constructions.HeavyWall conTypD,
    hasWinA=true,
    fracA=0,
    redeclare Buildings.Components.Shading.Interfaces.ShadingProperties
      shaTypA,
    hasWinB=false,
    hasWinC=false,
    hasWinD=false,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    aziA=IDEAS.Types.Azimuth.S,
    mSenFac=0.822,
    l=8,
    w=6,
    A_winA=12,
    n50=0.822*0.5*20,
    redeclare Buildings.Validation.Data.Glazing.GlaBesTest glazingA,
    redeclare package Medium = IDEAS.Media.Air,
    T_start=293.15) "Case900 zone"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  TwoPipeHea twoPipeHea(
    mAir_flow_nominal=0.12,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    deltaTHea_nominal=10,
    Q_flow_nominal=3000,
    dpWat_nominal(displayUnit="Pa") = 10000,
    use_Q_flow_nominal=true,
    eps_nominal=1,
    T_a1_nominal=293.15,
    T_a2_nominal=353.15) "Fan coil unit model"
    annotation (Placement(transformation(extent={{34,-20},{54,0}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        IDEAS.Media.Air) "Air boundary"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Heater_T hea(
    m_flow_nominal=twoPipeHea.mWat_flow_nominal,
    dp_nominal=0,
    redeclare package Medium = IDEAS.Media.Water,
    QMax_flow=5000) "Heater component"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = IDEAS.Media.Water,
    p=200000) "Water boundary"
    annotation (Placement(transformation(extent={{-90,-36},{-70,-16}})));
  Movers.FlowControlled_m_flow pump(
    redeclare package Medium = IDEAS.Media.Water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    m_flow_nominal=twoPipeHea.mWat_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Stages) "Water mover component"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 21, uHigh=273.15
         + 24) "Hysteresis controller for the zone"
               annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Logical.Not not1
    "Reverse action for the hysteresis (heating)"
    annotation (Placement(transformation(extent={{28,30},{48,50}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger
    "Transforms signal of the hysteresis into integer"
    annotation (Placement(transformation(extent={{58,30},{78,50}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 80)
    "Set point of the heater"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
equation
  connect(rectangularZoneTemplate.gainCon, twoPipeHea.port_heat) annotation (
      Line(points={{-20,-3},{8,-3},{8,-18},{34,-18}}, color={191,0,0}));
  connect(bou.ports[1], rectangularZoneTemplate.port_a) annotation (Line(
        points={{-40,40},{-28,40},{-28,10}}, color={0,127,255}));
  connect(rectangularZoneTemplate.TSensor, twoPipeHea.TAir) annotation (Line(
        points={{-19,2},{6,2},{6,4},{40.8,4},{40.8,-2}}, color={0,0,127}));
  connect(twoPipeHea.port_b, hea.port_a) annotation (Line(points={{42,-20},{42,
          -24},{-60,-24},{-60,-40},{-40,-40}}, color={0,127,255}));
  connect(bou1.ports[1], hea.port_a) annotation (Line(points={{-70,-26},{-68,
          -26},{-68,-40},{-40,-40}},
                                color={0,127,255}));
  connect(hea.port_b, pump.port_a)
    annotation (Line(points={{-20,-40},{0,-40}}, color={0,127,255}));
  connect(pump.port_b, twoPipeHea.port_a) annotation (Line(points={{20,-40},{46,
          -40},{46,-20}}, color={0,127,255}));
  connect(rectangularZoneTemplate.TSensor, hysteresis.u) annotation (Line(
        points={{-19,2},{-10,2},{-10,40},{-2,40}}, color={0,0,127}));
  connect(not1.u, hysteresis.y)
    annotation (Line(points={{26,40},{21,40}}, color={255,0,255}));
  connect(not1.y, booleanToInteger.u)
    annotation (Line(points={{49,40},{56,40}}, color={255,0,255}));
  connect(booleanToInteger.y, twoPipeHea.stage) annotation (Line(points={{79,40},
          {82,40},{82,4},{50,4},{50,2}}, color={255,127,0}));
  connect(booleanToInteger.y, pump.stage) annotation (Line(points={{79,40},{82,
          40},{82,-28},{10,-28}}, color={255,127,0}));
  connect(TSet.y, hea.TSet) annotation (Line(points={{-69,10},{-54,10},{-54,-32},
          {-42,-32}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Examples/FCUExample.mos"),
    experiment(
      StopTime=50000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end TwoPipeExample;

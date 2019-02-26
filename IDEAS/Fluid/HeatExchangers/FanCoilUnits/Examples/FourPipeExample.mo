within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Examples;
model FourPipeExample
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

  FourPipe   fourPipe(
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    dpWatHea_nominal(displayUnit="Pa") = 10000,
    QHea_flow_nominal=3000,
    epsHea_nominal=1,
    epsCoo_nominal=1,
    dpWatCoo_nominal(displayUnit="Pa") = 10000,
    deltaTCoo_nominal=2,
    QCoo_flow_nominal=3000,
    mAir_flow_nominal=0.15,
    THea_a1_nominal=293.15,
    THea_a2_nominal=353.15,
    TCoo_a1_nominal=300.15,
    TCoo_a2_nominal=280.15)
                         "Fan coil unit model"
    annotation (Placement(transformation(extent={{34,-20},{54,0}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        IDEAS.Media.Air) "Air boundary"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Heater_T hea(
    dp_nominal=0,
    redeclare package Medium = IDEAS.Media.Water,
    QMax_flow=5000,
    m_flow_nominal=fourPipe.mWatHea_flow_nominal) "Heater component"
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
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    m_flow_nominal=fourPipe.mWatHea_flow_nominal) "Water mover component"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 21, uHigh=273.15
         + 24) "Hysteresis controller for the zone"
               annotation (Placement(transformation(extent={{-4,30},{16,50}})));
  Modelica.Blocks.Logical.Not not1
    "Reverse action for the hysteresis (heating)"
    annotation (Placement(transformation(extent={{24,30},{44,50}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger
    "Transforms signal of the hysteresis into integer"
    annotation (Placement(transformation(extent={{54,30},{74,50}})));
  Modelica.Blocks.Sources.Constant TSetHea(k=273.15 + 80)
    "Set point of the heater"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 25, uHigh=273.15
         + 27) "Hysteresis controller for the zone"
               annotation (Placement(transformation(extent={{0,78},{20,98}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger1
    "Transforms signal of the hysteresis into integer"
    annotation (Placement(transformation(extent={{48,78},{68,98}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{76,62},{96,82}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger2
    "Transforms signal of the hysteresis into integer"
    annotation (Placement(transformation(extent={{84,4},{64,24}})));
  SensibleCooler_T coo(
    dp_nominal=0,
    redeclare package Medium = Media.Water,
    m_flow_nominal=fourPipe.mWatCoo_flow_nominal,
    QMin_flow=-5000) "Heater component"
    annotation (Placement(transformation(extent={{-40,-86},{-20,-66}})));
  Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = Media.Water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    m_flow_nominal=fourPipe.mWatCoo_flow_nominal) "Water mover component"
    annotation (Placement(transformation(extent={{0,-86},{20,-66}})));
  Modelica.Blocks.Sources.Constant TSetCoo(k=273.15 + 7)
    "Set point of the cooler"
    annotation (Placement(transformation(extent={{-100,-66},{-80,-46}})));
  Sources.Boundary_pT             bou2(
    nPorts=1,
    redeclare package Medium = Media.Water,
    p=200000) "Water boundary"
    annotation (Placement(transformation(extent={{-94,-100},{-74,-80}})));
equation
  connect(rectangularZoneTemplate.gainCon, fourPipe.port_heat) annotation (Line(
        points={{-20,-3},{8,-3},{8,-18},{34,-18}}, color={191,0,0}));
  connect(bou.ports[1], rectangularZoneTemplate.port_a) annotation (Line(
        points={{-40,40},{-28,40},{-28,10}}, color={0,127,255}));
  connect(rectangularZoneTemplate.TSensor, fourPipe.TAir) annotation (Line(
        points={{-19,2},{6,2},{6,4},{40.8,4},{40.8,-2}}, color={0,0,127}));
  connect(bou1.ports[1], hea.port_a) annotation (Line(points={{-70,-26},{-68,
          -26},{-68,-40},{-40,-40}},
                                color={0,127,255}));
  connect(hea.port_b, pump.port_a)
    annotation (Line(points={{-20,-40},{0,-40}}, color={0,127,255}));
  connect(rectangularZoneTemplate.TSensor, hysteresis.u) annotation (Line(
        points={{-19,2},{-10,2},{-10,40},{-6,40}}, color={0,0,127}));
  connect(not1.u, hysteresis.y)
    annotation (Line(points={{22,40},{17,40}}, color={255,0,255}));
  connect(not1.y, booleanToInteger.u)
    annotation (Line(points={{45,40},{52,40}}, color={255,0,255}));
  connect(booleanToInteger.y, pump.stage) annotation (Line(points={{75,40},{94,
          40},{94,-28},{10,-28}}, color={255,127,0}));
  connect(TSetHea.y, hea.TSet) annotation (Line(points={{-69,10},{-54,10},{-54,
          -32},{-42,-32}}, color={0,0,127}));
  connect(pump.port_b, fourPipe.port_a2)
    annotation (Line(points={{20,-40},{52,-40},{52,-20}}, color={0,127,255}));
  connect(hea.port_a, fourPipe.port_b2) annotation (Line(points={{-40,-40},{-48,
          -40},{-48,-30},{48,-30},{48,-20}}, color={0,127,255}));
  connect(hysteresis1.y, booleanToInteger1.u)
    annotation (Line(points={{21,88},{46,88}}, color={255,0,255}));
  connect(rectangularZoneTemplate.TSensor, hysteresis1.u) annotation (Line(
        points={{-19,2},{-10,2},{-10,88},{-2,88}}, color={0,0,127}));
  connect(rectangularZoneTemplate.phi, fourPipe.phi)
    annotation (Line(points={{-19,2},{36.2,2},{36.2,-2}}, color={0,0,127}));
  connect(hysteresis1.y, or1.u1) annotation (Line(points={{21,88},{36,88},{36,
          72},{74,72}}, color={255,0,255}));
  connect(not1.y, or1.u2) annotation (Line(points={{45,40},{48,40},{48,64},{74,
          64}}, color={255,0,255}));
  connect(booleanToInteger2.y, fourPipe.stage)
    annotation (Line(points={{63,14},{50,14},{50,2}}, color={255,127,0}));
  connect(or1.y, booleanToInteger2.u) annotation (Line(points={{97,72},{100,72},
          {100,14},{86,14}}, color={255,0,255}));
  connect(coo.port_b, pump1.port_a)
    annotation (Line(points={{-20,-76},{0,-76}}, color={0,127,255}));
  connect(pump1.port_b, fourPipe.port_a1)
    annotation (Line(points={{20,-76},{46,-76},{46,-20}}, color={0,127,255}));
  connect(TSetCoo.y, coo.TSet) annotation (Line(points={{-79,-56},{-76,-56},{
          -76,-68},{-42,-68}}, color={0,0,127}));
  connect(booleanToInteger1.y, pump1.stage) annotation (Line(points={{69,88},{
          100,88},{100,-64},{10,-64}}, color={255,127,0}));
  connect(fourPipe.port_b1, coo.port_a) annotation (Line(points={{42,-20},{40,
          -20},{40,-58},{-66,-58},{-66,-76},{-40,-76}}, color={0,127,255}));
  connect(bou2.ports[1], coo.port_a) annotation (Line(points={{-74,-90},{-70,
          -90},{-70,-76},{-40,-76}}, color={0,127,255}));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Examples/FCUExample.mos"),
    experiment(
      StartTime=2500000,
      StopTime=3000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false,
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end FourPipeExample;

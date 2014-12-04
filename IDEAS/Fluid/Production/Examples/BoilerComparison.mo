within IDEAS.Fluid.Production.Examples;
model BoilerComparison

  //Extensions
  extends Modelica.Icons.Example;

  IDEAS.Fluid.Production.PolynomialProduction polynomialProduction(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dp_nominal=0,
    redeclare IDEAS.Fluid.Production.Data.Polynomials.Boiler2ndDegree
      data,
    modulationMin=20,
    modulationStart=30,
    QNom=5000,
    avoidEvents=avoidEvents.k)
    annotation (Placement(transformation(extent={{-44,56},{-24,78}})));

  IDEAS.Fluid.Production.PerformanceMapProduction performanceMapProduction(
    dp_nominal=0,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    redeclare IDEAS.Fluid.Production.Data.PerformanceMaps.Boiler data,
    modulationMin=20,
    modulationStart=30,
    QNom=5000,
    avoidEvents=avoidEvents.k)
    annotation (Placement(transformation(extent={{-44,-4},{-24,18}})));

  Fluid.Production.Boiler boiler(
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    modulationMin=20,
    modulationStart=30,
    QNom=5000)
    annotation (Placement(transformation(extent={{-48,-50},{-28,-72}})));

  Modelica.Blocks.Sources.Constant TSet(k=273 + 80)
    annotation (Placement(transformation(extent={{-92,10},{-72,30}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-86,78},{-66,98}})));
  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-24,28},{-4,48}})));
  Fluid.Movers.Pump pump1(
                         redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-24,-26},{-4,-6}})));
  Fluid.Movers.Pump pump2(
                         redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-20,-92},{0,-72}})));
  Fluid.FixedResistances.Pipe_Insulated pipe(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={58,52})));

  Fluid.FixedResistances.Pipe_Insulated pipe1(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={58,-6})));

  Fluid.FixedResistances.Pipe_Insulated pipe2(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={44,-66})));

  Fluid.Sources.FixedBoundary bou(
    nPorts=3,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={82,38})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{8,78},{28,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{-22,78},{-2,98}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{78,-76},{58,-56}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{110,-76},{90,-56}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature2
    annotation (Placement(transformation(extent={{92,-16},{72,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(
                                                        y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{124,-16},{104,4}})));
  Fluid.Sensors.TemperatureTwoPort senPoly(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{8,28},{28,48}})));
  Fluid.Sensors.TemperatureTwoPort senInterpolation(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{10,-26},{30,-6}})));
  Fluid.Sensors.TemperatureTwoPort senBoiler(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{8,-92},{28,-72}})));
  Modelica.Blocks.Sources.BooleanConstant avoidEvents(k=true)
    annotation (Placement(transformation(extent={{-96,50},{-76,70}})));
equation
  connect(TSet.y, performanceMapProduction.TSet) annotation (Line(
      points={{-71,20},{-54,20},{-54,28},{-35,28},{-35,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet.y, polynomialProduction.TSet) annotation (Line(
      points={{-71,20},{-54,20},{-54,86},{-35,86},{-35,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet.y, boiler.TSet) annotation (Line(
      points={{-71,20},{-54,20},{-54,-82},{-40,-82},{-40,-72},{-39,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(polynomialProduction.port_b, pump.port_a) annotation (Line(
      points={{-23.8,62},{-24,62},{-24,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(performanceMapProduction.port_b, pump1.port_a) annotation (Line(
      points={{-23.8,2},{-24,2},{-24,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_b, pump2.port_a) annotation (Line(
      points={{-28,-64},{-28,-82},{-20,-82}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(polynomialProduction.port_a, pipe.port_b) annotation (Line(
      points={{-23.8,70},{58,70},{58,62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(performanceMapProduction.port_a, pipe1.port_b) annotation (Line(
      points={{-23.8,10},{58,10},{58,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_a, pipe2.port_b) annotation (Line(
      points={{-28,-56},{44,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], pipe.port_a) annotation (Line(
      points={{84.6667,28},{84.6667,22},{42,22},{42,38},{58,38},{58,42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[2], pipe1.port_b) annotation (Line(
      points={{82,28},{82,18},{50,18},{50,10},{58,10},{58,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[3], pipe2.port_b) annotation (Line(
      points={{79.3333,28},{79.3333,-32},{40,-32},{40,-56},{44,-56}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(realExpression.y,prescribedTemperature. T) annotation (Line(
      points={{-1,88},{6,88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe.heatPort) annotation (Line(
      points={{28,88},{38,88},{38,52},{54,52}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature1.T, realExpression1.y) annotation (Line(
      points={{80,-66},{89,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature1.port, pipe2.heatPort) annotation (Line(
      points={{58,-66},{52,-66},{52,-88},{30,-88},{30,-66},{40,-66}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature2.T, realExpression2.y) annotation (Line(
      points={{94,-6},{103,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature2.port, pipe1.heatPort) annotation (Line(
      points={{72,-6},{66,-6},{66,-24},{44,-24},{44,-6},{54,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump.port_b, senPoly.port_a) annotation (Line(
      points={{-4,38},{8,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senPoly.port_b, pipe.port_a) annotation (Line(
      points={{28,38},{58,38},{58,42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_b, senInterpolation.port_a) annotation (Line(
      points={{-4,-16},{10,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senInterpolation.port_b, pipe1.port_a) annotation (Line(
      points={{30,-16},{58,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b, senBoiler.port_a) annotation (Line(
      points={{0,-82},{8,-82}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senBoiler.port_b, pipe2.port_a) annotation (Line(
      points={{28,-82},{44,-82},{44,-76}},
      color={0,127,255},
      smooth=Smooth.None));
     annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput);
end BoilerComparison;

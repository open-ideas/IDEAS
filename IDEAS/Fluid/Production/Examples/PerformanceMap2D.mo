within IDEAS.Fluid.Production.Examples;
model PerformanceMap2D
  //Extensions
  extends Modelica.Icons.Example;

  Movers.Pump       pump1(
                         redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-38,-28},{-18,-8}})));
  FixedResistances.Pipe_Insulated       pipe1(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={44,-4})));
  Sources.FixedBoundary       bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={68,40})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature2
    annotation (Placement(transformation(extent={{78,-14},{58,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(
                                                        y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{106,-14},{86,6}})));
  Sensors.TemperatureTwoPort       senInterpolation(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-2,4},{-22,24}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 78, uHigh=273.15 +
        82) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,76})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-66,50})));
  PerformanceMap2DProduction performanceMap2DProduction(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    QNom=5000,
    m_flow_nominal=0.1,
    redeclare IDEAS.Fluid.Production.Data.PerformanceMaps.Boiler2D data)
    annotation (Placement(transformation(extent={{-74,0},{-54,20}})));
equation
  connect(bou.ports[1],pipe1. port_b) annotation (Line(
      points={{68,30},{68,20},{44,20},{44,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(prescribedTemperature2.T,realExpression2. y) annotation (Line(
      points={{80,-4},{85,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature2.port,pipe1. heatPort) annotation (Line(
      points={{58,-4},{52,-4},{52,-22},{30,-22},{30,-4},{40,-4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(senInterpolation.port_a, pipe1.port_b) annotation (Line(
      points={{-2,14},{44,14},{44,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_b, pipe1.port_a) annotation (Line(
      points={{-18,-18},{44,-18},{44,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senInterpolation.T, hysteresis.u) annotation (Line(
      points={{-12,25},{-12,76},{-20,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis.y, not1.u) annotation (Line(
      points={{-43,76},{-66,76},{-66,62}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, performanceMap2DProduction.on) annotation (Line(
      points={{-66,39},{-66,20.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(performanceMap2DProduction.port_a, senInterpolation.port_b)
    annotation (Line(
      points={{-53.8,14},{-22,14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(performanceMap2DProduction.port_b, pump1.port_a) annotation (Line(
      points={{-53.8,6},{-44,6},{-44,-18},{-38,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senInterpolation.T, performanceMap2DProduction.TSet) annotation (Line(
      points={{-12,25},{-12,34},{-60,34},{-60,20.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap2D;

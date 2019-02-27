within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Examples;
model FourPipeExample
  extends Modelica.Icons.Example
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

  FourPipe   fourPipe(
    mAir_flow_nominal=0.12,
    deltaTHea_nominal=10,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dpWatHea_nominal(displayUnit="Pa") = 10000,
    dpWatCoo_nominal(displayUnit="Pa") = 10000,
    QHea_flow_nominal=2000,
    QCoo_flow_nominal=2000,
    THea_a1_nominal=293.15,
    THea_a2_nominal=353.15,
    TCoo_a1_nominal=300.15,
    TCoo_a2_nominal=280.15)
                         "Fan coil unit model"
    annotation (Placement(transformation(extent={{50,-6},{74,18}})));
  Heater_T hea(
    dp_nominal=0,
    redeclare package Medium = IDEAS.Media.Water,
    QMax_flow=5000,
    m_flow_nominal=fourPipe.mWatHea_flow_nominal) "Heater component"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=2,
    redeclare package Medium = IDEAS.Media.Water,
    p=200000) "Water boundary"
    annotation (Placement(transformation(extent={{-90,-36},{-70,-16}})));
  Movers.FlowControlled_m_flow pumpHea(
    redeclare package Medium = IDEAS.Media.Water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    m_flow_nominal=fourPipe.mWatHea_flow_nominal) "Hot water mover component"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Sources.Ramp TSetHea(
    height=45,
    duration=3600*12,
    offset=273.15 + 35,
    startTime=3600) "Set point of the heater"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Blocks.Sources.Constant TAir(k=273.15 + 24)
    "Air temperature of the zone"
    annotation (Placement(transformation(extent={{-32,34},{-12,54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{6,-16},{28,6}})));
  Modelica.Blocks.Sources.Constant phi(k=0.4) "Humidity of the zone"
    annotation (Placement(transformation(extent={{-32,2},{-12,22}})));
  SensibleCooler_T
           coo(
    dp_nominal=0,
    redeclare package Medium = Media.Water,
    QMin_flow=-5000,
    m_flow_nominal=fourPipe.mWatCoo_flow_nominal) "Cooler component"
    annotation (Placement(transformation(extent={{-40,-78},{-20,-58}})));
  Movers.FlowControlled_m_flow pumpCoo(
    redeclare package Medium = Media.Water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    m_flow_nominal=fourPipe.mWatCoo_flow_nominal) "Cold water mover component"
    annotation (Placement(transformation(extent={{0,-78},{20,-58}})));
  Modelica.Blocks.Sources.Ramp TSetCoo(
    duration=3600*12,
    height=-9,
    offset=273.15 + 16,
    startTime=3600*14) "Set point of the cooler"
    annotation (Placement(transformation(extent={{-90,34},{-70,54}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=if time > 14*
        3600 then false else true)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger
    annotation (Placement(transformation(extent={{0,82},{14,96}})));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger1
    annotation (Placement(transformation(extent={{0,60},{14,74}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-22,60},{-8,74}})));
equation
  connect(bou.ports[1], hea.port_a) annotation (Line(points={{-70,-24},{-68,-24},
          {-68,-40},{-40,-40}}, color={0,127,255}));
  connect(hea.port_b, pumpHea.port_a)
    annotation (Line(points={{-20,-40},{0,-40}}, color={0,127,255}));
  connect(TSetHea.y, hea.TSet) annotation (Line(points={{-69,10},{-54,10},{-54,
          -32},{-42,-32}}, color={0,0,127}));
  connect(TAir.y, fourPipe.TAir) annotation (Line(points={{-11,44},{58.16,44},{
          58.16,15.6}}, color={0,0,127}));
  connect(prescribedTemperature.port, fourPipe.port_heat) annotation (Line(
        points={{28,-5},{32,-5},{32,-3.6},{50,-3.6}}, color={191,0,0}));
  connect(prescribedTemperature.T, TAir.y) annotation (Line(points={{3.8,-5},{
          -4,-5},{-4,44},{-11,44}}, color={0,0,127}));
  connect(coo.port_a, bou.ports[2]) annotation (Line(points={{-40,-68},{-70,-68},
          {-70,-28}}, color={0,127,255}));
  connect(coo.port_b, pumpCoo.port_a)
    annotation (Line(points={{-20,-68},{0,-68}}, color={0,127,255}));
  connect(pumpCoo.port_b, fourPipe.port_a1) annotation (Line(points={{20,-68},{
          64.4,-68},{64.4,-6}}, color={0,127,255}));
  connect(pumpHea.port_b, fourPipe.port_a2) annotation (Line(points={{20,-40},{
          71.6,-40},{71.6,-6}}, color={0,127,255}));
  connect(fourPipe.port_b2, hea.port_a) annotation (Line(points={{66.8,-6},{68,
          -6},{68,-22},{-40,-22},{-40,-40}}, color={0,127,255}));
  connect(fourPipe.port_b1, coo.port_a) annotation (Line(points={{59.6,-6},{60,
          -6},{60,-54},{-52,-54},{-52,-68},{-40,-68}}, color={0,127,255}));
  connect(TSetCoo.y, coo.TSet) annotation (Line(points={{-69,44},{-60,44},{-60,
          -60},{-42,-60}}, color={0,0,127}));
  connect(phi.y, fourPipe.phi) annotation (Line(points={{-11,12},{20,12},{20,
          15.6},{52.64,15.6}}, color={0,0,127}));
  connect(booleanExpression.y, booleanToInteger.u) annotation (Line(points={{
          -59,80},{-30,80},{-30,89},{-1.4,89}}, color={255,0,255}));
  connect(booleanToInteger.y, pumpHea.stage) annotation (Line(points={{14.7,89},
          {42,89},{42,-24},{10,-24},{10,-28}}, color={255,127,0}));
  connect(booleanExpression.y, not1.u) annotation (Line(points={{-59,80},{-30,
          80},{-30,68},{-26,68},{-26,67},{-23.4,67}}, color={255,0,255}));
  connect(not1.y, booleanToInteger1.u) annotation (Line(points={{-7.3,67},{
          -3.65,67},{-3.65,67},{-1.4,67}}, color={255,0,255}));
  connect(booleanToInteger1.y, pumpCoo.stage) annotation (Line(points={{14.7,67},
          {34,67},{34,-52},{10,-52},{10,-56}}, color={255,127,0}));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Examples/FourPipeExample.mos"),
    experiment(
      StopTime=100000,
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
      OutputFlatModelica=false),
    Documentation(revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>Example model of a two-pipe fan-coil unit (heating)</p>
</html>"));
end FourPipeExample;

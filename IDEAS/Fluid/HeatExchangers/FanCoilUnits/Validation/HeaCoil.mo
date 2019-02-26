within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Validation;
model HeaCoil
  extends Modelica.Icons.Example;

  package MediumWater = IDEAS.Media.Water;
//MANUFACTURER DATA
  Modelica.Blocks.Sources.CombiTimeTable manData(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
        485,6915,4149,1729; 10000,420,6260,3756,1565; 20000,330,5130,3078,1283;
        30000,236,3690,2214,923; 40000,123,2215,1329,554; 50000,0,0.001,0.001,
        0.001])
    "Manufacturers data - 1.flow  2. power at 80 degC 3. power at 55 degC 4. power at 35 degC"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Math.Gain gain(k=1/3600) "Converts from l/h to kg/s"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));

//AIR
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature "Prescribes air temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 20)
    "Air temperature is at 20degC in test conditions"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
//WATER SOURCES
   IDEAS.Fluid.Sources.Boundary_pT water_deg80(
    nPorts=1,
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    p=200000,
    T=353.15) "Water source at 80degC"
              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,10})));
  IDEAS.Fluid.Sources.Boundary_pT water_deg35(
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    p=200000,
    T=308.15,
    nPorts=1) "Water boundary at 35 degC" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-70})));
  IDEAS.Fluid.Sources.Boundary_pT water_deg55(
    nPorts=1,
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    p=200000,
    T=328.15) "Water boundary at 55 degC" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-30})));
  IDEAS.Fluid.Sources.Boundary_pT sink(
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    nPorts=3) "Water sink" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-90})));

//FAN-COILS
  IDEAS.Fluid.HeatExchangers.FanCoilUnits.TwoPipeHea fcu80(
    inputType=IDEAS.Fluid.Types.InputType.Continuous,
    mAir_flow_nominal=485/3600,
    Q_flow_nominal=6915,
    eps_nominal=1,
    allowFlowReversal=false,
    use_Q_flow_nominal=true,
    dpWat_nominal(displayUnit="Pa") = 100000,
    deltaTHea_nominal=10,
    T_a1_nominal=293.15,
    T_a2_nominal=353.15)
    annotation (Placement(transformation(extent={{-2,12},{24,40}})));
  IDEAS.Fluid.HeatExchangers.FanCoilUnits.TwoPipeHea fcu55(
    inputType=IDEAS.Fluid.Types.InputType.Continuous,
    mAir_flow_nominal=485/3600,
    eps_nominal=1,
    allowFlowReversal=false,
    use_Q_flow_nominal=true,
    dpWat_nominal(displayUnit="Pa") = 100000,
    deltaTHea_nominal=10,
    Q_flow_nominal=4149,
    T_a1_nominal=293.15,
    T_a2_nominal=328.15)
    annotation (Placement(transformation(extent={{-2,-28},{24,0}})));
  IDEAS.Fluid.HeatExchangers.FanCoilUnits.TwoPipeHea fcu35(
    inputType=IDEAS.Fluid.Types.InputType.Continuous,
    mAir_flow_nominal=485/3600,
    eps_nominal=1,
    allowFlowReversal=false,
    use_Q_flow_nominal=true,
    dpWat_nominal(displayUnit="Pa") = 100000,
    deltaTHea_nominal=5,
    Q_flow_nominal=1729,
    T_a1_nominal=293.15,
    T_a2_nominal=308.15)
    annotation (Placement(transformation(extent={{-2,-68},{24,-40}})));
//PUMPS
  IDEAS.Fluid.Movers.FlowControlled_m_flow pum(
    addPowerToMedium=false,
    redeclare package Medium = MediumWater,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=fcu80.mWat_flow_nominal) "Pump for media at 80degC" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,10})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pum1(
    addPowerToMedium=false,
    redeclare package Medium = MediumWater,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=fcu55.mWat_flow_nominal) "Pump for media at 55degC" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-30})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pum2(
    addPowerToMedium=false,
    redeclare package Medium = MediumWater,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=fcu35.mWat_flow_nominal) "Pump for media at 35degC" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-70})));
//ERRRORS
  Modelica.Blocks.Sources.RealExpression realExpression(y=(fcu80.coil.Q1_flow
         - manData.y[2])/manData.y[2]) "Error at 80degC conditions"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=(fcu55.coil.Q1_flow
         - manData.y[3])/manData.y[3]) "Error at 55degC conditions"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=(fcu35.coil.Q1_flow
         - manData.y[4])/manData.y[4]) "Error at 35degC conditions"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Blocks.Interfaces.RealOutput err80 "Error at 80degC conditions"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput err55 "Error at 80degC conditions"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput err35 "Error at 80degC conditions"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));

equation
  connect(manData.y[1], gain.u)
    annotation (Line(points={{-79,80},{-62,80}}, color={0,0,127}));
  connect(gain.y, fcu80.m_flow_in)
    annotation (Line(points={{-39,80},{18.8,80},{18.8,42.8}},
                                                            color={0,0,127}));
  connect(pum.port_b, fcu80.port_a) annotation (Line(points={{40,10},{14,10},{
          14,12},{13.6,12}}, color={0,127,255}));
  connect(pum.port_a, water_deg80.ports[1]) annotation (Line(points={{60,10},{80,
          10}},                             color={0,127,255}));
  connect(sink.ports[1], fcu80.port_b) annotation (Line(points={{-92.6667,-80},
          {-92.6667,6},{8.4,6},{8.4,12}}, color={0,127,255}));
  connect(prescribedTemperature.port, fcu80.port_heat) annotation (Line(points=
          {{-40,30},{-24,30},{-24,14},{-2,14},{-2,14.8}}, color={191,0,0}));
  connect(Tset.y, prescribedTemperature.T) annotation (Line(points={{-79,50},{-70,
          50},{-70,30},{-62,30}}, color={0,0,127}));
  connect(Tset.y, fcu80.TAir) annotation (Line(points={{-79,50},{6.84,50},{6.84,
          37.2}}, color={0,0,127}));
  connect(water_deg35.ports[1], pum2.port_a)
    annotation (Line(points={{80,-70},{60,-70}}, color={0,127,255}));
  connect(water_deg55.ports[1], pum1.port_a)
    annotation (Line(points={{80,-30},{60,-30}}, color={0,127,255}));
  connect(pum1.port_b, fcu55.port_a) annotation (Line(points={{40,-30},{26,-30},
          {26,-28},{13.6,-28}}, color={0,127,255}));
  connect(pum2.port_b, fcu35.port_a) annotation (Line(points={{40,-70},{28,-70},
          {28,-68},{13.6,-68}}, color={0,127,255}));
  connect(fcu55.port_b, sink.ports[2]) annotation (Line(points={{8.4,-28},{8,-28},
          {8,-32},{-90,-32},{-90,-80}}, color={0,127,255}));
  connect(fcu35.port_b, sink.ports[3]) annotation (Line(points={{8.4,-68},{8,
          -68},{8,-72},{-87.3333,-72},{-87.3333,-80}}, color={0,127,255}));
  connect(fcu35.port_heat, prescribedTemperature.port) annotation (Line(points=
          {{-2,-65.2},{-24,-65.2},{-24,30},{-40,30}}, color={191,0,0}));
  connect(fcu55.port_heat, prescribedTemperature.port) annotation (Line(points=
          {{-2,-25.2},{-24,-25.2},{-24,30},{-40,30}}, color={191,0,0}));
  connect(gain.y, fcu55.m_flow_in) annotation (Line(points={{-39,80},{32,80},{
          32,2.8},{18.8,2.8}},                 color={0,0,127}));
  connect(gain.y, fcu35.m_flow_in) annotation (Line(points={{-39,80},{32,80},{
          32,-37.2},{18.8,-37.2}},
                               color={0,0,127}));
  connect(Tset.y, fcu55.TAir) annotation (Line(points={{-79,50},{-12,50},{-12,2},
          {6.84,2},{6.84,-2.8}}, color={0,0,127}));
  connect(Tset.y, fcu35.TAir) annotation (Line(points={{-79,50},{-12,50},{-12,-36},
          {6.84,-36},{6.84,-42.8}}, color={0,0,127}));
  connect(realExpression2.y, err35)
    annotation (Line(points={{81,40},{110,40}}, color={0,0,127}));
  connect(realExpression1.y, err55)
    annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(realExpression.y, err80)
    annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Validation/HeaCoi.mos"),
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
      OutputFlatModelica=false),
    Documentation(revisions="<html>
<ul>
<li>
February 25, 2019, by Iago Cupeiro:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Validation of the two-pipe heating fan coil unit
model against manufacturer data from JAGA.
</p>
</html>"));
end HeaCoil;

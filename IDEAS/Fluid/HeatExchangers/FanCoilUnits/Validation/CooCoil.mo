within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Validation;
model CooCoil
  extends Modelica.Icons.Example;
  package MediumWater = IDEAS.Media.Water;
  //MANUFACTURER DATA
  Modelica.Blocks.Sources.CombiTimeTable manData(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
        485,1176,2176,2934; 10000,420,1053,1948,2657; 20000,330,865,1600,2209;
        30000,236,626,1158,1618; 40000,123,389,720,1018; 50000,0,0.001,0.001,
        0.001])
    "manufacturers data - 1.flow 2.power at 16 degC 3.sensible power at 7 degC 4.total power at 7degC"
    annotation (Placement(transformation(extent={{-100,74},{-80,94}})));
  Modelica.Blocks.Math.Gain gain(k=1/3600) "Conversion factor from l/h to kg/s"
    annotation (Placement(transformation(extent={{-60,74},{-40,94}})));
  //AIR
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature "Prescribes air temperature"
    annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 27)
    "air temperature is at 27degC in test conditions"
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Sources.Constant RH(k=0.47) "Wet bulb temperature is 19degC in test conditions => RH = 47%"
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));




//WATER SOURCES
  IDEAS.Fluid.Sources.Boundary_pT sink(
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    nPorts=2) "Water sink" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-90})));
  IDEAS.Fluid.Sources.Boundary_pT       water_deg16(
    nPorts=1,
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    p=200000,
    T=289.15) "Water source at 16degC"
              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,10})));
  IDEAS.Fluid.Sources.Boundary_pT water_deg7(
    nPorts=1,
    use_T_in=false,
    use_Xi_in=false,
    redeclare package Medium = MediumWater,
    p=200000,
    T=280.15) "Water source at 7degC" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-30})));

//FAN-COIL UNITS
  IDEAS.Fluid.HeatExchangers.FanCoilUnits.TwoPipeCoo fcu16(
    inputType=IDEAS.Fluid.Types.InputType.Continuous,
    mAir_flow_nominal=485/3600,
    eps_nominal=1,
    allowFlowReversal=false,
    use_Q_flow_nominal=true,
    dpWat_nominal(displayUnit="Pa") = 100000,
    Q_flow_nominal=1176,
    deltaTCoo_nominal=2,
    T_a1_nominal=300.15,
    T_a2_nominal=289.15)
    annotation (Placement(transformation(extent={{-2,12},{24,40}})));

  IDEAS.Fluid.HeatExchangers.FanCoilUnits.TwoPipeCoo fcu7(
    inputType=IDEAS.Fluid.Types.InputType.Continuous,
    mAir_flow_nominal=485/3600,
    eps_nominal=1,
    allowFlowReversal=false,
    use_Q_flow_nominal=true,
    dpWat_nominal(displayUnit="Pa") = 100000,
    deltaTCoo_nominal=5,
    Q_flow_nominal=2176,
    T_a1_nominal=300.15,
    T_a2_nominal=280.15,
    coil(pWat1(x_w(start=0.0103))))
    annotation (Placement(transformation(extent={{-2,-28},{24,0}})));

//PUMPS
 IDEAS.Fluid.Movers.FlowControlled_m_flow pum(
    addPowerToMedium=false,
    redeclare package Medium = MediumWater,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=fcu16.mWat_flow_nominal) "Pump for water at 16degC" annotation (Placement(
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
    m_flow_nominal=fcu7.mWat_flow_nominal) "Pump for water at 7degC" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-30})));

  //ERRORS
  Modelica.Blocks.Sources.RealExpression realExpression(y=(-fcu16.coil.Q1_flow
         - manData.y[2])/manData.y[2])  "Error at 16degC conditions"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=(-fcu7.coil.Q1_flow
         - manData.y[3])/manData.y[3]) "Error at 7degC conditions, sensible (to air)"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Interfaces.RealOutput err16 "Error at 16degC conditions"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput err7_sen "Error at 7degC conditions, sensible (to air)"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=(fcu7.coil.Q2_flow
         - manData.y[4])/manData.y[4]) "Error at 7degC conditions, total (to water)"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Blocks.Interfaces.RealOutput err7_tot "Error at 7degC conditions, total (to water)"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
equation
  connect(manData.y[1], gain.u)
    annotation (Line(points={{-79,84},{-62,84}}, color={0,0,127}));
  connect(gain.y, fcu16.m_flow_in)
    annotation (Line(points={{-39,84},{18.8,84},{18.8,42.8}},
                                                            color={0,0,127}));
  connect(pum.port_b, fcu16.port_a) annotation (Line(points={{40,10},{14,10},{
          14,12},{13.6,12}}, color={0,127,255}));
  connect(pum.port_a,water_deg16. ports[1]) annotation (Line(points={{60,10},{80,
          10}},                             color={0,127,255}));
  connect(sink.ports[1], fcu16.port_b) annotation (Line(points={{-92,-80},{-92,
          6},{8.4,6},{8.4,12}}, color={0,127,255}));
  connect(prescribedTemperature.port, fcu16.port_heat) annotation (Line(points=
          {{-40,34},{-24,34},{-24,14},{-2,14},{-2,14.8}}, color={191,0,0}));
  connect(Tset.y, prescribedTemperature.T) annotation (Line(points={{-79,54},{-70,
          54},{-70,34},{-62,34}}, color={0,0,127}));
  connect(Tset.y, fcu16.TAir) annotation (Line(points={{-79,54},{6.84,54},{6.84,
          37.2}}, color={0,0,127}));
  connect(water_deg7.ports[1], pum1.port_a)
    annotation (Line(points={{80,-30},{60,-30}}, color={0,127,255}));
  connect(pum1.port_b, fcu7.port_a) annotation (Line(points={{40,-30},{26,-30},
          {26,-28},{13.6,-28}}, color={0,127,255}));
  connect(fcu7.port_b, sink.ports[2]) annotation (Line(points={{8.4,-28},{8,-28},
          {8,-32},{-88,-32},{-88,-80}}, color={0,127,255}));
  connect(fcu7.port_heat, prescribedTemperature.port) annotation (Line(points={
          {-2,-25.2},{-24,-25.2},{-24,34},{-40,34}}, color={191,0,0}));
  connect(gain.y, fcu7.m_flow_in) annotation (Line(points={{-39,84},{32,84},{32,
          2.8},{18.8,2.8}},                 color={0,0,127}));
  connect(Tset.y, fcu7.TAir) annotation (Line(points={{-79,54},{-12,54},{-12,2},
          {6.84,2},{6.84,-2.8}}, color={0,0,127}));
  connect(RH.y, fcu7.phi) annotation (Line(points={{-79,22},{-64,22},{-64,-2.8},
          {0.86,-2.8}}, color={0,0,127}));
  connect(RH.y, fcu16.phi) annotation (Line(points={{-79,22},{-30,22},{-30,48},
          {0.86,48},{0.86,37.2}}, color={0,0,127}));
  connect(realExpression1.y, err7_sen)
    annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(realExpression.y, err16)
    annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  connect(realExpression2.y, err7_tot)
    annotation (Line(points={{81,40},{110,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Validation/CooCoi.mos"),
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
end CooCoil;

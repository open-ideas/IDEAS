within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples;
model TrtComparison "Validation based on thermal response test"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water "Medium model";


  MultipleBoreHolesUTube borFie1U(
    redeclare package Medium = Medium,
    redeclare Data.BorefieldData.BorefieldDataTrtUTube bfData,
    T_start=273.15 + 11.28) "Borefield with 1 u tube"
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  HeaterCooler_u heater2Utube(
    redeclare package Medium = Medium,
    dp_nominal=10000,
    show_T=true,
    p_start=100000,
    m_flow_nominal=pum.m_flow_nominal,
    Q_flow_nominal=3618,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Movers.FlowControlled_m_flow pum(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    filteredSpeed=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=0.340278,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    constantMassFlowRate=0.340278)
    annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
  Sensors.TemperatureTwoPort senTem_out(
    redeclare package Medium = Medium,
    m_flow_nominal=pum.m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Sensors.TemperatureTwoPort senTem_in(
    redeclare package Medium = Medium,
    m_flow_nominal=pum.m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  MultipleBoreHoles2UTube borFie2U(
    redeclare package Medium = Medium,
    T_start=273.15 + 11.28,
    redeclare Data.BorefieldData.BorefieldDataTrt2UTube bfData,
    show_T=true,
    dp_nominal=10000)       "Borefield with 2 u tubes"
    annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
  HeaterCooler_u heater1Utube(
    redeclare package Medium = Medium,
    dp_nominal=10000,
    show_T=true,
    p_start=100000,
    m_flow_nominal=pum.m_flow_nominal,
    Q_flow_nominal=3618,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
  Movers.FlowControlled_m_flow             pum1(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    filteredSpeed=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=0.340278,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    constantMassFlowRate=0.340278)
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
  Sensors.TemperatureTwoPort             senTem_out1(
    redeclare package Medium = Medium,
    m_flow_nominal=pum.m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Sensors.TemperatureTwoPort             senTem_in1(
    redeclare package Medium = Medium,
    m_flow_nominal=pum.m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Step load(height=1, startTime=36000)
    "load for the borefield"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Sources.Boundary_pT bou(nPorts=2, redeclare package Medium = Medium)
    "Boundary for absolute pressure"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(pum.port_a, heater2Utube.port_b) annotation (Line(
      points={{-20,80},{20,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pum.port_b,senTem_in. port_a) annotation (Line(
      points={{-40,80},{-78,80},{-78,40},{-60,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heater2Utube.port_a, senTem_out.port_b) annotation (Line(
      points={{40,80},{70,80},{70,40},{60,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem_out.port_a, borFie1U.port_b) annotation (Line(
      points={{40,40},{20,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem_in.port_b, borFie1U.port_a) annotation (Line(
      points={{-40,40},{-20,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pum1.port_a, heater1Utube.port_b) annotation (Line(
      points={{-20,-20},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(load.y, heater2Utube.u) annotation (Line(points={{79,30},{80,30},{80,44},
          {80,86},{42,86}}, color={0,0,127}));
  connect(load.y, heater1Utube.u) annotation (Line(points={{79,30},{80,30},{80,
          -12},{80,-14},{42,-14}},
                              color={0,0,127}));
  connect(bou.ports[1], senTem_in.port_a)
    annotation (Line(points={{-80,2},{-80,40},{-60,40}}, color={0,127,255}));
  connect(pum1.port_b, bou.ports[2]) annotation (Line(points={{-40,-20},{-80,
          -20},{-80,-2}}, color={0,127,255}));
  connect(senTem_in1.port_b, borFie2U.port_a) annotation (Line(points={{-40,-60},
          {-30,-60},{-20,-60}}, color={0,127,255}));
  connect(borFie2U.port_b, senTem_out1.port_a)
    annotation (Line(points={{20,-60},{40,-60}}, color={0,127,255}));
  connect(senTem_out1.port_b, heater1Utube.port_a) annotation (Line(points={{60,
          -60},{62,-60},{62,-20},{40,-20}}, color={0,127,255}));
  connect(pum1.port_b, senTem_in1.port_a) annotation (Line(points={{-40,-20},{
          -68,-20},{-80,-20},{-80,-60},{-60,-60}}, color={0,127,255}));
 annotation (experiment(StopTime=309000), __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model serves as a verification for the bore field model. It simulates a real thermal response test (TRT) where one bore hole was heated with a constant thermal power. The supply temperature was measured and fitted by correlation <code>T_measured</code>. </p>
<p>The model uses the real bore hole dimensions as well as the thermal conductivity that was obtained from the TRT test. Therefore its temperature response should be equal to <code>T_measured</code>. </p>
<p>This model is not unit tested becasue the generation of the aggregation matrix is not supported by BuildingsPy.</p>
</html>", revisions="<html>
<ul>
<li>
January 2015, by Filip Jorissen:<br>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica:/IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Validation/TrtValidationMultipleBoreholeUTube.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end TrtComparison;

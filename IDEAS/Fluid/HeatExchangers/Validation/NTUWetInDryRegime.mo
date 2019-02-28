within IDEAS.Fluid.HeatExchangers.Validation;
model NTUWetInDryRegime
  "Model to verify that WetCoilEffectivenessNTU results are identical to DryCoilEffectivenesNTU in dry regime"
 extends Modelica.Icons.Example;

 package MediumAir = IDEAS.Media.Air;
 package MediumWater = IDEAS.Media.Water;

  DryCoilEffectivenessNTU dryHex(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=0.15,
    m2_flow_nominal=0.5,
    dp1_nominal=0,
    dp2_nominal=0,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,

    Q_flow_nominal=2000,
    T_a1_nominal=296.15,
    T_a2_nominal=323.15) "Dry NTU H-Ex"
    annotation (Placement(transformation(extent={{0,34},{20,54}})));
  Sources.Boundary_pT souAir(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    nPorts=2) annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Movers.FlowControlled_m_flow fanDry(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.15) "Air fan"
    annotation (Placement(transformation(extent={{-30,44},{-10,64}})));
  Movers.FlowControlled_m_flow fanWet(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.15) "Air fan"
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Sources.Boundary_pT sinAir(redeclare package Medium = MediumAir, nPorts=2)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={62,70})));
  Modelica.Blocks.Sources.Ramp rampAir(
    duration=10000,
    offset=273.15 + 5,
    startTime=1000,
    height=20)
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  Sources.Boundary_pT souWat(
    nPorts=2,
    redeclare package Medium = MediumWater,
    use_T_in=true) "Water source" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,10})));
  Movers.FlowControlled_m_flow pumpDry(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.5) "Water pump"
    annotation (Placement(transformation(extent={{62,28},{42,48}})));
  Sources.Boundary_pT sinWat(nPorts=2, redeclare package Medium = MediumWater)
    "Water source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,30})));
  Movers.FlowControlled_m_flow pumpWet(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.5) "Water pump"
    annotation (Placement(transformation(extent={{64,-38},{44,-18}})));
  WetCoilEffectivenessNTU wetHex(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=0.15,
    m2_flow_nominal=0.5,
    dp1_nominal=0,
    dp2_nominal=0,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,

    Q_flow_nominal=2000,
    T_a1_nominal=296.15,
    T_a2_nominal=323.15) "Wet NTU H-Ex"
    annotation (Placement(transformation(extent={{0,-14},{20,6}})));
  Modelica.Blocks.Sources.Ramp rampWat(
    duration=10000,
    startTime=1000,
    offset=273.15 + 60,
    height=-55)
    annotation (Placement(transformation(extent={{130,20},{110,40}})));
equation
  connect(fanDry.port_b, dryHex.port_a1) annotation (Line(points={{-10,54},{-4,
          54},{-4,50},{0,50}}, color={0,127,255}));
  connect(fanDry.port_a, souAir.ports[1]) annotation (Line(points={{-30,54},{
          -36,54},{-36,72},{-50,72}}, color={0,127,255}));
  connect(fanWet.port_a, souAir.ports[2]) annotation (Line(points={{-30,10},{
          -40,10},{-40,68},{-50,68}}, color={0,127,255}));
  connect(dryHex.port_b1, sinAir.ports[1]) annotation (Line(points={{20,50},{32,
          50},{32,72},{52,72}}, color={0,127,255}));
  connect(rampAir.y, souAir.T_in)
    annotation (Line(points={{-79,74},{-72,74}}, color={0,0,127}));
  connect(pumpDry.port_b, dryHex.port_a2)
    annotation (Line(points={{42,38},{20,38}}, color={0,127,255}));
  connect(pumpDry.port_a, souWat.ports[1])
    annotation (Line(points={{62,38},{62,12},{70,12}}, color={0,127,255}));
  connect(sinWat.ports[1], dryHex.port_b2) annotation (Line(points={{-60,32},{
          -2,32},{-2,38},{0,38}}, color={0,127,255}));
  connect(fanWet.port_b, wetHex.port_a1) annotation (Line(points={{-10,10},{-2,
          10},{-2,2},{0,2}}, color={0,127,255}));
  connect(wetHex.port_b1, sinAir.ports[2]) annotation (Line(points={{20,2},{38,
          2},{38,68},{52,68}}, color={0,127,255}));
  connect(pumpWet.port_a, souWat.ports[2])
    annotation (Line(points={{64,-28},{70,-28},{70,8}}, color={0,127,255}));
  connect(pumpWet.port_b, wetHex.port_a2) annotation (Line(points={{44,-28},{36,
          -28},{36,-10},{20,-10}}, color={0,127,255}));
  connect(wetHex.port_b2, sinWat.ports[2])
    annotation (Line(points={{0,-10},{-60,-10},{-60,28}}, color={0,127,255}));
  connect(rampWat.y, souWat.T_in) annotation (Line(points={{109,30},{102,30},{
          102,14},{92,14}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}})),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
            100}})),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/Validation/NTUWetInDryRegime.mos"));

end NTUWetInDryRegime;

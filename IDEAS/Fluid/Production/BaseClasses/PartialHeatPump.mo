within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatPump "Heat pump partial"

  Modelica.Fluid.Interfaces.FluidPort_a brineIn(redeclare package Medium =
        MediumBrine)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidOut(redeclare package Medium =
        MediumFluid)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidIn(redeclare package Medium =
        MediumFluid)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b brineOut(redeclare package Medium =
        MediumBrine)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  replaceable package MediumBrine =
    Modelica.Media.Interfaces.PartialMedium "Brine medium at primary side"
    annotation(choicesAllMatching=true);
  replaceable package MediumFluid =
    Modelica.Media.Interfaces.PartialMedium "Fluid medium at secondary side"
    annotation(choicesAllMatching=true);
  replaceable parameter HeatPumpData heatPumpData
  constrainedby HeatPumpData
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-98,-98},{-78,-78}})));

    //From LumpedVolumeDeclarations
      // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Formulation of mass balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  final parameter Modelica.Fluid.Types.Dynamics substanceDynamics=energyDynamics
    "Formulation of substance balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  final parameter Modelica.Fluid.Types.Dynamics traceDynamics=energyDynamics
    "Formulation of trace substance balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  // Initialization
  parameter MediumBrine.AbsolutePressure p_start = MediumBrine.p_default
    "Start value of primary circuit pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumBrine.Temperature T_start=MediumBrine.T_default
    "Start value of primary circuit temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumBrine.MassFraction X_start[MediumBrine.nX] = MediumBrine.X_default
    "Start value of primary circuit mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=MediumBrine.nXi > 0));
  parameter MediumBrine.ExtraProperty C_start[MediumBrine.nC](
       quantity=MediumBrine.extraPropertiesNames)=fill(0, MediumBrine.nC)
    "Start value of primary circuit trace substances"
    annotation (Dialog(tab="Initialization", enable=MediumBrine.nC > 0));
  parameter MediumBrine.ExtraProperty C_nominal[MediumBrine.nC](
       quantity=MediumBrine.extraPropertiesNames) = fill(1E-2, MediumBrine.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", enable=MediumBrine.nC > 0));

  parameter MediumFluid.AbsolutePressure p_start2 = MediumFluid.p_default
    "Start value of secondary circuit pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumFluid.Temperature T_start2=MediumFluid.T_default
    "Start value of secondary circuit temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumFluid.MassFraction X_start2[MediumFluid.nX] = MediumFluid.X_default
    "Start value of secondary circuit mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=MediumFluid.nXi > 0));
  parameter MediumFluid.ExtraProperty C_start2[MediumFluid.nC](
       quantity=MediumFluid.extraPropertiesNames)=fill(0, MediumFluid.nC)
    "Start value of secondary circuit trace substances"
    annotation (Dialog(tab="Initialization", enable=MediumFluid.nC > 0));
  parameter MediumFluid.ExtraProperty C_nominal2[MediumFluid.nC](
       quantity=MediumFluid.extraPropertiesNames) = fill(1E-2, MediumFluid.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", enable=MediumFluid.nC > 0));

  //From TwoPortFlowResistanceParameters:
  parameter Boolean from_dp = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(enable = computeFlowResistance,
                tab="Flow resistance"));
  parameter Boolean linearizeFlowResistance = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(enable = computeFlowResistance,
               tab="Flow resistance"));
  parameter Real deltaM = 0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation(Dialog(enable = computeFlowResistance, tab="Flow resistance"));

  Modelica.Blocks.Sources.RealExpression realExpression(y=-P_evap)
    annotation (Placement(transformation(extent={{18,0},{0,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-12,0},{-32,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{22,-20},{42,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        heatPumpData.G)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss
    annotation (Placement(transformation(extent={{16,-110},{36,-90}})));

  Modelica.Blocks.Sources.RealExpression realExpression1(y=P_cond)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort T_in_evap(
    redeclare package Medium = MediumBrine,
    allowFlowReversal=allowFlowReversal,
    tau=10,
    m_flow_nominal=heatPumpData.m_flow_nominal_fluid)
            annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort T_in_cond(
    redeclare package Medium = MediumFluid,
    tau=10,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=heatPumpData.m_flow_nominal_fluid)
    annotation (Placement(transformation(extent={{88,-50},{68,-30}})));

  Modelica.SIunits.Power P_el "Electrical power consumption";
  Modelica.SIunits.Power P_evap "Thermal power of the evaporator (positive)";
  Modelica.SIunits.Power P_cond "Thermal power of the condensor (positive)";
  Modelica.Blocks.Sources.RealExpression realExpression2(y=P_el)
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumption"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,110})));
public
  parameter Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Dialog(tab="Flow resistance"));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";

  FixedResistances.Pipe_HeatPort evaporator(
    redeclare package Medium = MediumBrine,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    m_flow_nominal=heatPumpData.m_flow_nominal_brine,
    m=heatPumpData.mBrine,
    dp_nominal=heatPumpData.dp_nominal_brine)
              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,10})));
  FixedResistances.Pipe_HeatPort condensor(
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    redeclare package Medium = MediumFluid,
    p_start=p_start2,
    T_start=T_start2,
    X_start=X_start2,
    C_start=C_start2,
    C_nominal=C_nominal2,
    m_flow_nominal=heatPumpData.m_flow_nominal_fluid,
    m=heatPumpData.mFluid,
    dp_nominal=heatPumpData.dp_nominal_fluid)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-10})));

equation
  connect(heatLoss, thermalConductor.port_a) annotation (Line(
      points={{26,-100},{26,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.Q_flow, realExpression.y) annotation (Line(
      points={{-12,10},{-0.9,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.Q_flow, realExpression1.y) annotation (Line(
      points={{22,-10},{1,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(brineIn, T_in_evap.port_a) annotation (Line(
      points={{-100,40},{-92,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fluidIn, T_in_cond.port_a) annotation (Line(
      points={{100,-40},{88,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression2.y,P)  annotation (Line(
      points={{39,80},{20,80},{20,110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(evaporator.port_a, T_in_evap.port_b) annotation (Line(
      points={{-60,20},{-60,40},{-72,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(evaporator.heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{-50,10},{-32,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(evaporator.port_b, brineOut) annotation (Line(
      points={{-60,0},{-60,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_in_cond.port_b, condensor.port_a) annotation (Line(
      points={{68,-40},{60,-40},{60,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(condensor.port_b, fluidOut) annotation (Line(
      points={{60,0},{60,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.port, condensor.heatPort) annotation (Line(
      points={{42,-10},{50,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor.port_b, condensor.heatPort) annotation (Line(
      points={{26,-60},{26,-28},{50,-28},{50,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(
          points={{-100,40},{-20,40},{-40,20},{-20,0},{-40,-20},{-20,-40},{-100,
              -40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{100,40},{20,40},{40,20},{20,0},{40,-20},{20,-40},{100,-40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-20,20},{20,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{10,30},{20,20},{10,10}},
          color={255,0,0},
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end PartialHeatPump;

within IDEAS.Fluid.HeatExchangers.FanCoilUnits.BaseClasses;
partial model PartialFanCoil
  replaceable package MediumAir = IDEAS.Media.Air
    "Air medium";

  parameter IDEAS.Fluid.HeatExchangers.FanCoilUnits.Types.FCUConfigurations configFCU
    "Configuration of the fan coil unit";
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal
    "Nominal mass flow of the air stream";
  parameter IDEAS.Fluid.Types.InputType inputType=IDEAS.Fluid.Types.InputType.Continuous
    "Fan control input type" annotation (Dialog(group="Fan parameters"));
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions"));
  final parameter Boolean humidity = if configFCU == IDEAS.Fluid.HeatExchangers.FanCoilUnits.Types.FCUConfigurations.TwoPipeHea then false else true
    "Parameter to know if compute humidity (only 2-pipe cooling and 4-pipe)";
  final parameter Modelica.SIunits.AbsolutePressure p = 101325
    "Pressure of the zone";

  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = MediumAir,
    use_T_in=true,
    use_Xi_in=humidity,
    p=p)
    "Boundary conditions of the zone" annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=mAir_flow_nominal,
    inputType=inputType,
    tau=0)
    "Fan recirculating the air in the zone through the fan coil unit"  annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IDEAS.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = MediumAir,
    nPorts=1)
   "Ideal sink" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,50})));

  Modelica.Blocks.Interfaces.IntegerInput stage if
       fan.inputType == IDEAS.Fluid.Types.InputType.Stages
    "Stage input signal for the pressure head"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in(
    final unit="kg/s",
    nominal= mAir_flow_nominal) if
       fan.inputType == IDEAS.Fluid.Types.InputType.Continuous
    "Prescribed mass flow rate"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,120}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,120})));
  Modelica.Blocks.Interfaces.RealInput TAir(
    final unit="K",
    displayUnit="degC")
    "Air temperature of the coupled zone" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-32,80})));
  Modelica.Blocks.Interfaces.RealInput phi if humidity == true
    "Relative humidity of the zone" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-80,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-78,80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heat
    "Heat port, to be connected to the convective port of the zone"        annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  IDEAS.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false) if
       humidity == true
    "Mass fraction of the zone based on its temperature and relative humidity"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-78,38})));
  IDEAS.Utilities.Psychrometrics.pW_X pWat(use_p_in=false) if humidity == true
  "Water vapour pressure of the zone, needed to compute the dew point"  annotation (Placement(transformation(extent={{-80,-40},
            {-60,-20}})));
  IDEAS.Utilities.Psychrometrics.TDewPoi_pW dewPoi if humidity == true
    "Dew point of the zone"        annotation (Placement(transformation(extent={{-40,-40},
            {-20,-20}})));
  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulPhi wetBul(
    redeclare package Medium = MediumAir) if humidity == true
      "Wet bulb temperature of the zone, needed to compute the heat capacity of the saturated ficticious fluid according to Braun-Lebrun model" annotation (Placement(transformation(extent={{-40,58},{-20,78}})));
  Modelica.Blocks.Sources.Constant p_atm(k=p)
  "Constant pressure needed for the wetBulb model"  annotation (Placement(transformation(extent={{-98,68},{-88,78}})));
  IDEAS.Utilities.Psychrometrics.X_pTphi x_pTphiSat(use_p_in=false) if humidity == true
  "Mass fraction for saturation conditions, needed to compute the saturation enthalpy used in the Braun-Lebrun model"  annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Constant sat(k=1) if humidity == true
  "Saturation conditions (humidity = 100%)"  annotation (Placement(transformation(extent={{0,60},{
            8,68}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo(
    final alpha=0)
    "Prescribed heat flow rate"
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression QZon
    "Convective heat flow transferred to the zone's air"
    annotation (Placement(transformation(extent={{-30,-90},{-50,-70}})));
protected
  final parameter MediumAir.ThermodynamicState staAir_default = MediumAir.setState_pTX(
     T=MediumAir.T_default,
     p=MediumAir.p_default,
     X=MediumAir.X_default[1:MediumAir.nXi]) "Default state for air medium";

  final parameter Modelica.SIunits.HeatCapacity cpAir_nominal = MediumAir.specificHeatCapacityCp(staAir_default) "Nominal heat capacity on the air side";

equation
  connect(bou.ports[1], fan.port_a)
    annotation (Line(points={{-68,0},{-50,0}}, color={0,127,255}));
  connect(bou.T_in, TAir) annotation (Line(points={{-90,4},{-92,4},{-92,56},{-50,
          56},{-50,120}}, color={0,0,127}));
  connect(m_flow_in, fan.m_flow_in) annotation (Line(points={{60,120},{60,40},{-40,
          40},{-40,12}}, color={0,0,127}));
  connect(stage, fan.stage);
  connect(x_pTphi.X, bou.Xi_in) annotation (Line(points={{-78,27},{-78,18},{-96,
          18},{-96,-4},{-90,-4}}, color={0,0,127}));
  connect(x_pTphi.phi, phi) annotation (Line(points={{-84,50},{-84,62},{-80,62},
          {-80,120}}, color={0,0,127}));
  connect(TAir, x_pTphi.T) annotation (Line(points={{-50,120},{-50,56},{-78,56},
          {-78,50}}, color={0,0,127}));
  connect(pWat.p_w, dewPoi.p_w)
    annotation (Line(points={{-59,-30},{-41,-30}}, color={0,0,127}));
  connect(bou.Xi_in[1], pWat.X_w) annotation (Line(points={{-90,-4},{-96,-4},{-96,
          -30},{-81,-30}}, color={0,0,127}));
  connect(TAir, wetBul.TDryBul)
    annotation (Line(points={{-50,120},{-50,76},{-41,76}}, color={0,0,127}));
  connect(phi, wetBul.phi)
    annotation (Line(points={{-80,120},{-80,68},{-41,68}}, color={0,0,127}));
  connect(p_atm.y, wetBul.p) annotation (Line(points={{-87.5,73},{-60,73},{-60,60},
          {-41,60}}, color={0,0,127}));
  connect(sat.y, x_pTphiSat.phi) annotation (Line(points={{8.4,64},{18,64}},
                        color={0,0,127}));
  connect(dewPoi.T, x_pTphiSat.T) annotation (Line(points={{-19,-30},{-14,-30},{
          -14,70},{18,70}},                                       color={0,0,127}));
  connect(preHeaFlo.port, port_heat)
    annotation (Line(points={{-80,-80},{-100,-80}}, color={191,0,0}));
  connect(QZon.y, preHeaFlo.Q_flow)
    annotation (Line(points={{-51,-80},{-60,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,40},{100,-60}},
          lineColor={0,0,0},
          radius=10),
          Rectangle(
          extent={{-92,-8},{92,-54}},
          lineColor={0,0,0},
          radius=10,
          lineThickness=0.5),
          Rectangle(
          extent={{-92,34},{-36,0}},
          lineColor={0,0,0},
          radius=10,
          lineThickness=0.5),
          Rectangle(
          extent={{36,34},{92,0}},
          lineColor={0,0,0},
          radius=10,
          lineThickness=0.5),
          Rectangle(
          extent={{-28,34},{28,0}},
          lineColor={0,0,0},
          radius=10,
          lineThickness=0.5),
        Line(
          points={{-84,26},{-44,26}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-84,10},{-44,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-20,26},{20,26}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-20,10},{20,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{44,26},{84,26}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{44,10},{84,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-84,-16},{84,-16}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-84,-30},{84,-30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-84,-44},{84,-44}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialFanCoil;

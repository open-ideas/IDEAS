within IDEAS.Fluid.HeatExchangers.FanCoilUnits;
model TwoPipeCoo "FanCoil with 2-pipe configuration for cooling"
  extends IDEAS.Fluid.HeatExchangers.FanCoilUnits.BaseClasses.PartialFanCoil(
  final configFCU = IDEAS.Fluid.HeatExchangers.FanCoilUnits.Types.FCUConfigurations.TwoPipeCoo,
    fan(dp_nominal=0),
    bou(p=120000));

  package MediumWater = IDEAS.Media.Water "Media in the water-side";

  parameter Modelica.SIunits.TemperatureDifference deltaTCoo_nominal = 5 "nominal temperature difference in water side"
  annotation (Dialog(group="Coil parameters"));

  parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal = coil.Q_flow_nominal/cpWat_nominal/deltaTCoo_nominal
  "Nominal mass flow of the coil";

  parameter Modelica.SIunits.PressureDifference dpWat_nominal
    "Pressure difference on water side"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal "Nominal heat transfer"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.Temperature T_a1_nominal "Nominal temperature of inlet air"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.Temperature T_a2_nominal "Nominal temperature of water inlet"
    annotation (Dialog(group="Coil parameters"));
  parameter Boolean use_Q_flow_nominal=true
    "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness"
    annotation (Dialog(group="Coil parameters"));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=coil.wcond.Q1_flow) "Convective heat flow transferred to the zone's air"
    annotation (Placement(transformation(extent={{-30,-90},{-50,-70}})));
  parameter Real eps_nominal "Nominal heat transfer effectiveness"
    annotation (Dialog(group="Coil parameters", enable=not use_Q_flow_nominal));

    IDEAS.Fluid.HeatExchangers.FanCoilUnits.BaseClasses.CooCoil coil(
    use_Q_flow_nominal=use_Q_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal,
    r_nominal=cpAir_nominal/cpWat_nominal,
    eps_nominal=1,
    mAir_flow_nominal=mAir_flow_nominal,
    mWat_flow_nominal=mWat_flow_nominal,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dpWat_nominal=dpWat_nominal,
    wocond(C1_flow=coil.port_a1.m_flow*cp1),
    wcond(C1_flow=coil.port_a1.m_flow*cp_effective),
    dpAir_nominal=100000)
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));

  IDEAS.Fluid.Sensors.TemperatureTwoPort supWat(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    m_flow_nominal=mWat_flow_nominal,
    tau=0) "Water sensor to check if condensation occurs" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={20,-54})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = MediumWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = MediumWater)
    "Fluid connector (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));

protected
   final MediumAir.ThermodynamicState sta_dewPoint = MediumAir.setState_pTX(
      T= dewPoi.T,
      p=MediumAir.p_default,
      X= x_pTphi.X) "State for dew point conditions";


   final Modelica.SIunits.SpecificEnthalpy h_coil = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= TAir,
      p=MediumAir.p_default,
      X= x_pTphi.X) "Supply air enthalpy to the coil";

   final Modelica.SIunits.SpecificEnthalpy h_saturation = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= wetBul.TWetBul,
      p=MediumAir.p_default,
      X= x_pTphiSat.X) "Enthalpy of the ficticious fluid from Braun-Lebrun model";

   final Modelica.SIunits.SpecificHeatCapacity cp_saturation = (h_coil - h_saturation) / (wetBul.TWetBul - dewPoi.T) "Heat capacity used in the ficticious fluid when condensation occurs, according to Braun-Lebrun model";

   final Modelica.SIunits.SpecificHeatCapacity cp1 = MediumAir.specificHeatCapacityCp(coil.wocond.state_a1_inflow) "Heat capacity used when no condensation occurs";

   final Modelica.SIunits.SpecificHeatCapacity cp_effective = if supWat.T <= dewPoi.T then cp_saturation else cp1 "Heat capacity used in the coil that computes condensation (air-side)";

   final parameter MediumWater.ThermodynamicState staWat_default = MediumWater.setState_pTX(
     T=MediumWater.T_default,
     p=MediumWater.p_default,
     X=MediumWater.X_default[1:MediumWater.nXi]) "Default state for water-side";

   final parameter Modelica.SIunits.SpecificHeatCapacity cpWat_nominal = MediumWater.specificHeatCapacityCp(staWat_default) "Nominal heat capacity of the water side";


equation
  connect(fan.port_b, coil.port_a1)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  connect(coil.port_b1, sink.ports[1])
    annotation (Line(points={{10,0},{80,0},{80,40}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, port_heat)
    annotation (Line(points={{-80,-80},{-100,-80}}, color={191,0,0}));
  connect(realExpression.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-51,-80},{-60,-80}}, color={0,0,127}));
  connect(port_b, coil.port_b2) annotation (Line(points={{-20,-100},{-20,-12},{-10,
          -12}}, color={0,127,255}));
  connect(port_a, supWat.port_a)
    annotation (Line(points={{20,-100},{20,-64}}, color={0,127,255}));
  connect(supWat.port_b, coil.port_a2)
    annotation (Line(points={{20,-44},{20,-12},{10,-12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoPipeCoo;

within IDEAS.Fluid.HeatExchangers.FanCoilUnits;
model TwoPipeHea "FanCoil with 2-pipe configuration for heating"
  extends IDEAS.Fluid.HeatExchangers.FanCoilUnits.BaseClasses.PartialFanCoil(
  final configFCU = IDEAS.Fluid.HeatExchangers.FanCoilUnits.Types.FCUConfigurations.TwoPipeHea,
    fan(dp_nominal=0),
    bou(p=120000),
    sink(nPorts=1));

  package MediumWater = IDEAS.Media.Water "Media in the water-side";

  parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal = coil.Q_flow_nominal/cpWat_nominal/deltaTHea_nominal
  "Nominal mass flow of the coil";

  parameter Modelica.SIunits.TemperatureDifference deltaTHea_nominal = 10 "Nominal temperature difference in water side"
  annotation (Dialog(group="Coil parameters"));

 parameter Modelica.SIunits.PressureDifference dpWat_nominal
    "Pressure difference on water side"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal "Nominal heat transfer"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.Temperature T_a1_nominal "Nominal temperature of inlet air"
    annotation (Dialog(group="Coil parameters"));
  parameter Modelica.SIunits.Temperature T_a2_nominal "Nominal temperature of inlet water"
    annotation (Dialog(group="Coil parameters"));
  parameter Boolean use_Q_flow_nominal=true
    "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness"
    annotation (Dialog(group="Coil parameters"));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression heatFlow(y=coil.Q1_flow) "Convective heat flow transferred to the zone's air"
    annotation (Placement(transformation(extent={{-30,-90},{-50,-70}})));
  parameter Real eps_nominal "Nominal heat transfer effectiveness"
    annotation (Dialog(group="Coil parameters", enable=not use_Q_flow_nominal));

  IDEAS.Fluid.HeatExchangers.WetCoilEffectivenessNTU coil(redeclare package
      Medium1 = MediumAir, configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWat_flow_nominal,
    dp2_nominal=dpWat_nominal,
    use_Q_flow_nominal=use_Q_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal,
    r_nominal=cpAir_nominal/cpWat_nominal,
    dp1_nominal=100000,
    show_T=true,
    C1_flow = coil.port_a1.m_flow*cp1,
    allowFlowReversal1=false,
    allowFlowReversal2=false)
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));

 Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = MediumWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = MediumWater)
    "Fluid connector (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));

protected
    final Modelica.SIunits.SpecificHeatCapacity cp1 = MediumAir.specificHeatCapacityCp(coil.state_a1_inflow) "Heat capacity flowing into the water side of the coil";

    final parameter MediumWater.ThermodynamicState staWat_default = MediumWater.setState_pTX(
     T=MediumWater.T_default,
     p=MediumWater.p_default,
     X=MediumWater.X_default[1:MediumWater.nXi]) "Default state for water-side";

    final parameter Modelica.SIunits.SpecificHeatCapacity cpWat_nominal = MediumWater.specificHeatCapacityCp(staWat_default) "Nominal heat capacity of the water-side";


equation
  connect(prescribedHeatFlow.port, port_heat)
    annotation (Line(points={{-80,-80},{-100,-80}}, color={191,0,0}));
  connect(heatFlow.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-51,-80},{-60,-80}}, color={0,0,127}));
  connect(port_a, coil.port_a2)
    annotation (Line(points={{20,-100},{20,-12},{10,-12}}, color={0,127,255}));
  connect(coil.port_b2, port_b) annotation (Line(points={{-10,-12},{-20,-12},{
          -20,-100}}, color={0,127,255}));
  connect(coil.port_b1, sink.ports[1])
    annotation (Line(points={{10,0},{80,0},{80,40}}, color={0,127,255}));
  connect(fan.port_b, coil.port_a1)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoPipeHea;

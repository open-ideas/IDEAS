within IDEAS.Fluid.HeatExchangers.FanCoilUnits;
model FourPipe
  extends BaseClasses.PartialFanCoil(
   final configFCU=IDEAS.Fluid.HeatExchangers.FanCoilUnits.Types.FCUConfigurations.FourPipe, QZon(y=
          cooCoi.Q1_flow + heaCoi.Q1_flow));

  parameter Modelica.SIunits.MassFlowRate mWatHea_flow_nominal = heaCoi.Q_flow_nominal/cpWatHea_nominal/deltaTHea_nominal
  "Nominal mass flow of the heating coil";


  parameter Modelica.SIunits.MassFlowRate mWatCoo_flow_nominal = cooCoi.Q_flow_nominal/cpWatCoo_nominal/deltaTCoo_nominal
  "Nominal mass flow of the cooling coil";


  parameter Modelica.SIunits.TemperatureDifference deltaTCoo_nominal = 5
  "Nominal temperature difference in water side in the cooling coil"
  annotation (Dialog(group="Cooling coil parameters"));

  parameter Modelica.SIunits.TemperatureDifference deltaTHea_nominal = 10
  "Nominal temperature difference in water side in the heating coil"
  annotation (Dialog(group="Heating coil parameters"));

  parameter Modelica.SIunits.PressureDifference dpWatHea_nominal
    "Pressure difference on water side in the heating coil"
    annotation (Dialog(group="Heating coil parameters"));

  parameter Modelica.SIunits.PressureDifference dpWatCoo_nominal
    "Pressure difference on water side in the cooling coil"
    annotation (Dialog(group="Cooling coil parameters"));

  parameter Modelica.SIunits.HeatFlowRate QHea_flow_nominal "Nominal heat transfer of the heating coil"
    annotation (Dialog(group="Heating coil parameters"));

  parameter Modelica.SIunits.HeatFlowRate QCoo_flow_nominal "Nominal heat transfer of the cooling coil"
    annotation (Dialog(group="Cooling coil parameters"));


  parameter Modelica.SIunits.Temperature THea_a1_nominal
  "Nominal temperature of inlet air in the heating coil"
    annotation (Dialog(group="Heating coil parameters"));
  parameter Modelica.SIunits.Temperature THea_a2_nominal
  "Nominal temperature of water inlet in the heating coil"
    annotation (Dialog(group="Heating coil parameters"));

  parameter Modelica.SIunits.Temperature TCoo_a1_nominal
  "Nominal temperature of inlet air in the cooling coil"
    annotation (Dialog(group="Cooling coil parameters"));
  parameter Modelica.SIunits.Temperature TCoo_a2_nominal
  "Nominal temperature of water inlet in the cooling coil"
    annotation (Dialog(group="Cooling coil parameters"));

  parameter Boolean use_QHea_flow_nominal=true
  "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness"
    annotation (Dialog(group="Heating coil parameters"));
  parameter Real epsHea_nominal = 1
  "Nominal heat transfer effectiveness in the heating coil"
    annotation (Dialog(group="Heating coil parameters", enable=not use_QHea_flow_nominal));

  parameter Boolean use_QCoo_flow_nominal=true
  "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness"
    annotation (Dialog(group="Cooling coil parameters"));
  parameter Real epsCoo_nominal = 1
  "Nominal heat transfer effectiveness in the cooling coil"
    annotation (Dialog(group="Cooling coil parameters", enable=not use_QCoo_flow_nominal));



  package MediumHeaWater = IDEAS.Media.Water
  "Media in the water-side used in the heating coil";
  package MediumCooWater = IDEAS.Media.Water
  "Media in the water-side used in the cooling coil";


 IDEAS.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoi(
    redeclare package Medium1 = MediumAir,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    redeclare package Medium2 = MediumCooWater,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWatCoo_flow_nominal,
    dp2_nominal=dpWatCoo_nominal,
    use_Q_flow_nominal=use_QCoo_flow_nominal,
    Q_flow_nominal=QCoo_flow_nominal,
    T_a1_nominal=TCoo_a1_nominal,
    T_a2_nominal=TCoo_a2_nominal,
    r_nominal=cpAir_nominal/cpWatCoo_nominal,
    show_T=true,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dp1_nominal=0)
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));

 IDEAS.Fluid.HeatExchangers.WetCoilEffectivenessNTU heaCoi(
    redeclare package Medium1 = MediumAir,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    redeclare package Medium2 = MediumHeaWater,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWatHea_flow_nominal,
    dp2_nominal=dpWatHea_nominal,
    use_Q_flow_nominal=use_QHea_flow_nominal,
    Q_flow_nominal=QHea_flow_nominal,
    T_a1_nominal=THea_a1_nominal,
    T_a2_nominal=THea_a2_nominal,
    r_nominal=cpAir_nominal/cpWatHea_nominal,
    show_T=true,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dp1_nominal=0)
    annotation (Placement(transformation(extent={{50,-16},{70,4}})));

   Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package Medium =
        MediumCooWater)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)
    connected to the cooling coil"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package Medium =
        MediumCooWater)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1
    connected to the cooling coil"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));

 Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare final package Medium =
        MediumHeaWater)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2) 
    connected to the heating coil"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package Medium =
        MediumHeaWater)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)
    connected to the heating coil"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));

protected
   final parameter MediumHeaWater.ThermodynamicState staWatHea_nominal = MediumHeaWater.setState_pTX(
     T=heaCoi.T_a2_nominal,
     p=MediumHeaWater.p_default,
     X=MediumHeaWater.X_default[1:MediumHeaWater.nXi])
     "Nominal state for water-side in the heating coil";

   final parameter Modelica.SIunits.SpecificHeatCapacity cpWatHea_nominal = MediumHeaWater.specificHeatCapacityCp(staWatHea_nominal)
   "Nominal heat capacity of the water side in the heating coil";

   final parameter MediumCooWater.ThermodynamicState staWatCoo_nominal = MediumCooWater.setState_pTX(
     T=cooCoi.T_a2_nominal,
     p=MediumCooWater.p_default,
     X=MediumCooWater.X_default[1:MediumCooWater.nXi])
     "Nominal state for water-side in the cooling coil";

   final parameter Modelica.SIunits.SpecificHeatCapacity cpWatCoo_nominal = MediumCooWater.specificHeatCapacityCp(staWatCoo_nominal)
   "Nominal heat capacity of the water side in the cooling coil";



equation
  connect(port_a1, cooCoi.port_a2)
    annotation (Line(points={{20,-100},{20,-12},{10,-12}}, color={0,127,255}));
  connect(cooCoi.port_b2, port_b1) annotation (Line(points={{-10,-12},{-20,-12},
          {-20,-100}}, color={0,127,255}));
  connect(fan.port_b, cooCoi.port_a1)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  connect(port_a2, heaCoi.port_a2)
    annotation (Line(points={{80,-100},{80,-12},{70,-12}}, color={0,127,255}));
  connect(heaCoi.port_b2, port_b2)
    annotation (Line(points={{50,-12},{40,-12},{40,-100}}, color={0,127,255}));
  connect(heaCoi.port_b1, sink.ports[1])
    annotation (Line(points={{70,0},{80,0},{80,40}}, color={0,127,255}));
  connect(cooCoi.port_b1, heaCoi.port_a1)
    annotation (Line(points={{10,0},{50,0}}, color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
Model of a four-pipe fan-coil unit for heating
and cooling detached from the zone model. The
FCU has a heat port to be connected into the 
zone convective port.
</p>
</html>"));
end FourPipe;

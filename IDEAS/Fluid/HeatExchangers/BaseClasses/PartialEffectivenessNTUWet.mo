within IDEAS.Fluid.HeatExchangers.BaseClasses;
model PartialEffectivenessNTUWet
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU(
    C1_flow = abs(m1_flow)*cpEff1_internal,
    C2_flow = abs(m2_flow)*cpEff2_internal,
    Q1_flow = if T_in1 <= dewPoi2_internal then eps*QMax_flow else epsNonCon*QMax_flow_NonCon,
    Q2_flow = if T_in2 <= dewPoi1_internal then -eps*QMax_flow else -epsNonCon*QMax_flow_NonCon);



  //Effectiveness in non-condensation conditions
  Real epsNonCon(min=0, max=1)=
   IDEAS.Fluid.HeatExchangers.BaseClasses.epsilon_C(
    UA=UA,
    C1_flow=abs(m1_flow)*Medium1.specificHeatCapacityCp(state_a1_inflow),
    C2_flow=abs(m2_flow)*Medium2.specificHeatCapacityCp(state_a2_inflow),
    flowRegime=Integer(flowRegime),
    CMin_flow_nominal=CMin_flow_nominal,
    CMax_flow_nominal=CMax_flow_nominal,
    delta=delta)
   "Heat exchanger effectiveness for non-condensation conditions";

  Modelica.SIunits.ThermalConductance CMin_flow_NonCon(min=0) = min(abs(m1_flow)*Medium1.specificHeatCapacityCp(state_a1_inflow), abs(m2_flow)*Medium2.specificHeatCapacityCp(state_a2_inflow))
    "Minimum heat capacity flow rate";
  Modelica.SIunits.HeatFlowRate QMax_flow_NonCon = CMin_flow_NonCon*(T_in2 - T_in1)
    "Maximum heat flow rate into medium 1";

  //Psychometric analysis for Medium1
  Utilities.Psychrometrics.pW_X pWat1(
   p_in = port_a1.p,
   X_w = port_a1.Xi_outflow[1]) if hum1
  "Water vapour pressure of the zone, needed to compute the dew point"  annotation (Placement(transformation(extent={{-40,58},
            {-20,78}})));
  Utilities.Psychrometrics.TDewPoi_pW dewPoi1 if hum1
    "Dew point of the zone" annotation (Placement(transformation(extent={{-10,58},
            {10,78}})));
  Utilities.Psychrometrics.TWetBul_TDryBulXi wetBul1(
    redeclare package Medium = Medium1,
    TDryBul = T_in1,
    Xi = port_a1.Xi_outflow,
    p = port_a1.p) if                 hum1
      "Wet bulb temperature of the zone, needed to compute the heat capacity of the saturated ficticious fluid according to Braun-Lebrun model" annotation (Placement(transformation(extent={{20,28},
            {40,48}})));
  Utilities.Psychrometrics.X_pTphi x_pTphiSat1(
   p_in = port_a1.p,
   phi = 1) if                 hum1
    "Mass fraction for saturation conditions for Medium1, needed to compute the saturation enthalpy used in the Braun-Lebrun model"
     annotation (Placement(transformation(extent={{20,58},{40,78}})));

  //Psychometric analysis for Medium2
  Utilities.Psychrometrics.pW_X pWat2(
   p_in = port_a2.p,
   X_w = port_a2.Xi_outflow) if hum2
  "Water vapour pressure of the zone, needed to compute the dew point"  annotation (Placement(transformation(extent={{-40,-50},
            {-20,-30}})));
  Utilities.Psychrometrics.TDewPoi_pW dewPoi2 if hum2
    "Dew point of the zone"        annotation (Placement(transformation(extent={{-12,-50},
            {8,-30}})));
  Utilities.Psychrometrics.TWetBul_TDryBulXi wetBul2(
   redeclare package Medium = Medium2,
   TDryBul = T_in2,
   Xi = port_a2.Xi_outflow[1],
   p = port_a2.p) if hum2
      "Wet bulb temperature of the zone, needed to compute the heat capacity of the saturated ficticious fluid according to Braun-Lebrun model" annotation (Placement(transformation(extent={{20,-80},
            {40,-60}})));
  Utilities.Psychrometrics.X_pTphi x_pTphiSat2(
   p_in = port_a2.p,
   phi = 1) if hum2
    "Mass fraction for saturation conditions for Medium2, needed to compute the saturation enthalpy used in the Braun-Lebrun model"
  annotation (Placement(transformation(extent={{20,-50},{40,-30}})));

    //Check if condensation is possible in Mediums
protected
    parameter Boolean hum1 = Medium1.nX > 1  "Check if condensation is possible in Medium1";
    parameter Boolean hum2 = Medium2.nX > 1  "Check if condensation is possible in Medium2";

     final Modelica.SIunits.SpecificEnthalpy hSat1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= wetBul1.TWetBul,
      p=port_a1.p,
      X= x_pTphiSat1.X) if hum1
      "Enthalpy of the ficticious fluid from Braun-Lebrun model for Medium1";

     final Modelica.SIunits.SpecificEnthalpy hSat2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= wetBul2.TWetBul,
      p=port_a2.p,
      X= x_pTphiSat2.X) if hum2
      "Enthalpy of the ficticious fluid from Braun-Lebrun model for Medium2";

     final Modelica.SIunits.SpecificEnthalpy hCoi1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in1,
      p=port_a1.p,
      X=port_a1.Xi_outflow) if hum1 "Supply air enthalpy of Medium1";

     final Modelica.SIunits.SpecificEnthalpy hCoi2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in2,
      p=port_a2.p,
      X= port_a2.Xi_outflow) if hum2 "Supply air enthalpy of Medium1";

     final Modelica.SIunits.SpecificHeatCapacity cpSat1 = (hCoi1 - hSat1) / (wetBul1.TWetBul - dewPoi1.T) if hum1
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

     final Modelica.SIunits.SpecificHeatCapacity cpSat2 = (hCoi2 - hSat2) / (wetBul2.TWetBul - dewPoi2.T) if hum2
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

     final Modelica.Blocks.Interfaces.RealInput cpEff1 = if T_in2 <= dewPoi1.T then cpSat1 else Medium1.specificHeatCapacityCp(state_a1_inflow) if hum1
      "Heat capacity for Medium1 that accounts for condensation";

     final Modelica.Blocks.Interfaces.RealInput cpEff2 = if T_in1 <= dewPoi2.T then cpSat2 else Medium2.specificHeatCapacityCp(state_a2_inflow) if hum2
      "Heat capacity for Medium1 that accounts for condensation";

     final Modelica.Blocks.Interfaces.RealInput cpEff1_internal(final unit="J/(kg.K)")
      "Internal connector for effective heat capacity 1";

     final Modelica.Blocks.Interfaces.RealInput cpEff2_internal(final unit="J/(kg.K)")
      "Internal connector for effective heat capacity 1";

     final Modelica.Blocks.Interfaces.RealInput dewPoi1_internal(final unit="K")
       "Internal connector for dew point in Medium1";
     final Modelica.Blocks.Interfaces.RealInput dewPoi2_internal(final unit="K")
       "Internal connector for dew point in Medium2";
equation

  // Conditional connectors
  connect(cpEff1_internal, cpEff1);
  if not hum1 then
    cpEff1_internal = Medium1.specificHeatCapacityCp(state_a1_inflow);
  end if;

  connect(cpEff2_internal, cpEff2);
  if not hum2 then
    cpEff2_internal = Medium2.specificHeatCapacityCp(state_a2_inflow);
  end if;

  connect(dewPoi1_internal, dewPoi1.T);
  if not hum1 then
    dewPoi1_internal = -273.15;
  end if;

  connect(dewPoi2_internal, dewPoi2.T);
  if not hum2 then
    dewPoi2_internal = -273.15;
  end if;

   // Psychometric connections
  connect(dewPoi1.T,x_pTphiSat1.T) annotation (Line(points={{11,68},{18,68}},
                        color={0,0,127}));
  connect(pWat1.p_w,dewPoi1. p_w)
    annotation (Line(points={{-19,68},{-11,68}},   color={0,0,127}));
  connect(dewPoi2.T, x_pTphiSat2.T)
    annotation (Line(points={{9,-40},{18,-40}},  color={0,0,127}));
  connect(pWat2.p_w, dewPoi2.p_w)
    annotation (Line(points={{-19,-40},{-13,-40}},
                                                color={0,0,127}));


  annotation (Documentation(info="<html>
<p>
This model extends from
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.PartialEffectivenessNTU\">
IDEAS.Fluid.HeatExchangers.PartialEffectivenessNTU</a> 
but includes humidity condensation by using the Braun-Lebrun model.
</p>
<p>
This model does not account for moisture mass exchange.
</p>
<p>
The Braun-Lebrun model assumes that, under condensation conditions,
a ficticious perfect gas replaces the air whose enthalpy is defined
by the actual wet bulb temperature.
</p>
<p>
The specific heat capacity of the ficticious perfect gas is given by
the following relationship:
</p>
<p align=\"center\" style=\"font-style:italic;\">
  c<sub>p</sub> = (h<sub>sup</sub> - h<sub>sat</sub>) &frasl; 
  (T<sub>wb</sub> - T<sub>dp</sub>)<br/>
</p>
<p>
where
<i>h<sub>sup</sub></i> is the enthalpy of the supply air,
<i>h<sub>sat</sub></i> is the enthalpy of the air under saturation
conditions,
<i>T<sub>wb</sub></i> is the wet bulb temperature of the supply air,
<i>T<sub>dp</sub></i> is the dew point of the supply air.
</p>
<p>
The model includes all the psychometric components needed to compute the
necessary inputs to the Braun-Lebrun model.
</p>
</html>", revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>"));
end PartialEffectivenessNTUWet;

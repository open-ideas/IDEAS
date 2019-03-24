within IDEAS.Fluid.HeatExchangers.BaseClasses;
model PartialEffectivenessNTUWet2
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU;

  //Effectiveness in condensation conditions
  Modelica.Blocks.Interfaces.RealInput epsCon(min=0, max=1, final unit="1")=
   IDEAS.Fluid.HeatExchangers.BaseClasses.epsilon_C(
    UA=UA,
    C1_flow=abs(m1_flow)*cpEff1,
    C2_flow=abs(m2_flow)*cpEff2,
    flowRegime=Integer(flowRegime),
    CMin_flow_nominal=CMin_flow_nominal,
    CMax_flow_nominal=CMax_flow_nominal,
    delta=delta) if (hum1 or hum2)
   "Heat exchanger effectiveness for non-condensation conditions";

  Modelica.SIunits.ThermalConductance CMin_flow_Con(min=0) = min(abs(m1_flow)*cp1Con, abs(m2_flow)*cp2Con) if (hum1 or hum2)
    "Minimum heat capacity flow rate";
  Modelica.Blocks.Interfaces.RealInput QMax_flow_Con(final unit="W") = CMin_flow_Con*(T_in2 - T_in1) if (hum1 or hum2)
    "Maximum heat flow rate with condensation";
  Modelica.Blocks.Interfaces.RealInput QMax_flow_Con_internal(final unit="W")
    "Maximum heat flow rate with condensation";

  //Psychometric analysis for Medium1
  Modelica.SIunits.Pressure pWat1=
    IDEAS.Utilities.Psychrometrics.Functions.pW_X(
    X_w=port_a1.Xi_outflow[1], p=port_a1.p) if hum1
    "Water vapour pressure of Medium1, needed to compute the dew point";
  Modelica.Blocks.Interfaces.RealInput dewPoi1(final unit="K")=
     IDEAS.Utilities.Psychrometrics.Functions.TDewPoi_pW(p_w=pWat1) if hum1
     "Dew point of Medium1";

//    Modelica.SIunits.MassFraction xSat1 =  IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
//      pSat=IDEAS.Media.Air.saturationPressure(dewPoi1),
//      p=port_a1.p,
//      phi=1) if hum1
//       "Mass fraction for saturation conditions for Medium1, needed to compute the saturation enthalpy used in the Braun-Lebrun model";
  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulPhi wetBul1(
    redeclare package Medium = Medium1,
    TDryBul = T_out1,
    phi = 1,
    p = port_b1.p) if hum1
      "Wet bulb temperature of the zone, needed to compute the heat capacity of the saturated ficticious fluid according to Braun-Lebrun model";

 //Psychometric analysis for Medium2
  Modelica.SIunits.Pressure pWat2=
    IDEAS.Utilities.Psychrometrics.Functions.pW_X(
    X_w=port_a2.Xi_outflow[1], p=port_a2.p) if hum2
    "Water vapour pressure of Medium2, needed to compute the dew point";

  Modelica.Blocks.Interfaces.RealInput dewPoi2(final unit="K")=
     IDEAS.Utilities.Psychrometrics.Functions.TDewPoi_pW(p_w=pWat2) if hum2
     "Dew point of Medium2";

//   Modelica.SIunits.MassFraction xSat2 =  IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
//      pSat=IDEAS.Media.Air.saturationPressure(dewPoi2),
//      p=port_a2.p,
//      phi=1) if hum2
//       "Mass fraction for saturation conditions for Medium2, needed to compute the saturation enthalpy used in the Braun-Lebrun model";

  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulPhi wetBul2(
   redeclare package Medium = Medium2,
   TDryBul = T_out2,
   phi = 1,
   p = port_b2.p) if hum2
      "Wet bulb temperature of the zone, needed to compute the heat capacity of the saturated ficticious fluid according to Braun-Lebrun model";

    //Check if condensation is possible in Mediums
protected
    parameter Boolean hum1 = Medium1.nX > 1  "Check if condensation is possible in Medium1";
    parameter Boolean hum2 = Medium2.nX > 1  "Check if condensation is possible in Medium2";

//      final Modelica.SIunits.SpecificEnthalpy hSat1 = IDEAS.Media.Air.specificEnthalpy_pTX(
//       T= wetBul1.TWetBul,
//       p=port_a1.p,
//       X= {xSat1}) if hum1
//       "Enthalpy of the ficticious fluid from Braun-Lebrun model for Medium1";
//
//      final Modelica.SIunits.SpecificEnthalpy hSat2 = IDEAS.Media.Air.specificEnthalpy_pTX(
//       T= wetBul2.TWetBul,
//       p=port_a2.p,
//       X= {xSat2}) if hum2
//       "Enthalpy of the ficticious fluid from Braun-Lebrun model for Medium2";

     final Modelica.SIunits.SpecificEnthalpy hCoi_in1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in1,
      p=port_a1.p,
      X=port_a1.Xi_outflow) if hum1 "Supply air enthalpy of Medium1";

     final Modelica.SIunits.SpecificEnthalpy hCoi_in2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in2,
      p=port_a2.p,
      X= port_a2.Xi_outflow) if hum2 "Supply air enthalpy of Medium1";

     final Modelica.SIunits.SpecificEnthalpy hCoi_out1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_out1,
      p=port_b1.p,
      X=port_b1.Xi_outflow) if hum1 "Outlet air enthalpy of Medium1";

     final Modelica.SIunits.SpecificEnthalpy hCoi_out2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_out2,
      p=port_b2.p,
      X= port_b2.Xi_outflow) if hum2 "Outlet air enthalpy of Medium2";

     final Modelica.SIunits.SpecificHeatCapacity cp1Con = (hCoi_in1 - hCoi_out1) / (T_in1 - wetBul1.T) if hum1
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

     final Modelica.SIunits.SpecificHeatCapacity cp2Con = (hCoi_in2 - hCoi_out2) / (T_in2 - wetBul2.T) if hum2
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

      final Modelica.Blocks.Interfaces.RealInput cpEff1 = if T_in2 <= dewPoi1 then cp1Con else Medium1.specificHeatCapacityCp(state_a1_inflow) if hum1
       "Heat capacity for Medium1 that accounts for condensation";

      final Modelica.Blocks.Interfaces.RealInput cpEff2 = if T_in1 <= dewPoi2 then cp2Con else Medium2.specificHeatCapacityCp(state_a2_inflow) if hum2
       "Heat capacity for Medium1 that accounts for condensation";

      final Modelica.Blocks.Interfaces.RealInput cpEff1_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 1";

      final Modelica.Blocks.Interfaces.RealInput cpEff2_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 1";

      final Modelica.Blocks.Interfaces.RealInput dewPoi1_internal(final unit="K")
        "Internal connector for dew point in Medium1";
      final Modelica.Blocks.Interfaces.RealInput dewPoi2_internal(final unit="K")
        "Internal connector for dew point in Medium2";

      final Modelica.Blocks.Interfaces.RealInput eps_internal(final unit="1")
        "Internal connector for efficiency in Medium2";
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

  connect(dewPoi1_internal, dewPoi1);
   if  not hum1 then
     dewPoi1_internal = 0;
   end if;

 connect(dewPoi2_internal, dewPoi2);
   if not hum2 then
     dewPoi2_internal = 0;
   end if;

 connect(eps_internal, epsCon);
   if not (hum1 or hum2) then
       eps_internal = eps;
   end if;

 connect(QMax_flow_Con, QMax_flow_Con_internal);
    if not (hum1 or hum2) then
      QMax_flow_Con_internal = QMax_flow;
    end if;

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
<p>
SOURCE:
<i>
Lebrun, J., X. Ding, J.-P. Eppe, and M.Wasac. 1990. Cooling Coil Models to be used in
Transient and/or Wet Regimes. Theoritical Analysis and Experimental Validation. Proceedings
of SSB 1990. Liège:405-411
</i>
</p>
</html>", revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>"));
end PartialEffectivenessNTUWet2;

within IDEAS.Fluid.HeatExchangers.BaseClasses;
model PartialEffectivenessNTUWet3
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU(
    Q1_flow = if not hum1 then eps_internal*QMax_flow_Wet_internal else eps*QMax_flow,
    Q2_flow = if not hum2 then -eps_internal*QMax_flow_Wet_internal else -eps*QMax_flow);

  //Effectiveness in condensation conditions
  Modelica.Blocks.Interfaces.RealInput epsWet(min=0, max=1, final unit="1")=
   IDEAS.Fluid.HeatExchangers.BaseClasses.epsilon_C(
    UA=UA,
    C1_flow=abs(m1_flow)*cp1Real_internal,
    C2_flow=abs(m2_flow)*cp2Real_internal,
    flowRegime=Integer(flowRegime),
    CMin_flow_nominal=CMin_flow_nominal,
    CMax_flow_nominal=CMax_flow_nominal,
    delta=delta) if (hum1 or hum2)
   "Heat exchanger effectiveness for condensation conditions";

  Modelica.SIunits.ThermalConductance CMin_flow_Wet(min=0)=
   min(abs(m1_flow)*cp1Real_internal, abs(m2_flow)*cp2Real_internal) if  (hum1 or hum2)
    "Minimum heat capacity flow rate";
//   parameter Modelica.SIunits.ThermalConductance CMin_flow_nominal_Wet(min=0) = if (hum1 or hum2) then
//    min(m1_flow_nominal*cp1_nominal_wet, m2_flow_nominal*cp2_nominal_wet) else CMin_flow_nominal
//     "Minimum heat capacity flow rate";
//
//   parameter Modelica.SIunits.ThermalConductance UA_nominal_wet = if (hum1 or hum2) then NTU_nominal*CMin_flow_nominal_Wet else UA_nominal "UA value";
//
//   final parameter Medium2.ThermodynamicState sta1_saturated = if hum1 then Medium1.setState_pTX(
//      T=Medium1.T_default,
//      p=Medium1.p_default,
//      X={xSat1}) else sta1_default "Default state for medium 2";
//
//   final parameter Medium2.ThermodynamicState sta2_saturated = if hum2 then Medium2.setState_pTX(
//      T=Medium2.T_default,
//      p=Medium2.p_default,
//      X={xSat2}) else sta2_default "Default state for medium 2";
//
//   parameter Modelica.SIunits.MassFraction xSat1 "Saturated mass fraction of Medium 1";
//   parameter Modelica.SIunits.MassFraction xSat2 "Saturated mass fraction of medium 2";
//
//   parameter Modelica.SIunits.SpecificHeatCapacity cp1_nominal_wet = Medium1.specificHeatCapacityCp(sta1_saturated);
//   parameter Modelica.SIunits.SpecificHeatCapacity cp2_nominal_wet = Medium2.specificHeatCapacityCp(sta2_saturated);

  Modelica.Blocks.Interfaces.RealInput QMax_flow_Wet(final unit="W")=
   CMin_flow_Wet*(T_in2 - T_in1) if (hum1 or hum2)
    "Maximum heat flow rate with condensation";

  Modelica.Blocks.Interfaces.RealInput cp1Real = max(cp1Wet, Medium1.specificHeatCapacityCp(state_a1_inflow)) if hum1
       "Heat capacity for Medium1 that accounts for condensation";

  Modelica.Blocks.Interfaces.RealInput cp2Real = max(cp2Wet, Medium2.specificHeatCapacityCp(state_a2_inflow)) if hum2
       "Heat capacity for Medium1 that accounts for condensation";

  Modelica.SIunits.SpecificHeatCapacity cp1Wet = (hCoi_in1 - hCoi_out1) / (T_in1 - T_out1) if  hum1
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

  Modelica.SIunits.SpecificHeatCapacity cp2Wet = (hCoi_in2 - hCoi_out2) / (T_in2 - T_out2) if hum2
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

  Modelica.Blocks.Interfaces.RealInput dewPoi1(final unit="K")=
     IDEAS.Utilities.Psychrometrics.Functions.TDewPoi_pW(p_w=IDEAS.Utilities.Psychrometrics.Functions.pW_X(
    X_w=inStream(port_a1.Xi_outflow[1]), p=port_a1.p)) if hum1
     "Dew point of Medium1";

  Modelica.Blocks.Interfaces.RealInput dewPoi2(final unit="K")=
     IDEAS.Utilities.Psychrometrics.Functions.TDewPoi_pW(p_w=IDEAS.Utilities.Psychrometrics.Functions.pW_X(
    X_w=inStream(port_a2.Xi_outflow[1]), p=port_a2.p)) if hum2
     "Dew point of Medium2";

  Modelica.SIunits.Temperature T_out1=
  Q1_flow / (abs(m1_flow)*cp1Real_internal) + T_in1
    "Outlet temperature medium 1";

  Modelica.SIunits.Temperature T_out2=
  Q2_flow / (abs(m2_flow)*cp2Real_internal) + T_in2
    "Outlet temperature medium 2";

  Modelica.SIunits.MassFraction xOut1(start=0.01);
  Modelica.SIunits.MassFraction xOut2(start=0.01);

protected
    parameter Boolean hum1 = Medium1.nX > 1  "Check if condensation is possible in Medium1";
    parameter Boolean hum2 = Medium2.nX > 1  "Check if condensation is possible in Medium2";

    Modelica.SIunits.SpecificEnthalpy hCoi_in1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in1,
      p=port_a1.p,
      X=inStream(port_a1.Xi_outflow)) if hum1 "Supply air enthalpy of Medium1";

    Modelica.SIunits.SpecificEnthalpy hCoi_in2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in2,
      p=port_a2.p,
      X=inStream(port_a2.Xi_outflow)) if hum2 "Supply air enthalpy of Medium2";

    Modelica.SIunits.SpecificEnthalpy hCoi_out1 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_out1,
      p=port_b1.p,
      X={xOut1}) if hum1 "Outlet air enthalpy of Medium1";

    Modelica.SIunits.SpecificEnthalpy hCoi_out2 = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_out2,
      p=port_b2.p,
      X={xOut2}) if hum2 "Outlet air enthalpy of Medium2";

    final Modelica.Blocks.Interfaces.RealInput cp1Real_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 1";
    final Modelica.Blocks.Interfaces.RealInput cp2Real_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 2";
    final Modelica.Blocks.Interfaces.RealInput dewPoi1_internal(final unit="K")
        "Internal connector for dew point in Medium1";
    final Modelica.Blocks.Interfaces.RealInput dewPoi2_internal(final unit="K")
        "Internal connector for dew point in Medium2";
    final Modelica.Blocks.Interfaces.RealInput eps_internal(final unit="1")
        "Internal connector for efficiency in Medium2";
    final Modelica.Blocks.Interfaces.RealInput QMax_flow_Wet_internal(final unit="W")
    "Maximum heat flow rate with condensation";

// initial equation
//   if hum1 then
//     1 =  IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=Medium1.p_default, T=Medium1.T_default, X_w= xSat1);
//   else
//     xSat1=0;
//   end if;
//   if hum2 then
//   1 = IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=Medium2.p_default, T=Medium2.T_default, X_w = xSat2);
//   else
//     xSat2 = 0;
//   end if;

equation

  if hum1 then
    1 =  IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=port_b1.p, T=T_out1, X_w= xOut1);
  else
    xOut1=0;
  end if;
  if hum2 then
  1 = IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=port_b2.p, T=T_out2, X_w = xOut2);
  else
    xOut2 = 0;
  end if;

   connect(cp1Real_internal, cp1Real);

  // Conditional connectors
   if not hum1 then
     cp1Real_internal = Medium1.specificHeatCapacityCp(state_a1_inflow);
   end if;

   connect(cp2Real_internal, cp2Real);
   if not hum2 then
     cp2Real_internal = Medium2.specificHeatCapacityCp(state_a2_inflow);
   end if;

  connect(dewPoi1_internal, dewPoi1);
   if  not hum1 then
     dewPoi1_internal = 0;
   end if;

 connect(dewPoi2_internal, dewPoi2);
   if not hum2 then
     dewPoi2_internal = 0;
   end if;

 connect(eps_internal, epsWet);
   if not (hum1 or hum2) then
       eps_internal = eps;
   end if;

 connect(QMax_flow_Wet_internal, QMax_flow_Wet);
   if not (hum1 or hum2) then
       QMax_flow_Wet_internal = QMax_flow;
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
end PartialEffectivenessNTUWet3;

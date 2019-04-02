within IDEAS.Fluid.HeatExchangers.BaseClasses;
model PartialEffectivenessNTUWet3
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU(
    sensibleOnly1=false,
    sensibleOnly2=false,
    Q1_flow = if hum1 then eps_internal*QMax_flow_Wet_internal else eps*QMax_flow,
    Q2_flow = -Q1_flow,
    mWat1_flow=Q1_flow*(cp1Real-Medium1.specificHeatCapacityCp(state_a1_inflow))/cp1Real/lambda);


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
  Real fraLat = QLat1/Q1_flow;
  Real QLat1 = mWat1_flow*2260000 "Latent heat load";

  Modelica.SIunits.ThermalConductance CMin_flow_Wet(min=0)=
   min(abs(m1_flow)*cp1Real_internal, abs(m2_flow)*cp2Real_internal) if  (hum1 or hum2)
    "Minimum heat capacity flow rate";

  Modelica.Blocks.Interfaces.RealInput QMax_flow_Wet(final unit="W")=
   CMin_flow_Wet*(T_in2 - T_in1) if (hum1 or hum2)
    "Maximum heat flow rate with condensation";

  Modelica.Blocks.Interfaces.RealInput cp1Real = max(cp1Wet, Medium1.specificHeatCapacityCp(state_a1_inflow)) if hum1
       "Heat capacity for Medium1 that accounts for condensation";

  Modelica.Blocks.Interfaces.RealInput cp2Real = max(cp2Wet, Medium2.specificHeatCapacityCp(state_a2_inflow)) if hum2
       "Heat capacity for Medium1 that accounts for condensation";

  Modelica.SIunits.SpecificHeatCapacity cp1Wet = (hCoi_in1 - hCoi_outMax) / (T_in1 - T_in2) if  hum1
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

  Modelica.SIunits.SpecificHeatCapacity cp2Wet = (hCoi_in2 - hCoi_out2) / (T_in2 - T_out2) if hum2
      "Heat capacity used in the ficticious fluid when condensation occurs in Medium1, according to Braun-Lebrun model";

  Modelica.SIunits.Temperature T_out1=
    Medium1.temperature(Medium1.setState_phX(port_b1.p, port_b1.h_outflow, port_b1.Xi_outflow))
    "Outlet temperature medium 1";

  Modelica.SIunits.Temperature T_out2=
  Q2_flow / (abs(m2_flow)*cp2Real_internal) + T_in2
    "Outlet temperature medium 2";

  Modelica.SIunits.MassFraction xOut1;
  Modelica.SIunits.MassFraction xSat;
  Modelica.SIunits.MassFraction xOut2(start=0.01);

protected
  constant Modelica.SIunits.SpecificEnthalpy lambda = 2453500
    "Heat of evaporation of water at 20 degrees Celsius, source: Engineering Toolbox";
    parameter Boolean hum1 = Medium1.nX > 1  "Check if condensation is possible in Medium1";
    parameter Boolean hum2 = Medium2.nX > 1  "Check if condensation is possible in Medium2";

    Modelica.SIunits.SpecificEnthalpy hCoi_in1 = inStream(port_a1.h_outflow) if hum1 "Supply air enthalpy of Medium1";

    Modelica.SIunits.SpecificEnthalpy hCoi_in2 = inStream(port_a2.h_outflow) if hum2 "Supply air enthalpy of Medium2";

    Modelica.SIunits.SpecificEnthalpy hCoi_out1 = port_b1.h_outflow if hum1 "Outlet air enthalpy of Medium1";

    Real hCoi_outMax = IDEAS.Media.Air.specificEnthalpy_pTX(
      T= T_in2,
      p=port_b1.p,
      X={min(xSat,inStream(port_a1.Xi_outflow[1]))}) if hum1 "Outlet air enthalpy of Medium1";

    Modelica.SIunits.SpecificEnthalpy hCoi_out2 = port_b2.h_outflow if hum2 "Outlet air enthalpy of Medium2";

    final Modelica.Blocks.Interfaces.RealInput cp1Real_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 1";
    final Modelica.Blocks.Interfaces.RealInput cp2Real_internal(final unit="J/(kg.K)")
       "Internal connector for effective heat capacity 2";

    final Modelica.Blocks.Interfaces.RealInput eps_internal(final unit="1")
        "Internal connector for efficiency in Medium2";
    final Modelica.Blocks.Interfaces.RealInput QMax_flow_Wet_internal(final unit="W")
    "Maximum heat flow rate with condensation";


equation
  1 = IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=port_b1.p, T=T_in2, X_w = xSat);
  1 = IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(p=port_b1.p, T=T_out1, X_w = xOut1);
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

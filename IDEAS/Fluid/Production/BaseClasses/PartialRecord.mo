within IDEAS.Fluid.Production.BaseClasses;
partial record PartialRecord
  extends Modelica.Icons.Record;

   parameter Modelica.SIunits.Power QNomRef=1000;
   parameter Real etaRef=1;

   parameter Modelica.SIunits.Temperature TMax = 273.15+80
    "Maximum temperature of condensor or boiler";
   parameter Modelica.SIunits.Temperature TMin = 273.15+20
    "Minimum temperature of evaporator or boiler";

   parameter Boolean useTin2=true;
   parameter Boolean useTout2=true;

   parameter Boolean useMassFlow1=true;
   parameter Boolean useTin1=true;
   parameter Boolean useTout1=true;

   parameter Modelica.SIunits.Mass m1(min=Modelica.Constants.eps) = 10
    "Fluid content of primary circuit (condensor for heatpumps)";

   parameter Modelica.SIunits.Mass m2(min=Modelica.Constants.eps) = 10
    "Fluid content of secondary circuit (evaporator for heatpumps)";

   parameter Modelica.SIunits.MassFlowRate m1_flow_nominal = 1
    "Mass flow rate of the primary circuit (condensor for heatpumps) for calculation of the pressure drop";
   parameter Modelica.SIunits.MassFlowRate m2_flow_nominal = 1
    "Mass flow rate of the secondary circuit (evaporator for heatpumps) for calculation of the pressure drop";

   parameter Modelica.SIunits.Pressure dp1_nominal = 1000
    "Pressure drop of the primary circuit (condensor for heatpumps) at nominal mass flow rate if used for a water water heat pump, otherwise unused";
   parameter Modelica.SIunits.Pressure dp2_nominal =  1000
    "Pressure drop of the secondary circuit (evaporator for heatpumps) at nominal mass flow rate";
end PartialRecord;

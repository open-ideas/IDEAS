within IDEAS.Fluid.Production.BaseClasses;
partial record PartialRecord
  extends Modelica.Icons.Record;

   parameter Modelica.SIunits.Power QNomRef=1000;
   parameter Real etaRef=1;

   parameter Modelica.SIunits.Temperature TMax = 273.15+80
    "Maximum temperature of condensor or boiler";
   parameter Modelica.SIunits.Temperature TMin = 273.15+20
    "Minimum temperature of evaporator or boiler";

   parameter Boolean useTinPrimary=true;
   parameter Boolean useToutPrimary=true;
   parameter Boolean useMassFlowPrimary=true;

   parameter Boolean useTinSecondary=true;
   parameter Boolean useToutSecondary=true;

   parameter Modelica.SIunits.Mass m1(min=Modelica.Constants.eps) = 10
    "Fluid content of the evaporator if used for a water water heat pump, otherwise unused";

   parameter Modelica.SIunits.Mass m2(min=Modelica.Constants.eps) = 10
    "Fluid content of the condensor or the boiler fluid content";

   parameter Modelica.SIunits.MassFlowRate m1_flow_nominal = 1
    "Mass flow rate of the brine (evaporator) for calculation of the pressure drop if used for a water water heat pump, otherwise unused";
   parameter Modelica.SIunits.MassFlowRate m2_flow_nominal = 1
    "Mass flow rate of the fluid (condensor) or of boiler for calculation of the pressure drop";

   parameter Modelica.SIunits.Pressure dp1_nominal = 1000
    "Pressure drop of the evaporator at nominal mass flow rate if used for a water water heat pump, otherwise unused";
   parameter Modelica.SIunits.Pressure dp2_nominal =  1000
    "Pressure drop of the condensor or boiler at nominal mass flow rate";
end PartialRecord;

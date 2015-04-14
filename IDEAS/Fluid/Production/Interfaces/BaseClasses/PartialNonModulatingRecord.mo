within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial record PartialNonModulatingRecord
  extends PartialRecord;

  parameter Real[:,:] heat = [[0]];
  parameter Real[:,:] power = [[0]];
  parameter Modelica.SIunits.Mass m1(min=Modelica.Constants.eps)
    "Fluid content of the evaporator";

  parameter Modelica.SIunits.Mass m2(min=Modelica.Constants.eps)
    "Fluid content of the condensor";

  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal
    "Mass flow rate of the brine (evaporator) for calculation of the pressure drop";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal
    "Mass flow rate of the fluid (condensor) for calculation of the pressure drop";

  parameter Modelica.SIunits.Pressure dp1_nominal
    "Pressure drop of the evaporator at nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp2_nominal
    "Pressure drop of the condensor at nominal mass flow rate";

  parameter Modelica.SIunits.ThermalConductance G
    "Thermal conductivity between the evaporator and the environment";
  parameter Modelica.SIunits.Power P_the_nominal
    "nominal thermal power of the heat pump";

  parameter Modelica.SIunits.Temperature T_evap_min = 273.15
    "Temperature protection threshold evaporator";
  parameter Modelica.SIunits.Temperature T_cond_max = 273.15 + 60
    "Temperature protection threshold condensor";
end PartialNonModulatingRecord;

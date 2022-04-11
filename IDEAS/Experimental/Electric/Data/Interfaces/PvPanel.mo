within IDEAS.Experimental.Electric.Data.Interfaces;
record PvPanel
  "Describes a Photovoltaic panel by its 5 main parameters and some extra parameter"
  extends Modelica.Icons.MaterialProperty;

  //The 5 main parameters
  parameter Modelica.Units.SI.ElectricCurrent I_phr
    "Light current under reference conditions";
  parameter Modelica.Units.SI.ElectricCurrent I_or
    "Diode reverse saturation current under reference conditions";
  parameter Modelica.Units.SI.Resistance R_sr
    "Series resistance under reference conditions";
  parameter Modelica.Units.SI.Resistance R_shr
    "Shunt resistance under reference conditions";
  parameter Modelica.Units.SI.ElectricPotential V_tr
    "modified ideality factor under reference conditions";

  //Other parameters
  parameter Modelica.Units.SI.ElectricCurrent I_scr
    "Short circuit current under reference conditions";
  parameter Modelica.Units.SI.ElectricPotential V_ocr
    "Open circuit voltage under reference conditions";
  parameter Modelica.Units.SI.ElectricCurrent I_mpr
    "Maximum power point current under reference conditions";
  parameter Modelica.Units.SI.ElectricPotential V_mpr
    "Maximum power point voltage under reference conditions";
  parameter Modelica.Units.SI.LinearTemperatureCoefficient kV
    "Temperature coefficient for open circuit voltage";
  parameter Modelica.Units.SI.LinearTemperatureCoefficient kI
    "Temperature coefficient for short circuit current";
  parameter Modelica.Units.SI.Temperature T_ref
    "Reference temperature in Kelvin";

end PvPanel;

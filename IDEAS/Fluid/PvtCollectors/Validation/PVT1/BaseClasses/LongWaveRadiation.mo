within IDEAS.Fluid.PvtCollectors.Validation.PVT1.BaseClasses;
model LongWaveRadiation
  extends Modelica.Blocks.Icons.Block;

  // Real Inputs
  Modelica.Blocks.Interfaces.RealInput Tamb(
    quantity="AmbientTemperature",
    unit="degC",
    displayUnit="degC") "Ambient temperature [°C]"
    annotation (Placement(transformation(extent={{-140,-108},{-100,-68}})));

  Modelica.Blocks.Interfaces.RealInput rH(
    quantity="RelativeHumidity",
    unit="percentage",
    displayUnit="frac") "Relative Humidity [%]"
    annotation (Placement(transformation(extent={{-140,-64},{-100,-24}}),
        iconTransformation(extent={{-140,-64},{-100,-24}})));

  Modelica.Blocks.Interfaces.RealInput patm(
    quantity="AtmosphericPressure",
    unit="bar",
    displayUnit="bar") "Atmospheric pressure [atm]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealInput Edif_h(
    quantity="DiffuseRadiationCollector",
    unit="W/m2",
    displayUnit="kJ/hr.m²") "Diffuse horizontal irradiation [W/m2]"
    annotation (Placement(transformation(extent={{-140,24},{-100,64}}),
        iconTransformation(extent={{-140,24},{-100,64}})));

  Modelica.Blocks.Interfaces.RealInput Eglobh_h(
    quantity="TotalRadiationCollector",
    unit="W/m2",
    displayUnit="kJ/hr.m²") "global horizontal irradiation [W/m2]"
    annotation (Placement(transformation(extent={{-140,68},{-100,108}}),
        iconTransformation(extent={{-140,68},{-100,108}})));

  // Constants
  constant Real sigma = 5.67e-8 "Stefan-Boltzmann constant [W/m²K⁴]";
  constant Real tiltAngle = 45 * pi / 180;
  constant Real pi = Modelica.Constants.pi "Pi constant";
  constant Real epsGro = 0.95 "ground emissivity [-]";

  // Constants for dew point calculation using Buck's equation [Buck, 1981]
  constant Real aBuck = 243.5 "Buck constant for dew point [°C]";
  constant Real bBuck = 17.67 "Buck constant for dew point";

  // Intermediate Variables
  Real Tdew "Dew point temperature [°C]";
  Real epsSky "Clear sky emissivity [-]";

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput lonRad(
    quantity="LongwaveRadiation",
    unit="W/m2",
    displayUnit="W/m2") "Longwave radiation [W/m²]"
    annotation (Placement(transformation(extent={{100,-16},{134,18}}),
        iconTransformation(extent={{100,-16},{134,18}})));

equation
   // Calculate Dew Point Temperature (Tdew) using Buck's equation [Buck, 1981]
  Tdew = (aBuck * (bBuck * (Tamb - 273.15) / (aBuck + (Tamb - 273.15)) + log(rH/100))) /
         (bBuck - (bBuck * (Tamb - 273.15) / (aBuck + (Tamb - 273.15)) + log(rH/100)));

  // Clear Sky Emissivity (epsEmi)
  epsSky = 0.711 + 0.56 * (Tdew/100) + 0.73 * (Tdew/100)^2;

  // Calculate Longwave Radiation (lonRad) using Tview and the Stefan-Boltzmann Law
  lonRad = sigma*Tamb^4*((epsSky*(1 + cos(tiltAngle)) / 2) + (epsGro*(1 - cos(tiltAngle)) / 2));

end LongWaveRadiation;

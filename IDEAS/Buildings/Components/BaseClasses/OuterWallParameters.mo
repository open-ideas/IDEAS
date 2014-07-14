within IDEAS.Buildings.Components.BaseClasses;
record OuterWallParameters
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  parameter Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  parameter Modelica.SIunits.Angle lat(displayUnit="degree");
  parameter Modelica.SIunits.Area A;
end OuterWallParameters;

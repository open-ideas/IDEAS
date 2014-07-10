within IDEAS.Buildings.Components.Interfaces;
expandable connector RadSolBus
  "Bus to transfer properties and signals of RadSol"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  Modelica.SIunits.Angle lat(displayUnit="degree");
  Modelica.SIunits.Area A;
  Real solDir;
  Real solDif;
//   Real angInc "Angle of incidence";
//   Real angZen "Angle of incidence";
//   Real angHou "Angle of incidence";

end RadSolBus;

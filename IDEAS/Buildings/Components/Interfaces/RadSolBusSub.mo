within IDEAS.Buildings.Components.Interfaces;
expandable connector RadSolBusSub
  "Bus to transfer properties and signals of RadSol"
  extends Modelica.Icons.SignalSubBus;

  Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  Modelica.SIunits.Angle lat(displayUnit="degree");
  Modelica.SIunits.Area A;

end RadSolBusSub;

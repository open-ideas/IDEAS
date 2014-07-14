within IDEAS.Buildings.Components.Interfaces;
expandable connector winSigBusSub
  "Bus to transfer properties and signals of the window"
  extends Modelica.Icons.SignalSubBus;
  parameter Integer nLay;

  Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  Modelica.SIunits.Angle lat(displayUnit="degree");
  Modelica.SIunits.Area A;

  Real frac "Area fraction of the window frame";

  Modelica.SIunits.Temperature[nLay] TISolAbsSig;

  Modelica.SIunits.Temperature TISolDirSig;

  Modelica.SIunits.Temperature TISolDifSig;
end winSigBusSub;

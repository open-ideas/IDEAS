within IDEAS.Buildings.Components.Interfaces;
expandable connector winSigBus
  "Bus to transfer properties and signals of the window"
  extends Modelica.Icons.SignalBus;

  parameter Integer nLay(min=1) "number of layers";

  Modelica.SIunits.Temperature[nLay] TISolAbsSig;
  Modelica.SIunits.HeatFlowRate[nLay] QISolAbsSig;

  Modelica.SIunits.Temperature TISolDirSig;
  Modelica.SIunits.HeatFlowRate QISolDirSig;

  Modelica.SIunits.Temperature TISolDifSig;
  Modelica.SIunits.HeatFlowRate QISolDifSig;

  Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  Modelica.SIunits.Angle lat(displayUnit="degree");
  Modelica.SIunits.Area A;

  Real frac "Area fraction of the window frame";

end winSigBus;

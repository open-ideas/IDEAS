within IDEAS.Buildings.Components.Interfaces;
expandable connector heatToSigWindBus
  "Bus to transfer properties and signals of RadSol"
  extends Modelica.Icons.SignalBus;

  Integer nLay;
  Modelica.SIunits.Temperature[nLay] TISolAbsSig_a;
  Modelica.SIunits.HeatFlowRate[nLay] QISolAbsSig_a;

end heatToSigWindBus;

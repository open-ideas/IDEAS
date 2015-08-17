within IDEAS.Buildings.Components.Interfaces;
expandable connector SolBus
  "Bus containing solar radiation for various incidence angles"
  extends Modelica.Icons.SignalBus;

  Real iSolDir(start=100) annotation ();
  Real iSolDif(start=100) annotation ();

  Modelica.SIunits.Temperature Tenv(start=293.15) annotation ();

end SolBus;

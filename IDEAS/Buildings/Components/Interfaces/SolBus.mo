within IDEAS.Buildings.Components.Interfaces;
expandable connector SolBus
  "Bus containing solar radiation for various incidence angles"
  extends Modelica.Icons.SignalBus;
  parameter Boolean addAngles = true;

  Real iSolDir(start=100) annotation ();
  Real iSolDif(start=100) annotation ();

  Modelica.SIunits.Angle angZen(start=1) if addAngles annotation ();
  Modelica.SIunits.Angle angAzi(start=1) if addAngles annotation ();
  Modelica.SIunits.Angle angInc(start=1) if addAngles annotation ();

  Modelica.SIunits.Temperature Tenv(start=293.15) annotation ();

end SolBus;

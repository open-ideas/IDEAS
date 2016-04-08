within IDEAS.Buildings.Data.Interfaces;
record Screen "Solar screen"
  extends Modelica.Icons.Record;
  parameter Real As(min=0, max=1) "Solar licht absoprtion";
  parameter Real Rs(min=0, max=1) "Solar licht reflection";
  parameter Real Ts(min=0, max=1) "Solar licht transmission";
  parameter Real Tv(min=0, max=1) "Visible licht transmission";
  parameter Real G(min=0, max=1) "Solar factor";

end Screen;

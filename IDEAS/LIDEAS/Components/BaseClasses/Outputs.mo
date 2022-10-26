within IDEAS.LIDEAS.Components.BaseClasses;
connector Outputs
  extends Modelica.Icons.SignalBus;
  parameter Integer nZones=2;
  Modelica.Units.SI.Temperature TSensor[nZones];
end Outputs;

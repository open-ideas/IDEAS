within IDEAS.LIDEAS.Components.BaseClasses;
connector Prescribed
  extends Modelica.Icons.SignalBus;
  parameter Integer nZones=2;
  Modelica.Units.SI.HeatFlowRate QCon[nZones](each start=100);
  Modelica.Units.SI.HeatFlowRate QRad[nZones](each start=100);
end Prescribed;

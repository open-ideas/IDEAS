within IDEAS.LIDEAS.Components.BaseClasses;
connector Inputs
  extends Modelica.Icons.SignalBus;
  parameter Integer nZones=2;
  parameter Integer nEmb=1;
  Modelica.Units.SI.HeatFlowRate QCon[nZones](each start=100);
  Modelica.Units.SI.HeatFlowRate QRad[nZones](each start=100);
  Modelica.Units.SI.HeatFlowRate QEmb[nEmb](each start=100);
end Inputs;

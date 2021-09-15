within IDEAS.Buildings.Validation.Interfaces;
model BesTestCase
  Modelica.Units.SI.Power PHea=min(heatingSystem.heatPortCon[1].Q_flow, 0);
  Modelica.Units.SI.Power PCoo=max(heatingSystem.heatPortCon[1].Q_flow, 0);
  Modelica.Units.SI.Temperature TAir=Modelica.Units.Conversions.to_degC(
      building.heatPortCon[1].T);
  extends IDEAS.Templates.Interfaces.Building;
end BesTestCase;

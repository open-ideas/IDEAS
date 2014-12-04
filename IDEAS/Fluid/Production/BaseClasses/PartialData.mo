within IDEAS.Fluid.Production.BaseClasses;
partial record PartialData "Partial for every production data file"
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Power QNomRef(min=0)=1000
    "Nominal power from which the power data are used in this model";
  parameter Real etaRef(min=0, max=1)=1
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5))=20
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

end PartialData;

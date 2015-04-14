within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial record PartialRecord
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Power QNomRef=1000;

  parameter Modelica.SIunits.Temperature TMax = 273.15+80;
  parameter Modelica.SIunits.Temperature TMin = 273.15+20;

  parameter Boolean useTinPrimary=false;
  parameter Boolean useToutPrimary=false;

  parameter Boolean useTinSecondary=false;
  parameter Boolean useToutSecondary=false;
  parameter Boolean useMassFlowSecondary=false;

end PartialRecord;

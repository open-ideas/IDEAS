within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial record PartialRecord
  extends Modelica.Icons.Record;

   parameter Modelica.SIunits.Power QNomRef=1000;
   parameter Real etaRef=1;

   parameter Modelica.SIunits.Temperature TMax = 273.15+80;
   parameter Modelica.SIunits.Temperature TMin = 273.15+20;

   parameter Boolean useTinPrimary=true;
   parameter Boolean useToutPrimary=true;
   parameter Boolean useMassFlowPrimary=true;

   parameter Boolean useTinSecondary=true;
   parameter Boolean useToutSecondary=true;

end PartialRecord;

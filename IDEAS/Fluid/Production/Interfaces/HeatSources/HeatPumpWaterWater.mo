within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpWaterWater

  //Extensions
  extends IDEAS.Fluid.Production.Interfaces.BaseClasses.Partial2DHeatSource(
     redeclare replaceable Data.VitoCal300GBWS301dotA08 data,
    tableInput1(y=ToutPrimary),
    tableInput2(y=TinSecondary));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

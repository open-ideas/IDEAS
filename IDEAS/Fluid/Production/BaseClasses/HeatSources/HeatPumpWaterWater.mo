within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model HeatPumpWaterWater
  import IDEAS;

  //Extensions
  extends IDEAS.Fluid.Production.Interfaces.BaseClasses.Partial2DHeatSource(
    redeclare replaceable IDEAS.Fluid.Production.Data.VitoCal300GBWS301dotA08
      data,
    tableInput1(y=TinPrimary),
    tableInput2(y=ToutSecondary));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

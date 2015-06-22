within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model HeatPumpAirWater
  import IDEAS;
  //Extensions
  extends IDEAS.Fluid.Production.Interfaces.BaseClasses.Partial3DHeatSource(
      tableInput1(y=TinPrimary-273.15),
      tableInput2(y=ToutSecondary-273.15),
    redeclare IDEAS.Fluid.Production.Data.HeatPumpAirWaterData data);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpAirWater;

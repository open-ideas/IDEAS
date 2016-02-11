within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpAirWater
  //Extensions
  extends IDEAS.Fluid.Production.Interfaces.BaseClasses.Partial3DHeatSource(
      tableInput1(y=TinPrimary-273.15),
      tableInput2(y=ToutSecondary-273.15),
    redeclare Data.HeatPumpAirWaterData data);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpAirWater;

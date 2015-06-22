within IDEAS.Fluid.Production;
model HeatPumpWaterWater
  //Extensions
  extends Interfaces.PartialHeaterFourPort(
    redeclare BaseClasses.HeatSources.HeatPumpWaterWater heatSource(
      redeclare IDEAS.Fluid.Production.Data.VitoCal300GBWS301dotA08 data,
      useMassFlowPrimary=false,
      useTinPrimary=true,
      useTinSecondary=false,
      useToutPrimary=false),
    vol1(V=heatSource.data.m1/rho1_nominal),
    vol2(V=heatSource.data.m2/rho2_nominal));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

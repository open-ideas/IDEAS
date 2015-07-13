within IDEAS.Fluid.Production;
model HeatPumpWaterWater
  //Extensions
  extends Interfaces.PartialHeaterFourPort(
    redeclare HeatSources.HeatPumpWaterWater heatSource(
      redeclare IDEAS.Fluid.Production.Data.VitoCal300GBWS301dotA08 data,
      useMassFlow2=false,
      useTin2=true,
      useTin1=false,
      useTout2=false),
    vol1(V=heatSource.data.m1/rho1_nominal),
    vol2(V=heatSource.data.m2/rho2_nominal));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

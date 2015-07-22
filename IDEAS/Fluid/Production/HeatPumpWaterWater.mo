within IDEAS.Fluid.Production;
model HeatPumpWaterWater
  //Extensions
  extends Interfaces.PartialHeaterFourPort(
    m2 = heatSource.data.m2,
    m1 = heatSource.data.m1,
    QNom = heatSource.data.QNomRef,
    m1_flow_nominal = heatSource.data.m1_flow_nominal,
    m2_flow_nominal = heatSource.data.m2_flow_nominal,
    dp1_nominal = heatSource.data.dp1_nominal,
    dp2_nominal = heatSource.data.dp2_nominal,
    redeclare HeatSources.HeatPumpWaterWater heatSource(
      useMassFlow1=false,
      useTin1=true,
      useTin2=false,
      useTout1=false));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

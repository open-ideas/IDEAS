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
      useTout1=false,
      reversible = reversible,
      EER = EER));
  parameter Real EER=6;
equation
  connect(rev, heatSource.rev) annotation (Line(points={{60,108},{60,108},{60,64},
          {60,64},{60,29},{-4,29}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end HeatPumpWaterWater;

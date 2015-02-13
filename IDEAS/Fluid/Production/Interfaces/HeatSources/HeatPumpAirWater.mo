within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpAirWater
  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingHeatSource(
    calculatePower=false);

equation
  for i in 1:n loop
    Heat[i].u1 = TinPrimary - 273.15;
    Heat[i].u2 = TinSecondary - 273.15;
  end for;

  modulator.max = Heat[end].y * 1000;
  heatPort.Q_flow = -1000*interpolator.y * scaler - QLossesToCompensate;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpAirWater;

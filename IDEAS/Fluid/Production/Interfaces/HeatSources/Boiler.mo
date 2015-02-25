within IDEAS.Fluid.Production.Interfaces.HeatSources;
model Boiler
  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingHeatSource(
      calculatePower=false);

  //Parameters
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

equation
  for i in 1:n loop
    Heat[i].u1 = TinPrimary - 273.15;
    Heat[i].u2 = massFlowPrimary*scaler*kgps2lph;
  end for;

  modulator.max = Heat[end].y * QNom;
  heatPort.Q_flow = -QNom*interpolator.y * scaler - QLossesToCompensate;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Boiler;

within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpWaterWater

  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialNonModulatingHeatSource(
    heatPump=true,
    calculatePower=true);

  //Variables
  Real cop;
  Modelica.SIunits.Power PEl;
  Modelica.SIunits.Power PEvap;
  Modelica.SIunits.Power PCond;

equation
  cop = Heat.y;
  PEl = Power.y*scaler;
  PEvap = PEl*(cop - 1);
  PCond = PEl*cop;

  heatPort.Q_flow = -PCond - QLossesToCompensate;
  heatPortE.Q_flow = -PEvap - QLossesToCompensate;

  connect(TinPrimary, Heat.u1) annotation (Line(
      points={{-80,108},{-80,16},{-22,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary, Power.u1) annotation (Line(
      points={{-80,108},{-80,-24},{-2,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinSecondary, Power.u2) annotation (Line(
      points={{-80,-110},{-80,-52},{-60,-52},{-60,-36},{-2,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinSecondary, Heat.u2) annotation (Line(
      points={{-80,-110},{-80,-52},{-60,-52},{-60,4},{-22,4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

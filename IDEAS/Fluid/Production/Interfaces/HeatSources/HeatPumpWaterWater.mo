within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpWaterWater

  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialNonModulatingHeatSource(
    QNomRef=8000,
    heatPump=true,
    calculatePower=true,
    Heat(table = {{0,268.15,273.15,275.15,283.15,288.15},{308.15,4.02,4.65,4.94,6.13,
        6.87},{318.15,3.02,3.45,3.69,4.66,5.27},{328.15,0,2.65,2.82,3.52,3.96},
        {333.15,0,0,2.44,3.06,3.45}}),
    Power(table={{0, 268.15,273.15,275.15,283.15,288.15},
            {308.15, 1710, 1690, 1690, 1680, 1670},
            {318.15, 2170, 2150, 2140, 2100, 2080},
            {328.15, 0, 2690, 2680, 2630, 2600},
            {333.15, 0, 0, 2950, 2920, 2900}}));

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

  connect(TinSecondary, Heat.u1) annotation (Line(
      points={{-80,-110},{-80,16},{-22,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary, Heat.u2) annotation (Line(
      points={{-80,108},{-80,40},{-40,40},{-40,4},{-22,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary, Power.u1) annotation (Line(
      points={{-80,108},{-80,30},{-52,30},{-52,-24},{-2,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinSecondary, Power.u2) annotation (Line(
      points={{-80,-110},{-80,-36},{-2,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

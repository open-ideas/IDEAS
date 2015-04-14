within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpAirWater
  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingHeatSource(
    calculatePower=false);

  Modelica.Blocks.Sources.RealExpression QNom_val(y=heat[end].y * 1000 * scaler)
    annotation (Placement(transformation(extent={{-12,20},{-42,40}})));
  Modelica.Blocks.Sources.RealExpression TinPrimary_val[n](each y=TinPrimary - 273.15)
    annotation (Placement(transformation(extent={{-68,-4},{-38,16}})));
  Modelica.Blocks.Sources.RealExpression TinSecondary_val[n](each y=
        ToutSecondary - 273.15)
    annotation (Placement(transformation(extent={{-68,-18},{-38,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1000*interpolator.y*
        scaler + QLossesToCompensate)
    annotation (Placement(transformation(extent={{10,-60},{74,-42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-10})));
equation

  connect(TinSecondary_val.y, heat.u2) annotation (Line(
      points={{-36.5,-8},{-34,-8},{-34,-6},{-30,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary_val.y, heat.u1) annotation (Line(
      points={{-36.5,6},{-30,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{100,0},{86,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{77.2,-51},{86,-51},{86,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QNom_val.y, modulator.max) annotation (Line(
      points={{-43.5,30},{-52,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpAirWater;

within IDEAS.Fluid.Production.Interfaces.HeatSources;
model Boiler
  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingHeatSource(
      calculatePower=false);

  //Parameters
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

  Modelica.Blocks.Sources.RealExpression QNom_val(y=heat[end].y*QNom)
    annotation (Placement(transformation(extent={{-10,20},{-40,40}})));
  Modelica.Blocks.Sources.RealExpression TinPrimary_val[n](each y=ToutSecondary
         - 273.15)
    annotation (Placement(transformation(extent={{-74,-4},{-38,16}})));
  Modelica.Blocks.Sources.RealExpression massFlowSecondary_val[n](each y=massFlowSecondary*scaler*kgps2lph)
    annotation (Placement(transformation(extent={{-82,-18},{-38,2}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-10})));
  Modelica.Blocks.Sources.RealExpression Q_val(y=QNom*interpolator.y*scaler +
        QLossesToCompensate)
    annotation (Placement(transformation(extent={{20,-66},{80,-46}})));
equation
  connect(QNom_val.y, modulator.max) annotation (Line(
      points={{-41.5,30},{-52,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary_val.y, heat.u1) annotation (Line(
      points={{-36.2,6},{-30,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowSecondary_val.y, heat.u2) annotation (Line(
      points={{-35.8,-8},{-34,-8},{-34,-6},{-30,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, heatPort) annotation (Line(
      points={{86,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Q_val.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{83,-56},{86,-56},{86,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Boiler;

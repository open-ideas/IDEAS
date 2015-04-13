within IDEAS.Fluid.Production.Interfaces.HeatSources;
model HeatPumpWaterWater

  //Extensions
  extends
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialNonModulatingHeatSource(
    heatPumpWaterWater=true,
    calculatePower=true);

  //Variables
  Real cop;
  Modelica.SIunits.Power PEl;
  Modelica.SIunits.Power PEvap;
  Modelica.SIunits.Power PCond;

  Modelica.Blocks.Sources.RealExpression QCond(y=PCond + QLossesToCompensate)
    annotation (Placement(transformation(extent={{4,-10},{52,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Blocks.Sources.RealExpression QEva(y=-PEvap + QLossesToCompensate)
    annotation (Placement(transformation(extent={{4,30},{50,50}})));
equation
  cop = heat.y;
  PEl = power.y*scaler;
  PEvap = PEl*(cop - 1);
  PCond = PEl*cop;

  connect(TinPrimary, heat.u1) annotation (Line(
      points={{-80,108},{-80,16},{-22,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinPrimary, power.u1) annotation (Line(
      points={{-80,108},{-80,-24},{-2,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinSecondary, power.u2) annotation (Line(
      points={{-80,-110},{-80,-52},{-60,-52},{-60,-36},{-2,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TinSecondary, heat.u2) annotation (Line(
      points={{-80,-110},{-80,-52},{-60,-52},{-60,4},{-22,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{100,0},{82,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(QCond.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{54.4,0},{62,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPortE, prescribedHeatFlow1.port) annotation (Line(
      points={{100,40},{80,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.Q_flow, QEva.y) annotation (Line(
      points={{60,40},{52.3,40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpWaterWater;

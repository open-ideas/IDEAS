within IDEAS.Fluid.Production.BaseClasses;
partial model Partial3DHeatSource
  import IDEAS;

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(
    final QNomRef=data.QNomRef,
     useTin1=data.useTin1,
     useTout1=data.useTout1,
     useMassFlow1=data.useMassFlow1,
     useTin2=data.useTin2,
     useTout2=data.useTout2,
     modulating=true,
    T_max = data.TMax, T_min = data.TMin);

  //Parameters
  final parameter Real modulationStart=data.modulationStart;
  final parameter Real modulationMin=data.modulationMin;

  final parameter Integer n(min=2)=data.n;
  final parameter Real[n] modulationVector=data.modulationVector;

  parameter Boolean efficiencyData= data.efficiencyData;

  //Variables
  Real modulationInit "Initial modulation value";
  Real modulation "Final modulation value";

  Modelica.SIunits.Power Q2 "The secondary power";
  Modelica.SIunits.Power Q1 "The primary power";

  Modelica.SIunits.Power QInit "Initial value of the condensor power";
  Modelica.SIunits.Power QMax "Maximum value of the condensor power";
  Modelica.SIunits.Power QFinal "Final value of the condensor power";

  //Components
  Modelica.Blocks.Tables.CombiTable2D[n] heatTable(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.heat)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Tables.CombiTable2D[n] powerTable(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.power)
    annotation (Placement(transformation(extent={{0,-48},{20,-28}})));
  replaceable IDEAS.Fluid.Production.Data.PerformanceMaps.Boilers.Boiler data
    constrainedby IDEAS.Fluid.Production.BaseClasses.PartialModulatingRecord
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-96},
            {90,-76}})));
  Modelica.Blocks.Sources.RealExpression tableInput1[n]
    annotation (Placement(transformation(extent={{-80,-34},{-40,-14}})));
  Modelica.Blocks.Sources.RealExpression tableInput2[n]
    annotation (Placement(transformation(extent={{-80,-60},{-40,-40}})));
  Controls.Discrete.HysteresisRelease_boolean onOff(
    enableRelease=true,
    y(start=0),
    release(start=false),
    use_input=false,
    uLow_val=data.modulationMin,
    uHigh_val=data.modulationStart)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=modulation)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow P2
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q2)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow P1 if heatPumpWaterWater
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q1) if heatPumpWaterWater
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=on_internal)
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
equation
  if heatPumpWaterWater then
    T_low = heatPort1Mock.T;
  else
    T_low = data.TMin + 10;
  end if;

  //Limit Q with a maximum equal to the power at modulation 100
  if efficiencyData then
    QMax = heatTable[end].y*data.QNomRef*scaler;
  else
    QMax = heatTable[end].y*scaler;
  end if;
  QInit = IDEAS.Utilities.Math.Functions.smoothMin(
    x1=QAsked,
    x2=QMax,
    deltaX=0.1);

  //Calculate the modulation (modulating=true)
  if modulationInput then
    //Use the input modulation
     modulationInit=uModulationMock * modulation_security_internal;
  else
    //Calculate the required modulation for QAsked
    if efficiencyData then
      modulationInit = Modelica.Math.Vectors.interpolate(
        heatTable.y .* modulationVector*data.QNomRef / 100,
        data.modulationVector,
        QInit/scaler);
    else
      modulationInit = Modelica.Math.Vectors.interpolate(
        heatTable.y,
        data.modulationVector,
        QInit/scaler);
    end if;
  end if;

  //Limit the modulation between [0,100]
  modulation = IDEAS.Utilities.Math.Functions.smoothMax(
    x1=IDEAS.Utilities.Math.Functions.smoothMin(
      x1=modulationInit,
      x2=100,
      deltaX=0.1),
    x2=0,
    deltaX=0.1) * modulation_security_internal;

  //Calculate the power based on the modulation
  power = Modelica.Math.Vectors.interpolate(
      data.modulationVector,
      powerTable.y,
      modulation)*onOff.y * scaler;

  //Calculate the heater powers
  if modulationInput then
    QFinal = QMax*uModulationMock/100*onOff.y;
  else
    QFinal = QInit*onOff.y;
  end if;

  Q2 = QFinal + QLossesToCompensate2;

  if heatPumpWaterWater then
    Q1 = -(-power + Q2 + QLossesToCompensate1);
  else
    Q1 = 0;
  end if;

  connect(heatTable.u1, tableInput1.y) annotation (Line(
      points={{-2,-4},{-32,-4},{-32,-24},{-38,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, heatTable.u2) annotation (Line(
      points={{-38,-50},{-28,-50},{-28,-16},{-2,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput1.y, powerTable.u1) annotation (Line(
      points={{-38,-24},{-32,-24},{-32,-32},{-2,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, powerTable.u2) annotation (Line(
      points={{-38,-50},{-28,-50},{-28,-44},{-2,-44}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(realExpression.y, onOff.u) annotation (Line(
      points={{-39,30},{-32,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P2.Q_flow,realExpression1. y) annotation (Line(
      points={{66,0},{61,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P2.port, heatPort2) annotation (Line(
      points={{86,0},{94,0},{94,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(P1.Q_flow, realExpression2.y) annotation (Line(
      points={{66,-40},{61,-40}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(P1.port, heatPort1) annotation (Line(
      points={{86,-40},{94,-40},{94,-40},{100,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(booleanExpression.y, onOff.release) annotation (Line(
      points={{-39,12},{-20,12},{-20,18}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-72,-66},{-48,-78}},
          lineColor={0,127,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          textString="Tin2
Tout2
massFlow2
Tin1
Tout1
massFlow1")}));
end Partial3DHeatSource;

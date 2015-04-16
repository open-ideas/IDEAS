within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial model Partial3DHeatSource
  import Buildings;

  //Extensions
  extends PartialHeatSource(
    final QNomRef=data.QNomRef,
     useTinPrimary=data.useTinPrimary,
     useToutPrimary=data.useToutPrimary,
     useTinSecondary=data.useTinSecondary,
     useToutSecondary=data.useToutSecondary,
     useMassFlowPrimary=data.useMassFlowPrimary,
     modulating=true);

  //Parameters
  final parameter Real modulationStart=data.modulationStart;
  final parameter Real modulationMin=data.modulationMin;

  final parameter Integer n(min=2)=data.n;
  final parameter Real[n] modulationVector=data.modulationVector;

  parameter Boolean efficiencyData= data.efficiencyData;

  //Variables
  Real modulationInit "Initial modulation value";
  Real modulation "Final modulation value";

  Modelica.SIunits.Power QEvaporator if heatPumpWaterWater
    "The evaporator power";
  Modelica.SIunits.Power QCondensor "The condensor power";

  Modelica.SIunits.Power QInit "Initial value of the condensor power";
  Modelica.SIunits.Power QMax "Maximum value of the condensor power";
  Modelica.SIunits.Power QFinal "Final value of the condensor power";

  //Components
  Modelica.Blocks.Tables.CombiTable2D[n] heatTable(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.heat)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Tables.CombiTable2D[n] powerTable(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.power)
    annotation (Placement(transformation(extent={{-4,-72},{16,-52}})));
  replaceable Data.BoilerData         data
    constrainedby
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingRecord
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-96},{90,-76}})));
  Modelica.Blocks.Sources.RealExpression tableInput1[n]
    annotation (Placement(transformation(extent={{-80,-40},{-40,-20}})));
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

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow PCondensor
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow PEvaporator if heatPumpWaterWater
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=QCondensor)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=QEvaporator) if heatPumpWaterWater
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  //Limit Q with a maximum equal to the power at modulation 100
  if efficiencyData then
    QMax = heatTable[end].y*data.QNomRef*scaler;
  else
    QMax = heatTable[end].y;
  end if;
  QInit = IDEAS.Utilities.Math.Functions.smoothMin(
    x1=QAsked,
    x2=QMax,
    deltaX=0.1);

  //Calculate the modulation (modulating=true)
  if modulationInput then
    //Use the input modulation
     modulationInit=uModulation;
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
    deltaX=0.1);

  //Calculate the power based on the modulation
  power = Modelica.Math.Vectors.interpolate(
      data.modulationVector,
      powerTable.y,
      modulation)*onOff.y;

  //Calculate the heater powers
  if modulationInput then
    QFinal = QMax*uModulation*onOff.y;
  else
    QFinal = QInit*onOff.y;
  end if;
  QCondensor = (QFinal-QLossesToCompensate);
  if heatPumpWaterWater then
    QEvaporator = power + QCondensor + QLossesToCompensateE;
  end if;

  connect(heatTable.u1, tableInput1.y) annotation (Line(
      points={{-22,-24},{-32,-24},{-32,-30},{-38,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, heatTable.u2) annotation (Line(
      points={{-38,-50},{-28,-50},{-28,-36},{-22,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput1.y, powerTable.u1) annotation (Line(
      points={{-38,-30},{-32,-30},{-32,-56},{-6,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, powerTable.u2) annotation (Line(
      points={{-38,-50},{-28,-50},{-28,-68},{-6,-68}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(on, onOff.release) annotation (Line(
      points={{-110,0},{-20,0},{-20,18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realExpression.y, onOff.u) annotation (Line(
      points={{-39,30},{-32,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PCondensor.Q_flow,realExpression1. y) annotation (Line(
      points={{66,0},{61,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PEvaporator.Q_flow,realExpression2. y) annotation (Line(
      points={{66,-40},{61,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PCondensor.port, heatPort) annotation (Line(
      points={{86,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PEvaporator.port, heatPortE) annotation (Line(
      points={{86,-40},{100,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-80,-60},{-40,-80}},
          lineColor={0,127,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          textString="TinSecondary
ToutSecondary
massFlowSecondary
TinPrimary
ToutPrimary
massFlowPrimary")}));
end Partial3DHeatSource;

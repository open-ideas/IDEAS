within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial model PartialModulatingHeatSource

  //Extensions
  extends PartialHeatSource(
    final QNomRef=data.QNomRef,
    final useTinPrimary=data.useTinPrimary,
    final useToutPrimary=data.useToutPrimary,
    final useTinSecondary=data.useTinSecondary,
    final useToutSecondary=data.useToutSecondary,
    final useMassFlowPrimary=data.useMassFlowPrimary);

  //Parameters
  final parameter Real modulationStart=data.modulationStart;
  final parameter Real modulationMin=data.modulationMin;

  final parameter Integer n(min=2)=data.n;
  final parameter Real[n] modulationVector=data.modulationVector;

  Interpolator interpolator(n=n, values=modulationVector)
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Tables.CombiTable2D[n] heat(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.heat)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modulator modulator(modulationMin=modulationMin, modulationStart=
        modulationStart)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Blocks.Tables.CombiTable2D[n] power(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=data.power) if calculatePower
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Interpolator interpolator1(n=n, values=modulationVector) if calculatePower
    annotation (Placement(transformation(extent={{52,-40},{72,-20}})));
  replaceable PartialModulatingRecord data
    constrainedby
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialModulatingRecord
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-96},{90,-76}})));
equation

  connect(heat.y, interpolator.x) annotation (Line(
      points={{-7,0},{20,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QAsked, modulator.required) annotation (Line(
      points={{-110,30},{-68,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(on, modulator.u) annotation (Line(
      points={{-110,0},{-60,0},{-60,19.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(modulator.modulation, interpolator.xi) annotation (Line(
      points={{-60,41},{-60,60},{30.4,60},{30.4,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(power.y, interpolator1.x) annotation (Line(
      points={{21,-30},{50,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(modulator.modulation, interpolator1.xi) annotation (Line(
      points={{-60,41},{-60,60},{60.4,60},{60.4,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PartialModulatingHeatSource;

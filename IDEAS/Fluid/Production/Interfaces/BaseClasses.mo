within IDEAS.Fluid.Production.Interfaces;
package BaseClasses "Baseclasses for the construction of heater models"
  model QAsked
    //Extensions
    extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

    //Parameters
    parameter Boolean useQSet=false "Set to true to use Q as an input";

    Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-20,108}), iconTransformation(
          extent={{-9,-9},{9,9}},
          rotation=270,
          origin={-21,69})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,106}), iconTransformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={21,69})));
  equation
    if not useQSet then
      y = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, u, Medium.X_default)) -port_a.h_outflow), 10);
   else
      y = u;
    end if;

    connect(port_a, port_b) annotation (Line(
        points={{-100,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                           graphics={Rectangle(extent={{-100,60},{100,-60}},
              lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
                                    Text(
            extent={{80,-60},{-60,60}},
            lineColor={0,0,255},
            textString="Q?")}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics));
  end QAsked;

  model Modulator
    //Settings
    parameter Boolean avoidEvents=true "Set to false to stop filtering events";

    parameter Real modulationMin = 20 "Minimal modulation grade";
    parameter Real modulationStart = 30 "Start modulation grade";

    Real modulationInit;

    Modelica.Blocks.Interfaces.RealOutput modulation "Modulation degree"
                          annotation (Placement(
          transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={0,110})));
    Modelica.Blocks.Interfaces.RealInput required annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-112,0}), iconTransformation(extent={{-100,-20},{-60,20}})));
    Modelica.Blocks.Interfaces.RealInput max annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=180,
          origin={112,0}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=180,
          origin={80,0})));

    Controls.Discrete.HysteresisRelease_boolean
                                            onOff(
      enableRelease=true,
      y(start=0),
      release(start=false),
      use_input=false,
      uLow_val=modulationMin,
      uHigh_val=modulationStart)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.RealExpression initialModulation(y=modulationInit)
      annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
    Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-108})));
  equation
    modulationInit = required/max * 100;
    modulation = onOff.y*IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100,1);
    connect(onOff.u, initialModulation.y) annotation (Line(
        points={{-12,0},{-25,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(u, onOff.release) annotation (Line(
        points={{0,-108},{0,-12}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            extent={{-70,-70},{70,70}}),
          Line(points={{0,70},{0,40}}),
          Line(points={{22.9,32.8},{40.2,57.3}}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}),
          Line(points={{37.6,13.7},{65.8,23.9}}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}),
          Ellipse(
            lineColor={64,64,64},
            fillColor={255,255,255},
            extent={{-12,-12},{12,12}}),
          Polygon(
            origin={0,0},
            rotation=-17.5,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
          Ellipse(
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-7,-7},{7,7}}),
          Line(points={{0,100},{0,70}}, color={0,0,127})}), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end Modulator;

  model Interpolator

    //Parameters
    parameter Integer n(min=2) "Number of values to interpolate";
    parameter Real values[n] "Array containing the actual values";

    //Interface
    Modelica.Blocks.Interfaces.RealInput
              x[n] "Connector of Real input signals" annotation (Placement(
          transformation(extent={{-22,62},{18,102}},    rotation=0),
          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,0})));
    Modelica.Blocks.Interfaces.RealOutput
               y "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}}, rotation=0),
          iconTransformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput xi "Desired value" annotation (Placement(
          transformation(extent={{-22,100},{18,140}},  rotation=0),
          iconTransformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-16,120})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
                {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
                {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,20},{-30,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,0},{-30,20}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-20},{-30,0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-40},{-30,-20}}),
          Line(
            points={{-100,0},{-60,30}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-100,0},{-60,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-100,0},{-60,-10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-100,0},{-60,-30}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-16,100},{-16,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(
            extent={{-26,20},{-6,0}},
            lineColor={0,0,0},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid)}),
                                         Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));

  equation
    y = Modelica.Math.Vectors.interpolate(
      values,
      x,
      xi);

  end Interpolator;

  partial model PartialHeatSource

    //Extensions

    //Packages
    replaceable package Medium=IDEAS.Media.Water.Simple;

    //Parameters
    final parameter Modelica.SIunits.ThermalConductance UALoss;
    final parameter Boolean calculatePower;

    parameter Modelica.SIunits.Power QNom;
    parameter Modelica.SIunits.Power QNomRef;
    parameter Boolean heatPump = false;

    final parameter Real scaler = QNom/QNomRef;

    parameter Boolean useTinPrimary=true;
    parameter Boolean useToutPrimary=true;

    parameter Boolean useTinSecondary=true;
    parameter Boolean useToutSecondary=true;
    parameter Boolean useMassFlowSecondary=true;

    //Variables
    Modelica.SIunits.Power QLossesToCompensate;

    //Components

    //Interfaces
    Modelica.Blocks.Interfaces.RealInput TinPrimary if useTinPrimary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-80,108}),                           iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=270,
          origin={-80,102})));
    Modelica.Blocks.Interfaces.RealInput ToutPrimary if useToutPrimary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-40,108}),                           iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=270,
          origin={-40,102})));
    Modelica.Blocks.Interfaces.RealInput massFlowPrimary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,108}),                              iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=270,
          origin={0,102})));
    Modelica.Blocks.Interfaces.RealInput TinSecondary if useTinSecondary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-80,-110}),                           iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=90,
          origin={-80,-102})));
    Modelica.Blocks.Interfaces.RealInput QAsked annotation (Placement(
          transformation(extent={{-130,10},{-90,50}}),  iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=0,
          origin={-100,40})));
    Modelica.Blocks.Interfaces.RealInput ToutSecondary if useToutSecondary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-40,-110}),                           iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=90,
          origin={0,-102})));
    Modelica.Blocks.Interfaces.RealInput massFlowSecondary if useMassFlowSecondary annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-110}),                              iconTransformation(
            extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,-102})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
      "heatPort connection to water in condensor"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.BooleanInput on
      annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-110,0}),                            iconTransformation(extent={{-10,-10},
              {10,10}},
          rotation=0,
          origin={-100,0})));
    Modelica.Blocks.Interfaces.RealInput TEnvironment annotation (Placement(
          transformation(extent={{-130,-70},{-90,-30}}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-100,-40})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortE if heatPump
      "heatPort connection to water in the evaporator in case of a HP"
      annotation (Placement(transformation(extent={{90,30},{110,50}}),
          iconTransformation(extent={{90,20},{110,40}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            points={{-70,-20},{30,-20}},
            color={191,0,0},
            thickness=0.5),
          Line(
            points={{-70,20},{30,20}},
            color={191,0,0},
            thickness=0.5),
          Line(
            points={{-90,0},{-70,-20}},
            color={191,0,0},
            thickness=0.5),
          Line(
            points={{-90,0},{-70,20}},
            color={191,0,0},
            thickness=0.5),
          Polygon(
            points={{30,0},{30,40},{60,20},{30,0}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{30,-40},{30,0},{60,-20},{30,-40}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,40},{80,-40}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics));

  equation
    QLossesToCompensate = if noEvent(massFlowPrimary > 0) then UALoss*(heatPort.T -
      TEnvironment) else 0;

  end PartialHeatSource;

  partial model PartialNonModulatingHeatSource
    extends PartialHeatSource;

    Modelica.Blocks.Tables.CombiTable2D Heat
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Tables.CombiTable2D Power if calculatePower
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  end PartialNonModulatingHeatSource;

  partial model PartialModulatingHeatSource

    //Extensions
    extends BaseClasses.PartialHeatSource;

    //Parameters
    parameter Real modulationStart=30;
    parameter Real modulationMin=20;

    parameter Integer n(min=2);
    parameter Real[n] modulationVector;

    BaseClasses.Interpolator interpolator(n=n, values=modulationVector)
      annotation (Placement(transformation(extent={{22,-10},{42,10}})));
    Modelica.Blocks.Tables.CombiTable2D[n] Heat(
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
      annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
    BaseClasses.Modulator modulator(modulationMin=modulationMin, modulationStart=
          modulationStart)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    Modelica.Blocks.Tables.CombiTable2D[n] Power(
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) if calculatePower
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  equation
    connect(Heat.y, interpolator.x) annotation (Line(
        points={{-7,0},{20,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(QAsked, modulator.required) annotation (Line(
        points={{-110,30},{-80,30},{-80,40},{-68,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(on, modulator.u) annotation (Line(
        points={{-110,0},{-60,0},{-60,29.2}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(modulator.modulation, interpolator.xi) annotation (Line(
        points={{-60,51},{-60,60},{30.4,60},{30.4,12}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end PartialModulatingHeatSource;
end BaseClasses;

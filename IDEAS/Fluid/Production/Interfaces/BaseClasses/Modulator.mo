within IDEAS.Fluid.Production.Interfaces.BaseClasses;
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

within IDEAS.Fluid.Production.Interfaces.BaseClasses;
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

equation
  y = Modelica.Math.Vectors.interpolate(
    x,
    values,
    xi);

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
end Interpolator;

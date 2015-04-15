within IDEAS.Fluid.Production.Interfaces.BaseClasses;
model Interpolator "yi=f(x[n]:xi)"

  //Parameters
  parameter Integer n(min=2) "Number of values to interpolate";

  //Interface
  Modelica.Blocks.Interfaces.RealInput
            x[n] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-22,62},{18,102}},    rotation=0),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput
             yi "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-8},{120,12}},  rotation=0),
        iconTransformation(extent={{100,-8},{120,12}})));
  Modelica.Blocks.Interfaces.RealInput xi "Desired value" annotation (Placement(
        transformation(extent={{-22,100},{18,140}},  rotation=0),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  Modelica.Blocks.Interfaces.RealInput
            y[n] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-22,62},{18,102}},    rotation=0),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
equation
    yi = Modelica.Math.Vectors.interpolate(
      x,
      y,
      xi);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(
          points={{0,100},{0,2}},
          color={0,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{-60,60},{-60,-60},{64,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-70,40},{-60,60},{-50,40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-10,-10},{0,10},{10,-10}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={54,-60},
          rotation=270),
        Ellipse(
          extent={{-64,-56},{-56,-64}},
          lineColor={0,0,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-58,-60},{-42,-12},{0,2},{28,42}},
          color={0,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-4,6},{4,-2}},
          lineColor={0,0,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,-8},{-38,-16}},
          lineColor={0,0,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,46},{32,38}},
          lineColor={0,0,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{100,2},{0,2}},
          color={0,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{28,42},{50,54}},
          color={0,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{48,58},{56,50}},
          lineColor={0,0,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,0},{-60,0}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          smooth=Smooth.None),
        Line(
          points={{0,-100},{0,-60}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          smooth=Smooth.None),
        Text(
          extent={{-104,132},{-4,112}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          textString="%name")}),       Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Interpolator;

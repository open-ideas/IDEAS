within IDEAS.Utilities;
package Tables
  model InterpolationTable3D "A 3D Interpolation table"

    //Inputs
    Modelica.Blocks.Interfaces.RealInput u1 "Row indexes"
      annotation (Placement(transformation(extent={{-128,40},{-88,80}})));
    Modelica.Blocks.Interfaces.RealInput u2 "Column indexes"
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Interfaces.RealInput u3 "Heights"
      annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));

    //Outputs
    Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}}, rotation=0),
          iconTransformation(extent={{100,-8},{120,12}})));

    //Parameters
    parameter Boolean includeZero = true
      "Wether or not to automatically include zero as a height and a plane with zero output";
    parameter Integer n(min=2) = space.n "Number of 2D tables";
    final parameter Real heights[n]= {space.planes[i].height for i in 1:n};

    //Data
    replaceable parameter Space space annotation(choicesAllMatching=true);

    //Tables
    Modelica.Blocks.Tables.CombiTable2D Table[n](
      table={space.planes[i].curve for i in 1:n})
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  equation
    for i in 1:n loop
      Table[i].u1=u1;
      Table[i].u2=u2;
    end for;

    y = Modelica.Math.Vectors.interpolate(
      heights,
      {Table[i].y for i in 1:n},
      u3);
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
      Line(points={{-60,40},{-30,20}}),
      Line(points={{-30,40},{-60,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}}),
      Rectangle(origin={-2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}}),
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
                {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
                {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Line(points={{-60,40},{-30,20}}),
      Line(points={{-30,40},{-60,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}}),
      Rectangle(origin={-2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}})}));
  end InterpolationTable3D;

  record Space

    parameter Integer n(min=2)=2 "Number of planes";
    parameter Plane planes[n] "Array of planes"
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end Space;

  record Plane

    parameter Real height "The height of the plane";
    parameter Real curve[:,:];

  end Plane;
end Tables;

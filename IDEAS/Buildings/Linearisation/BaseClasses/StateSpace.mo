within IDEAS.Buildings.Linearization.BaseClasses;
model StateSpace "State space model with bus inputs"
  extends partial_StateSpace;

equation
  connect(stateSpace.y, y)
    annotation (Line(points={{11,0},{104,0},{104,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Text(
          extent={{-60,40},{60,0}},
          lineColor={0,0,0},
          textString="sx=Ax+Bu"),
        Text(
          extent={{-60,0},{60,-40}},
          lineColor={0,0,0},
          textString=" y=Cx+Du"),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(
          points={{-60,0},{-70,0},{-70,60},{-100,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-70,-60},{-98,-60}},
          color={0,0,255},
          smooth=Smooth.None)}),                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end StateSpace;

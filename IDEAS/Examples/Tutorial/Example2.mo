within IDEAS.Examples.Tutorial;
model Example2 "Adding closed screens"
  extends Example1(window(redeclare Buildings.Components.Shading.Screen shaType));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(const.y, window.Ctrl)
    annotation (Line(points={{-79,-50},{-26,-50},{-26,-34}}, color={0,0,127}));
end Example2;

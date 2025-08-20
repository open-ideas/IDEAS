within IDEAS.Buildings.Components.Examples;
model CavityInternalWall
  "Illustration of an internal wall with an operable cavity"
  extends IDEAS.Buildings.Examples.ZoneExample(sim(
  interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts),
  internalWall(hasCavity = true, use_y_doo = true));
  Modelica.Blocks.Sources.Sine sine(amplitude = 0.5, f = 1 / 7200, offset = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(internalWall.y_doo, sine.y) annotation(
    Line(points={{-16.8,6.4},{-16.8,10},{-79,10}},  color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/Examples/CavityInternalWall.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example contains an example use of a controllable cavity in an internal wall. Note that it requires TwoPorts interzonal air flow.
</p>
</html>", revisions="<html>
<ul>
<li>
July 9, 2023, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end CavityInternalWall;
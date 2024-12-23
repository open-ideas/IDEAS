within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse3 "Adding occupant and lighting"
  extends DetailedHouse2(
                   zone(
      redeclare replaceable Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
      redeclare Buildings.Components.RoomType.Office rooTyp,
      redeclare Buildings.Components.LightingType.LED ligTyp,
      redeclare Buildings.Components.LightingControl.OccupancyBased ligCtr));
  annotation (
    Documentation(revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>", info="<html>
<p>
This example extends the second example by adding an occupant and lighting model.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.Occupants.Fixed\">
IDEAS.Buildings.Components.Occupants.Fixed</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.LightingType.LED\">
IDEAS.Buildings.Components.LightingType.LED</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.LightingControl.OccupancyBased\">
IDEAS.Buildings.Components.LightingControl.OccupancyBased</a>
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example3.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end DetailedHouse3;

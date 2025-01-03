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
Based on the selected options, the system automatically calculates zone heat gains, 
relative humidity, and CO2 concentration. The model implements a continuous occupancy 
of one person and LED lighting for the zone. The lighting operates when occupants are present.
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
<h4>Connection instructions</h4>
<p>
Set the appropriate replaceable models in the zone model.
</p>
<h4>Reference result</h4>
<p>
The result with and without the occupant and lighting is plotted in the figure below. 
</p>
<p align=\"center\">
<img alt=\"Zone temperature without (blue) and with (red) occupant and lighting (both with screen model).\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse3.png\" width=\"700\"/>
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse3.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end DetailedHouse3;

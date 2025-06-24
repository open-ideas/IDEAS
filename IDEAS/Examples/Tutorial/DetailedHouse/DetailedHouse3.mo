within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse3 "Adding occupancy and lighting"
  extends DetailedHouse2(
    zon(
      redeclare replaceable IDEAS.Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp,
      redeclare IDEAS.Buildings.Components.RoomType.Office rooTyp,
      redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp,
      redeclare IDEAS.Buildings.Components.LightingControl.OccupancyBased ligCtr));
  annotation (
    Documentation(info="<html>
<p>
This example extends the second example by adding an occupancy and lighting model.
Based on the selected options, the system automatically calculates the zone's internal heat gains, 
relative humidity, and CO<sub>2</sub> concentration. The model implements a continuous occupancy schedule
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
<p>
Similar to the <a href=\"modelica://IDEAS.Buildings.Components.Shading.Screen\">
IDEAS.Buildings.Components.Shading.Screen</a> model used in <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse2\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse2</a>, these model are utilized <i>internally</i> and can be set in the parameter windows.
They should not be dragged and dropped.
</p>
<h4>Connection instructions</h4>
<p>
Set the appropriate replaceable models in the dialogue window of the zone model.
</p>
<h4>Reference result</h4>
<p>
The figure below shows the operative zone temperature without (blue) and with (red) occupant and lighting. 
</p>
<p align=\"center\">
<img alt=\"The operative zone temperature without (blue) and with (red) occupant and lighting (both with screen model).\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse3.png\" width=\"700\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
April 14, 2025, by Anna Dell'Isola and Lone Meertens:<br/>
Update and restructure IDEAS tutorial models.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1374\">#1374</a> 
and <a href=\"https://github.com/open-ideas/IDEAS/issues/1389\">#1389</a>.
</li>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse3.mos"
        "Simulate and plot"));
end DetailedHouse3;

within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse4 "Including custom occupant schedule"
  extends DetailedHouse3(zon(redeclare OccSch occNum(k=2)));
protected
  model OccSch "Simple occupancy schedule"
    extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

    parameter Real k "Number of occupants";
    IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.RealExpression occ(y=
    if calTim.weekDay < 6 and (calTim.hour > 7 and calTim.hour < 18) then k else 0)
      "Number of occupants present"
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(occ.y, nOcc)
      annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
  end OccSch;
  annotation (
    Documentation(info="<html>
<p>
This example extends the third example by adding a
custom occupancy model that uses an occupancy schedule that returns an
occupancy of two during office hours and zero otherwise.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants\">
IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants</a>
</li>
<li>
<a href=\"modelica://IDEAS.Utilities.Time.CalendarTime\">
IDEAS.Utilities.Time.CalendarTime</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Sources.RealExpression\">
Modelica.Blocks.Sources.RealExpression</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
Create a new model that extends the occupancy partial model. This partial model contains an input, 
which is not used, and an output, which must be set. Create an occupancy signal using a 
<code>RealExpression</code> that returns the parameter value <i>k</i> during office hours (7–19 h on weekdays) 
and zero otherwise. Implement this model by extending the previous example, redeclaring the 
occupancy model, and setting parameter <i>k</i>. 
Use the year 2019 (<a href=\"modelica://IDEAS.Utilities.Time.Types.ZeroTime.NY2019\">
IDEAS.Utilities.Time.Types.ZeroTime.NY2019</a>) to define the reference time in the calendar model. 
Use an if-then-else statement with 
logical checks for the calendar outputs <code>weekDay</code> and <code>hour</code>.
</p>
<h4>Reference result</h4>
<p>
The figure below shows the operative zone temperature with the old (blue) and new (red) occupancy model.
Note the much more peaked behaviour of the zone temperature during the weekdays when there are occupants present.
</p>
<p align=\"center\">
<img alt=\"The operative zone temperature with old (blue) and new (red) occupant model.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse4.png\" width=\"700\"/>
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
    __Dymola_Commands(file="Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse4.mos"
        "Simulate and plot"));
end DetailedHouse4;

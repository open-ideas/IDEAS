within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse8 "JSOn writer"
  extends DetailedHouse7;
  Utilities.IO.Files.JSONWriter jsonWri(
    nin=1,
    fileName="EEl.json",
    varKeys={"Electrical energy [kWh]"},
    outputTime=IDEAS.Utilities.IO.Files.BaseClasses.OutputTime.Terminal)
    annotation (Placement(transformation(extent={{280,-42},{260,-22}})));
equation
  connect(jsonWri.u[1], EEl.y) annotation (Line(points={{280,-32},{286,-32},{286,
          50},{301,50}},     color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>", info="<html>
<p>
This model outputs the main model result to a json file.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.Utilities.IO.Files.JSONWriter\">
IDEAS.Utilities.IO.Files.JSONWriter</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
The model consists of two <code>RectangularZoneTemplates</code> and a <code>SimInfoManager</code>. The required parameters are set in 
the templates, with careful attention to all tabs. The internal wall is defined in only one of the two 
templates, while an <i>external connection</i> is used for the other template. The <code>InternalWall</code> and 
<code>External</code> options cause a yellow bus connector to appear on each template, which must then be connected to each other.
</p>
<h4>Reference result</h4>
<p>
The figure bellow shows the zone temperatures of both zones. Note the large influence that the
window placement has on the zone dynamics!
</p>
<p align=\"center\">
<img alt=\"Zone temperature for the zone with the north oriented window (blue) and the zone with the south
oriented window (red).\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse5.png\" width=\"700\"/>
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse8.mos"
        "Simulate and plot"),
 experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Lsodar"));
end DetailedHouse8;

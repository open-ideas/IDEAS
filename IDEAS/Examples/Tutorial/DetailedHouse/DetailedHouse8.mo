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
  connect(jsonWri.u[1], EEl.y) annotation (Line(points={{280,-32},{286,-32},{
          286,50},{281,50}}, color={0,0,127}));
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
</html>"), experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Lsodar"));
end DetailedHouse8;

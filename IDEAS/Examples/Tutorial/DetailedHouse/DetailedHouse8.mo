within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse8 "JSON writer"
  extends DetailedHouse7;
  IDEAS.Utilities.IO.Files.JSONWriter jsonWri(
    nin=1,
    fileName="EEl.json",
    varKeys={"Electrical energy [kWh]"},
    outputTime=IDEAS.Utilities.IO.Files.BaseClasses.OutputTime.Terminal)
    annotation (Placement(transformation(extent={{308,70},{328,90}})));
equation
  connect(jsonWri.u[1], EEl.y) annotation (Line(points={{308,80},{304,80},{304,50},
          {281,50}},         color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Extracting results from Dymola can be tedious. Therefore, several custom tools have been developed to facilitate 
exporting simulation results. For time-series data, a generic CSV writer can be found in <a href=\"modelica://IDEAS.Utilities.IO.Files.JSONWriter\">
IDEAS.Utilities.IO.Files.JSONWriter</a>. This model generates a CSV file at a user-defined location that contains data for 
each of the inputs of the block. The delimiter can be modified in the advanced parameter tab. The model 
<a href=\"modelica://IDEAS.Utilities.IO.Files.CombiTimeTableWriter\"> IDEAS.Utilities.IO.Files.CombiTimeTableWriter</a>, 
does the same, albeit using a slightly different file format which can be read directly back into Modelica using the file reader
<a href=\"modelica://Modelica.Blocks.Sources.CombiTimeTable\"> Modelica.Blocks.Sources.CombiTimeTable</a>.
</p>
<p>
In this example we will not output time series data, only a single value: the total electricity consumption at the end
of the simulation, using the <code>JSON</code> file format. Note that the external library <code>ExternData</code> can be used to read
<code>JSON</code> files.
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
Add the model, choose a file path and indicate the appropriate time when the result should be
saved. Connect the appropriate signal to the input of the block.
</p>
<h4>Reference result</h4>
<p>
Check the contents of the generated file. Depending on the chosen value for the parameter
<code>varKeys</code>, the result should be similar to: {\"Electrical energy [kWh]\"}: 1.7425569229e+01
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
      __Dymola_Algorithm="Dassl"));
end DetailedHouse8;

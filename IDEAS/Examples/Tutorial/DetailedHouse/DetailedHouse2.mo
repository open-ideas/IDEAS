within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse2 "Adding closed screens"
  extends DetailedHouse1(window(redeclare Buildings.Components.Shading.Screen shaType));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(const.y, window.Ctrl)
    annotation (Line(points={{-79,-50},{-26,-50},{-26,-34}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This second example file extends the first example and adds a solar shading screen to the window model. 
Compare the simulation outputs to see the impact on the zone temperature.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://Modelica.Blocks.Sources.Constant\">
Modelica.Blocks.Sources.Constant</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.Shading.Screen\">
IDEAS.Buildings.Components.Shading.Screen</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
Solar shading is a property of the window and can be selected using the replaceable model <code>shaType</code>. 
A drop-down menu lists all available options. Each option may include custom parameters, which can be configured by pressing the <i>Edit</i> button next to the drop-down menu.
</p>
<p>
The <code>Screen</code> model requires an external control signal to determine whether the screen is extended or retracted. 
An input appears on the <code>Window</code> icon for this purpose. Ensure that this input is connected to the appropriate control signal. 
See the window input comment for more information on how to choose the control signal.
</p>
<h4>Reference result</h4>
<p>
The figure below illustrates the zone temperature with (red) and without (blue) the shading model.
</p>
<p align=\"center\">
<img alt=\"Zone temperature without (blue) and with (red) screen model.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse2.png\" width=\"700\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse2.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end DetailedHouse2;

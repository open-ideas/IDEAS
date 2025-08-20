within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse7 "Adding a controller"
  extends DetailedHouse6(heaPum(enable_variable_speed=true));
  Modelica.Blocks.Logical.Hysteresis hys(uLow=273.15 + 45, uHigh=273.15 + 50)
    "Hysteresis controller"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=0, realFalse=1)
    "Conversion to real control signal"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

equation
  connect(hys.y, booToRea.u) annotation (Line(points={{81,-70},{88,-70},{88,-70},
          {98,-70}}, color={255,0,255}));
  connect(booToRea.y, heaPum.y)
    annotation (Line(points={{121,-70},{187,-70},{187,-2}}, color={0,0,127}));
  connect(senTan.T, hys.u) annotation (Line(points={{121.2,10},{126,10},{126,-42},
          {48,-42},{48,-70},{58,-70}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This step adds a controller that disables the heat pump when the supply water
temperature exceeds <i>45°C</i>. The simple controller has a large impact on the heat pump's COP.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.Fluid.Sensors.TemperatureTwoPort\">
IDEAS.Fluid.Sensors.TemperatureTwoPort</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Logical.Hysteresis\">
Modelica.Blocks.Logical.Hysteresis</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Math.BooleanToReal\">
Modelica.Blocks.Math.BooleanToReal</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
The temperature sensor in the storage tank serves as an input to the hysteresis controller.
The controller is configured such that it switches to a <i>false</i> signal below <i>45°C</i> and to <i>true</i> above <i>50°C</i>.
</p>
<p>
The output of the hysteresis controller is thus true when the tank temperature is high enough and false
otherwise. This Boolean signal has to be converted in a real control signal that can be accepted by the heat
pump model using the <code>BooleanToReal</code> block. The heat pump already has a control signal.
Since blocks cannot be removed from an extension of a model, the heat pump model input type is set to 
enable_variable_speed=true. This configuration allows the model to accept any real signal while ignoring 
connections to the other control signal.
</p>
<h4>Reference result</h4>
<p>
The figure below shows the operative zone temperature <code>recZon.TSensor</code>, the heat pump condenser temperature<code>heaPum.con.T</code>
and the radiator heat flow rate <code>rad.Q_flow</code> in the north-oriented zone with (red) and without (blue) hysteresis control.
We see that the supply temperature is indeed reduced significantly. 
This causes the zone temperature to be slightly lower, up to about <i>0.2°C</i>. 
However, the COP increases to around <i>4-5</i> and the electrical energy use decreases from <i>28.1 kWh</i> to <i>17.4 kWh</i>. 
</p>
<p align=\"center\">
<img alt=\"Comparison with (red) and without (blue) control for zone temperature, supply water temperature
and radiator thermal power.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse7.png\" width=\"700\"/>
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
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse7.mos"
        "Simulate and plot"));
end DetailedHouse7;

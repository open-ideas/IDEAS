within IDEAS.Examples.Tutorial;
model Example7 "Adding a controller"
  extends Example6(heaPum(enable_variable_speed=true));
  Modelica.Blocks.Logical.Hysteresis hys(uLow=273.15 + 40, uHigh=273.15 + 45)
    "Hysteresis controller"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=0, realFalse=1)
    "Conversion to real control signal"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTemSup
    "Supply water temperature sensor" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={120,-6})));
equation
  connect(hys.y, booToRea.u) annotation (Line(points={{81,-70},{88,-70},{88,-70},
          {98,-70}}, color={255,0,255}));
  connect(senTemSup.port, pumpSec.heatPort)
    annotation (Line(points={{120,0},{120,53.2}}, color={191,0,0}));
  connect(senTemSup.T, hys.u) annotation (Line(points={{120,-12},{120,-48},{42,
          -48},{42,-70},{58,-70}}, color={0,0,127}));
  connect(booToRea.y, heaPum.y)
    annotation (Line(points={{121,-70},{167,-70},{167,-2}}, color={0,0,127}));
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
The simple controller has a large impact on the heat pump COP.
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example7.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Lsodar"));
end Example7;

within IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.Examples;
model RelativeAirMass "Test model for relative air mass"
  extends Modelica.Icons.Example;
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.RelativeAirMass
    relAirMas annotation (Placement(transformation(extent={{20,0},{40,20}})));
  IDEAS.BoundaryConditions.SolarGeometry.ZenithAngle zen(lat=
        0.34906585039887)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(zen.y, relAirMas.zen) annotation (Line(
      points={{1,10},{18,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaDat.weaBus, zen.weaBus) annotation (Line(
      points={{-40,10},{-20,10}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
Documentation(info="<html>
<p>
This example computes the relative air mass for sky brightness.
</p>
</html>", revisions="<html>
<ul>
<li>
July 07, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(StopTime=864000),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/BoundaryConditions/SolarIrradiation/BaseClasses/Examples/RelativeAirMass.mos"
        "Simulate and plot"));
end RelativeAirMass;

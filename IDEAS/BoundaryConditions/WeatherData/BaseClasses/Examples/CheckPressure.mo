within IDEAS.BoundaryConditions.WeatherData.BaseClasses.Examples;
model CheckPressure "Test model for pressure check"
  extends Modelica.Icons.Example;

  IDEAS.BoundaryConditions.WeatherData.BaseClasses.CheckPressure chePre
    "Block that checks the pressure"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  IDEAS.Utilities.Time.ModelTime modTim
    "Block that outputs simulation time"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
protected
  Modelica.Blocks.Tables.CombiTable1Ds datRea(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
       "modelica://IDEAS/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    columns=2:30,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Data reader"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
public
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.ConvertTime conTim
    "Block that converts time"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(datRea.y[4], chePre.PIn) annotation (Line(
      points={{1,9.24138},{10,9.24138},{10,10},{18,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(modTim.y, conTim.modTim) annotation (Line(
      points={{-79,10},{-62,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conTim.calTim, datRea.u) annotation (Line(
      points={{-39,10},{-22,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
Documentation(info="<html>
<p>
This example tests the model that asserts that the pressure is within acceptable bounds.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 14, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(StopTime=8640000),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/CheckPressure.mos"
        "Simulate and plot"));
end CheckPressure;

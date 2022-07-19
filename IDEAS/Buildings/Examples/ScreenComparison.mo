within IDEAS.Buildings.Examples;
model ScreenComparison "Comparison between a model with and without screen"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Validation.Cases.Case900Template zoneWithScreen(
    fracA=0.15,
    shaTypA(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Screen,

      hWin=3,
      wWin=4),
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypA)
    "Zone with a screen for its window"
    annotation (Placement(transformation(extent={{-40,-12},{-20,8}})));
  Modelica.Blocks.Sources.Constant screenCtrl(k=1) "Screen control signal"
    annotation (Placement(transformation(extent={{-88,-44},{-68,-24}})));

  Validation.Cases.Case900Template zoneWithoutScreen(
    fracA=0.15,
    shaTypA(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.None,
      hWin=3,
      wWin=4),
    redeclare Data.Frames.AluminumInsulated fraTypA)
    "Zone without a screen for its window"
    annotation (Placement(transformation(extent={{20,-12},{40,8}})));
equation
  connect(zoneWithScreen.ctrlA, screenCtrl.y);

  annotation (
    experiment(
      StartTime=10000000,
      StopTime=12000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
July 18th, 2022 by Filip Jorissen<br/>
First implementation for #1270.
</li>
</ul>
</html>", info="<html>
<p>
Illustration of how the rectangularzonetemplate can be equipped with a screen. 
At the same time, the influence of the screen on the zone temperature is shown.
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/ScreenComparison.mos"
        "Simulate and plot"));
end ScreenComparison;

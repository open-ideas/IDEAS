within IDEAS.Fluid.Sources.Examples;
model Outside_CpData_Specification
  "Test model for wind pressure profile"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air "Medium model for air";

  IDEAS.Fluid.Sources.Outside_CpData nor(
    redeclare package Medium = Medium,
    incAngSurNor={0,90,180,315}*2*Modelica.Constants.pi/360,
    Cp={1,0.2,0.5,0.8},
    azi=IDEAS.Types.Azimuth.N,
    Cs=2/1.2) "Model to compute wind pressure on North-facing surface"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
    winSpeSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
    winSpe=1,
    winDirSou=IDEAS.BoundaryConditions.Types.DataSource.Input)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  Modelica.Blocks.Sources.Ramp winDir(
    height=2*Modelica.Constants.pi,
    duration=24*3600)
    "Wind direction"
    annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));

equation
  connect(weaDat.winDir_in, winDir.y)
    annotation (Line(points={{-21,-6},{-39,-6}}, color={0,0,127}));
  connect(weaDat.weaBus, nor.weaBus) annotation (Line(
      points={{0,0},{10,0},{10,0.2},{20,0.2}},
      color={255,204,51},
      thickness=0.5));
  annotation (__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Sources/Examples/Outside_CpData_Specification.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model validates the specification of the wind pressure profile
in the information section of the model
<a href=\"modelica://IDEAS.Fluid.Sources.Outside_CpData\">IDEAS.Fluid.Sources.Outside_CpData</a>.
The surface is configured to be facing North.
</p>
</html>", revisions="<html>
<ul>
<li>
February 11, 2022, by Michael Wetter:<br/>
First implementation.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1436\">IBPSA, #1436</a>.
</li>
</ul>
</html>"),
    experiment(
      StopTime=86400,
      Tolerance=1e-06));
end Outside_CpData_Specification;

within IDEAS.Fluid.PvtCollectors.BaseClasses.Examples;
model ISO9806HeatLoss "Example showing the use of ISO9806QuasiDynamicHeatLoss"
  extends Modelica.Icons.Example;
  parameter IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per=
      IDEAS.Fluid.PvtCollectors.Data.Uncovered.UI_TRNSYSValidation()
    "Performance data" annotation (choicesAllMatching=true);
  Modelica.Blocks.Sources.Sine T1(
    amplitude=15,
    f=0.1,
    offset=273.15 + 10) "Temperature of the first segment"
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Blocks.Sources.Sine T2(
    f=0.1,
    amplitude=15,
    offset=273.15 + 15) "Temperature of the second segment"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Sources.Sine T3(
    f=0.1,
    amplitude=15,
    offset=273.15 + 20) "Temperature of the third segment"
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  ISO9806QuasiDynamicHeatLoss heaLosQuaDyn(
    nSeg=3,
    redeclare package Medium = IDEAS.Media.Water,
    a1=per.a1,
    a2=per.a2,
    c3=per.c3,
    c4=per.c4,
    c6=per.c6,
    A_c=per.A) annotation (Placement(transformation(extent={{74,12},{94,32}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-84,70},{-64,90}})));
  Modelica.Blocks.Sources.RealExpression globIrrTil(y=600) "[W/m2]"
    annotation (Placement(transformation(extent={{-47.5,26},{-28.5,42}})));
equation
  connect(weaDat.weaBus, heaLosQuaDyn.weaBus) annotation (Line(
      points={{-64,80},{68,80},{68,29.2},{73.6,29.2}},
      color={255,204,51},
      thickness=0.5));
  connect(heaLosQuaDyn.HGloHor, globIrrTil.y) annotation (Line(points={{72,20.6},
          {-24,20.6},{-24,34},{-27.55,34}}, color={0,0,127}));
  connect(T3.y, heaLosQuaDyn.TFlu[1]) annotation (Line(points={{-29,-40},{62,
          -40},{62,16.9333},{72,16.9333}},
                                      color={0,0,127}));
  connect(T2.y, heaLosQuaDyn.TFlu[2]) annotation (Line(points={{11,-60},{62,-60},
          {62,17.6},{72,17.6}}, color={0,0,127}));
  connect(T1.y, heaLosQuaDyn.TFlu[3]) annotation (Line(points={{51,-80},{62,-80},
          {62,18.2667},{72,18.2667}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This examples demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
Mar 27, 2013 by Peter Grant:<br/>
First implementation.
</li>
</ul>
  </html>"),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/BaseClasses/Examples/EN12975HeatLoss.mos"
        "Simulate and plot"),
        experiment(Tolerance=1e-6, StopTime=100));
end ISO9806HeatLoss;

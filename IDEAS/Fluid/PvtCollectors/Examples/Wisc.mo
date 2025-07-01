within IDEAS.Fluid.PvtCollectors.Examples;
model Wisc "Test model for uncovered (WISC) PVT collectors"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Incompressible.Examples.Glycol47
    "Medium in the system";

  IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
    Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-28,60},{-8,80}})));
  IDEAS.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 100000,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
    redeclare package Medium = Medium,
    T_start(displayUnit="K"),
    m_flow_nominal=pvtCol.m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
    Medium, m_flow_nominal=pvtCol.m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    use_p_in=true) "Inlet for water flow"
    annotation (Placement(
      transformation(
      extent={{10,-10},{-10,10}},
      rotation=180,
      origin={-48,0})));
  Modelica.Blocks.Sources.Sine sine(
    f=3/86400,
    amplitude=-pvtCol.dp_nominal,
    offset=1E5) "Pressure source"
    annotation (Placement(transformation(extent={{-88,-18},{-68,2}})));
  IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector pvtCol(
    redeclare package Medium = Medium,
    show_T=true,
    azi=0,
    til=0.78539816339745,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPvtCol,
    collectorType=IDEAS.Fluid.PvtCollectors.Types.CollectorType.Uncovered)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  parameter IDEAS.Fluid.PvtCollectors.Data.Uncoverd.UI_TRNSYSValidation datPvtCol
    annotation (Placement(transformation(extent={{64,64},{84,84}})));
equation
  connect(sou.ports[1], TIn.port_a) annotation (Line(
      points={{-38,0},{-28,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TOut.port_b, sin.ports[1])
    annotation (Line(points={{52,0},{62,0}},              color={0,127,255}));
  connect(sine.y, sou.p_in) annotation (Line(points={{-67,-8},{-60,-8}},
                           color={0,0,127}));
  connect(pvtCol.weaBus, weaDat.weaBus) annotation (Line(
      points={{0,8},{-4,8},{-4,70},{-8,70}},
      color={255,204,51},
      thickness=0.5));
  connect(TIn.port_b, pvtCol.port_a)
    annotation (Line(points={{-8,0},{0,0}}, color={0,127,255}));
  connect(pvtCol.port_b, TOut.port_a)
    annotation (Line(points={{20,0},{32,0}}, color={0,127,255}));
  annotation (
    Documentation(info="<html>
<p>
This example demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector\">
IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector</a>
for a variable fluid flow rate and weather data from San Francisco, CA, USA.
</p>
</html>",
revisions="<html>
<ul>
<li>
June 16, 2025, by Lone Meertens:<br/>
Added test model for an uncovered quasi-dynamic PVT collector (WISC)
with variable mass flow and weather data input.
Tracked in
<a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
IDEAS, #1436</a>.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlate.mos"
        "Simulate and plot"),
 experiment(Tolerance=1e-6, StopTime=86400.0));
end Wisc;

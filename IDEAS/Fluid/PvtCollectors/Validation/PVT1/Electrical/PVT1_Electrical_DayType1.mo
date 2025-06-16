within IDEAS.Fluid.PvtCollectors.Validation.PVT1.Electrical;
model PVT1_Electrical_DayType1
  "Test model for uncovered (WISC) PVT collectors"
  import Buildings;
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Water "Medium model";
  parameter String pvtTyp = "Typ1";
  parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature";

  parameter Data.Uncovered.UI_TRNSYSValidation datPvtCol
    annotation (Placement(transformation(extent={{60,56},{80,76}})));

  QDPvtCollectorValidationPVT1 PvtCol(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start(displayUnit="K") = T_start,
    show_T=true,
    azi=0,
    til(displayUnit="deg") = 0.78539816339745,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPvtCol,
    pLossFactor=0.07,
    collectorType=IDEAS.Fluid.PvtCollectors.Types.CollectorType.Uncovered)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT1/PVT1_" + pvtTyp + "_measurements.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{-92,24},{-72,44}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel annotation (Placement(transformation(extent={{-87,-1},
            {-77,9}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-10},{42,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T bou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  Modelica.Blocks.Sources.RealExpression meaPel(y=meaDat.y[21]) "[W]"
    annotation (Placement(transformation(extent={{-77,-82},{-51,-66}})));
  Modelica.Blocks.Sources.RealExpression c1_c2_term(y=PvtCol.heaLos.c1_c2_term) "[W]"
          annotation (Placement(transformation(extent={{25,-74},{51,-58}})));
  Modelica.Blocks.Sources.RealExpression c3_term(y=PvtCol.heaLos.c3_term) "[W]"
    annotation (Placement(transformation(extent={{25,-90},{51,-74}})));
  Modelica.Blocks.Sources.RealExpression c4_term(y=PvtCol.heaLos.c4_term) "[W]"
    annotation (Placement(transformation(extent={{63,-74},{89,-58}})));
  Modelica.Blocks.Sources.RealExpression c6_term(y=PvtCol.heaLos.c6_term) "[W]"
    annotation (Placement(transformation(extent={{63,-90},{89,-74}})));
  Modelica.Blocks.Sources.RealExpression simPel(y=PvtCol.pel) "[W]"
    annotation (Placement(transformation(extent={{-41,-82},{-15,-66}})));
equation

  connect(meaDat.y[13],TAmbKel. Celsius) annotation (Line(points={{-71,34},{-60,
          34},{-60,16},{-92,16},{-92,4},{-88,4}},                                                       color={0,0,127}));
  connect(bou.T_in, TAmbKel.Kelvin)
    annotation (Line(points={{-60,4},{-76.5,4}}, color={0,0,127}));
  connect(bou.m_flow_in, meaDat.y[17])
    annotation (Line(points={{-60,8},{-60,34},{-71,34}}, color={0,0,127}));
  connect(bou.ports[1], PvtCol.port_a)
    annotation (Line(points={{-38,0},{-10,0}}, color={0,127,255}));
  connect(PvtCol.port_b, sou.ports[1])
    annotation (Line(points={{10,0},{42,0}}, color={0,127,255}));
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
 experiment(
      StartTime=18872521.2,
      StopTime=18909241.2,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Diagram(graphics={
        Rectangle(extent={{12,-46},{96,-92}}, lineColor={28,108,200}),
        Text(
          extent={{14,-44},{96,-60}},
          textColor={28,108,200},
          textString="Distribution of heat losses ",
          textStyle={TextStyle.Bold}),
        Rectangle(extent={{-82,-46},{-10,-82}}, lineColor={28,108,200}),
        Text(
          extent={{-78,-54},{-6,-58}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Experimental and 
simulated pel")}));
end PVT1_Electrical_DayType1;

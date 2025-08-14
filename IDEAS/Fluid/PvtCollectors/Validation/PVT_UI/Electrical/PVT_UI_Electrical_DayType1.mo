within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Electrical;
model PVT_UI_Electrical_DayType1
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Water "Medium model";
  parameter String pvtTyp = "Typ1";
  parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature (from measurement data)";
  parameter Real eleLosFac = 0.09;

  parameter Data.Uncovered.UI_Validation datPvtCol
    annotation (Placement(transformation(extent={{60,56},{80,76}})));

  IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.PVTQuasiDynamicCollectorValidation
    PvtCol(
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
    eleLosFac=eleLosFac,
    collectorType=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT_UI/PVT_UI_" + pvtTyp + "_measurements.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{-92,24},{-72,44}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TFluKel annotation (Placement(transformation(extent={{-87,-1},
            {-77,9}})));
  IDEAS.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-10},{42,10}})));
  IDEAS.Fluid.Sources.MassFlowSource_T bou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  Modelica.Blocks.Sources.RealExpression meaPel(y=meaDat.y[21]) "[W]"
    annotation (Placement(transformation(extent={{-77,-82},{-51,-66}})));
  Modelica.Blocks.Sources.RealExpression UAbsFluid(y=PvtCol.eleGen.UAbsFluid)
    "[W/m2K]" annotation (Placement(transformation(extent={{15,-84},{41,-68}})));
  Modelica.Blocks.Sources.RealExpression simPel(y=PvtCol.pEl) "[W]"
    annotation (Placement(transformation(extent={{-41,-82},{-15,-66}})));
equation

  connect(meaDat.y[13],TFluKel. Celsius) annotation (Line(points={{-71,34},{-60,
          34},{-60,16},{-92,16},{-92,4},{-88,4}},                                                       color={0,0,127}));
  connect(bou.T_in,TFluKel. Kelvin)
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
See the documentation of
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">
IDEAS.Fluid.PVTCollectors.Validation.PVT_UI
</a>
for details on the validation examples and usage.
</p>
</html>", revisions=
        "<html>
<ul>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model; tracked in 
<a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
IDEAS #1436
</a>.
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
        Rectangle(extent={{12,-44},{46,-84}}, lineColor={28,108,200}),
        Text(
          extent={{8,-46},{48,-64}},
          textColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Calculated 
UAbsFluid 
[W/m2K]"),
        Rectangle(extent={{-82,-46},{-10,-82}}, lineColor={28,108,200}),
        Text(
          extent={{-80,-40},{-14,-68}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
electrical power")}));
end PVT_UI_Electrical_DayType1;

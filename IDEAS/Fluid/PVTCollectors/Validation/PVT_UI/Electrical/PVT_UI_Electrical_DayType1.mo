within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Electrical;
model PVT_UI_Electrical_DayType1
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Water "Medium model";
  parameter String pvtTyp = "Typ1";
  parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature (from measurement data)";
  parameter Real eleLosFac = 0.09;

  parameter Data.Uncovered.UI_Validation datPVTCol
    annotation (Placement(transformation(extent={{74,-26},{94,-6}})));

  IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.PVTCollectorValidation PvtCol(
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
    per=datPVTCol,
    eleLosFac=eleLosFac)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PVTCollectors/Validation/PVT_UI/PVT_UI_" + pvtTyp + "_measurements.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{-92,4},{-72,24}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TFluKel annotation (Placement(transformation(extent={{-87,-21},
            {-77,-11}})));
  IDEAS.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-30},{42,-10}})));
  IDEAS.Fluid.Sources.MassFlowSource_T bou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-30},{-38,-10}})));
  Modelica.Blocks.Sources.RealExpression meaPel(y=meaDat.y[21]) "[W]"
    annotation (Placement(transformation(extent={{-87,52},{-61,68}})));
  Modelica.Blocks.Sources.RealExpression UAbsFluid(y=PvtCol.eleGen.UAbsFluid)
    "[W/m2K]" annotation (Placement(transformation(extent={{11,46},{37,62}})));
  Modelica.Blocks.Sources.RealExpression simPel(y=PvtCol.Pel) "[W]"
    annotation (Placement(transformation(extent={{-51,52},{-25,68}})));
  IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.BaseClasses.ElectricalPV ElectricalPV(
    P_STC=datPVTCol.P_nominal,
    gamma=datPVTCol.gamma,
    eleLosFac=eleLosFac,
    n=1,
    module_efficiency=datPVTCol.etaEl,
    til=0.78539816339745,
    azi=0) annotation (Placement(transformation(extent={{-60,-82},{-80,-62}})));
  Modelica.Blocks.Sources.RealExpression simPelPV(y=ElectricalPV.P) "[W]"
    annotation (Placement(transformation(extent={{-49,-74},{-23,-58}})));
  Modelica.Blocks.Sources.RealExpression simTcellPV(y=ElectricalPV.T_cell -
        273.15) "[°C]"
    annotation (Placement(transformation(extent={{-49,-92},{-23,-76}})));
  Modelica.Blocks.Sources.RealExpression simTcell(y=PvtCol.eleGen.TavgCel -
        273.15) "[°C]"
    annotation (Placement(transformation(extent={{-51,40},{-25,56}})));
equation

  connect(meaDat.y[13],TFluKel. Celsius) annotation (Line(points={{-71,14},{-60,
          14},{-60,-4},{-92,-4},{-92,-16},{-88,-16}},                                                   color={0,0,127}));
  connect(bou.T_in,TFluKel. Kelvin)        annotation (Line(points={{-60,-16},{-76.5,
          -16}},                                                                        color={0,0,127}));
  connect(bou.m_flow_in, meaDat.y[17])
    annotation (Line(points={{-60,-12},{-60,14},{-71,14}},
                                                         color={0,0,127}));
  connect(bou.ports[1], PvtCol.port_a)
    annotation (Line(points={{-38,-20},{-10,-20}},
                                               color={0,127,255}));
  connect(PvtCol.port_b, sou.ports[1])
    annotation (Line(points={{10,-20},{42,-20}},
                                             color={0,127,255}));
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
March 11, 2026, by Lone Meertens:<br/>
Updated thermal formulation from ISO 9806:2013 to ISO 9806:2017 and added
conversion support.This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1473\">#1473</a>.
</li>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UI/Electrical/PVT_UI_Electrical_DayType1.mos"
        "Simulate and plot"),
 experiment(
      StartTime=18872521.2,
      StopTime=18909241.2,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Diagram(graphics={
        Rectangle(extent={{8,86},{42,46}},    lineColor={28,108,200}),
        Text(
          extent={{4,84},{44,66}},
          textColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Calculated 
UAbsFluid 
[W/m2K]"),
        Rectangle(extent={{-92,88},{-18,42}},   lineColor={28,108,200}),
        Text(
          extent={{-90,94},{-24,66}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
electrical power"),
        Rectangle(extent={{-88,-56},{-16,-92}}, lineColor={28,108,200})}));
end PVT_UI_Electrical_DayType1;

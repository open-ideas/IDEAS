within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Thermal;
model PVT_UI_Thermal_DayType1
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Water "Medium model";
  parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature (from measurement data)";
  parameter String pvtTyp = "Typ1";
  parameter Real eleLosFac = 0.09;
  parameter Data.Uncovered.UI_Validation datPVTCol
    annotation (Placement(transformation(extent={{72,-6},{92,14}})));
  parameter
    IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.BaseClasses.UI_Validation
    datPVTColVal
    annotation (Placement(transformation(extent={{72,-36},{92,-16}})));

  IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.PVTCollectorValidation pvtCol(
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
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PVTCollectors/Validation/PVT_UI/PVT_UI_" + pvtTyp + "_measurements.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{-92,24},{-72,44}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel annotation (Placement(transformation(extent={{-87,-1},
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
  Modelica.Blocks.Sources.RealExpression meaQ(y=meaDat.y[19]) "[W]"
    annotation (Placement(transformation(extent={{-81,60},{-55,76}})));
  Modelica.Blocks.Sources.RealExpression a1_a2_term(y=pvtCol.heaLosStc.a1_a2_term)
    "[W]" annotation (Placement(transformation(extent={{19,68},{45,84}})));
  Modelica.Blocks.Sources.RealExpression a3_term(y=pvtCol.heaLosStc.a3_term)
    "[W]" annotation (Placement(transformation(extent={{19,52},{45,68}})));
  Modelica.Blocks.Sources.RealExpression a4_term(y=pvtCol.heaLosStc.a4_term)
    "[W]" annotation (Placement(transformation(extent={{57,68},{83,84}})));
  Modelica.Blocks.Sources.RealExpression a6_term(y=pvtCol.heaLosStc.a6_term)
    "[W]" annotation (Placement(transformation(extent={{57,52},{83,68}})));
  Modelica.Blocks.Sources.RealExpression a7_term(y=pvtCol.heaLosStc.a7_term)
    "[W]" annotation (Placement(transformation(extent={{19,36},{45,52}})));
  Modelica.Blocks.Sources.RealExpression a8_term(y=pvtCol.heaLosStc.a8_term)
    "[W]" annotation (Placement(transformation(extent={{57,36},{83,52}})));
  Modelica.Blocks.Sources.RealExpression simQ(y=Medium.cp_const*pvtCol.port_b.m_flow
        *(pvtCol.sta_a.T -pvtCol.sta_b.T))  "[W]"
    annotation (Placement(transformation(extent={{-45,60},{-19,76}})));
  PVTCollectorValidation pvtColVal(
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
    per=datPVTColVal,
    eleLosFac=eleLosFac)
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel1
                                                         annotation (Placement(transformation(extent={{-87,-27},
            {-77,-17}})));
  Sources.Boundary_pT             sou1(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-36},{42,-16}})));
  Sources.MassFlowSource_T             bou1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-36},{-38,-16}})));

  Modelica.Blocks.Sources.RealExpression simQVal(y=Medium.cp_const*pvtColVal.port_b.m_flow
        *(pvtColVal.sta_a.T -pvtColVal.sta_b.T))  "[W]"
    annotation (Placement(transformation(extent={{-81,-86},{-55,-70}})));

  BoundaryConditions.WeatherData.ReaderTMY3       weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-40,18},{-20,38}})));
equation

  connect(meaDat.y[13],TAmbKel. Celsius) annotation (Line(points={{-71,34},{-60,
          34},{-60,16},{-92,16},{-92,4},{-88,4}},                                                       color={0,0,127}));
  connect(bou.T_in, TAmbKel.Kelvin)
    annotation (Line(points={{-60,4},{-76.5,4}}, color={0,0,127}));
  connect(bou.m_flow_in, meaDat.y[17])
    annotation (Line(points={{-60,8},{-60,34},{-71,34}}, color={0,0,127}));
  connect(bou.ports[1],pvtCol. port_a)
    annotation (Line(points={{-38,0},{-10,0}}, color={0,127,255}));
  connect(pvtCol.port_b, sou.ports[1])
    annotation (Line(points={{10,0},{42,0}}, color={0,127,255}));
  connect(meaDat.y[13], TAmbKel1.Celsius) annotation (Line(points={{-71,34},{-60,
          34},{-60,16},{-92,16},{-92,-22},{-88,-22}}, color={0,0,127}));
  connect(bou1.T_in, TAmbKel1.Kelvin)
    annotation (Line(points={{-60,-22},{-76.5,-22}}, color={0,0,127}));
  connect(bou1.m_flow_in, meaDat.y[17]) annotation (Line(points={{-60,-18},{-72,
          -18},{-72,-6},{-92,-6},{-92,16},{-60,16},{-60,34},{-71,34}}, color={0,
          0,127}));
  connect(bou1.ports[1],pvtColVal. port_a)
    annotation (Line(points={{-38,-26},{-10,-26}}, color={0,127,255}));
  connect(pvtColVal.port_b, sou1.ports[1])
    annotation (Line(points={{10,-26},{42,-26}}, color={0,127,255}));
  connect(weaDat.weaBus,pvtCol. weaBus) annotation (Line(
      points={{-20,28},{-16,28},{-16,6},{-10,6},{-10,8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,pvtColVal. weaBus) annotation (Line(
      points={{-20,28},{-16,28},{-16,-18},{-10,-18}},
      color={255,204,51},
      thickness=0.5));
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
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UI/Thermal/PVT_UI_Thermal_DayType1.mos"
        "Simulate and plot"),
 experiment(
      StartTime=18872521.2,
      StopTime=18908900.2,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Diagram(graphics={
        Rectangle(extent={{6,96},{92,34}},    lineColor={28,108,200}),
        Text(
          extent={{8,98},{90,82}},
          textColor={28,108,200},
          textString="Distribution of heat losses ",
          textStyle={TextStyle.Bold}),
        Rectangle(extent={{-86,96},{-14,60}},   lineColor={28,108,200}),
        Text(
          extent={{-84,96},{-14,80}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
thermal power"),
        Rectangle(extent={{-86,-52},{18,-86}},  lineColor={28,108,200}),
        Text(
          extent={{-84,-56},{2,-64}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Simulated thermal power, 
neglecting c3-, c4-, c6-, c7- and c8-term 
loss contributions")}));
end PVT_UI_Thermal_DayType1;

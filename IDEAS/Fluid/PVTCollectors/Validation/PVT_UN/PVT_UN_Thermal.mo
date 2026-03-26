within IDEAS.Fluid.PVTCollectors.Validation.PVT_UN;
model PVT_UN_Thermal
  "Thermal Behavior of Unglazed Rear-Non-Insulated PVT Collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Antifreeze.PropyleneGlycolWater (
  property_T = 293.15,
  X_a = 0.43);
  parameter String week = "week1";
  parameter Modelica.Units.SI.Temperature T_start = 17.086651 + 273.15 "Initial temperature (from measurement data)";
  parameter Real eleLosFac = 0.07;

  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PVTCollectors/Validation/PVT_UN/PVT_UN_measurements_"+week+".txt"),
    columns=1:26) annotation (Placement(transformation(extent={{-92,24},{-72,44}})));

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
  Modelica.Blocks.Sources.RealExpression meaQ(y=meaDat.y[24]) "[W]"
    annotation (Placement(transformation(extent={{-81,60},{-55,76}})));
  Modelica.Blocks.Sources.RealExpression simQ(y=Medium.cp_const*pvtCol.port_b.m_flow
        *(pvtCol.sta_a.T -pvtCol.sta_b.T))
                                      "[W]"
    annotation (Placement(transformation(extent={{-45,60},{-19,76}})));
  IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.PVTCollectorValidation pvtCol(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_start,
    show_T=true,
    azi=0,
    til=0.34906585039887,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPVTCol,
    eleLosFac=eleLosFac)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  parameter Data.Uncovered.UN_Validation datPVTCol
    annotation (Placement(transformation(extent={{70,-8},{90,12}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TFluKel1
                                                         annotation (Placement(transformation(extent={{-87,-33},
            {-77,-23}})));
  Sources.Boundary_pT             sou1(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-42},{42,-22}})));
  Sources.MassFlowSource_T             bou1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
  PVTCollectorValidation pvtColVal(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_start,
    show_T=true,
    azi=0,
    til=0.34906585039887,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPVTColVal,
    eleLosFac=eleLosFac)
    annotation (Placement(transformation(extent={{-8,-42},{12,-22}})));
  parameter BaseClasses.UN_Validation datPVTColVal
    annotation (Placement(transformation(extent={{70,-42},{90,-22}})));
  Modelica.Blocks.Sources.RealExpression simQVal(y=Medium.cp_const*pvtColVal.port_b.m_flow
        *(pvtColVal.sta_a.T -pvtColVal.sta_b.T))  "[W]"
    annotation (Placement(transformation(extent={{-81,-94},{-55,-78}})));
  Modelica.Blocks.Sources.RealExpression a1_a2_term(y=pvtCol.heaLosStc.a1_a2_term)
    "[W]" annotation (Placement(transformation(extent={{21,68},{47,84}})));
  Modelica.Blocks.Sources.RealExpression a3_term(y=pvtCol.heaLosStc.a3_term)
    "[W]" annotation (Placement(transformation(extent={{21,52},{47,68}})));
  Modelica.Blocks.Sources.RealExpression a4_term(y=pvtCol.heaLosStc.a4_term)
    "[W]" annotation (Placement(transformation(extent={{59,68},{85,84}})));
  Modelica.Blocks.Sources.RealExpression a6_term(y=pvtCol.heaLosStc.a6_term)
    "[W]" annotation (Placement(transformation(extent={{59,52},{85,68}})));
  Modelica.Blocks.Sources.RealExpression a7_term(y=pvtCol.heaLosStc.a7_term)
    "[W]" annotation (Placement(transformation(extent={{21,36},{47,52}})));
  Modelica.Blocks.Sources.RealExpression a8_term(y=pvtCol.heaLosStc.a8_term)
    "[W]" annotation (Placement(transformation(extent={{59,36},{85,52}})));
  BoundaryConditions.WeatherData.ReaderTMY3       weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
equation
  connect(bou.T_in,TFluKel. Kelvin)
    annotation (Line(points={{-60,4},{-76.5,4}}, color={0,0,127}));
  connect(pvtCol.port_a, bou.ports[1])
    annotation (Line(points={{-8,0},{-38,0}}, color={0,127,255}));
  connect(pvtCol.port_b, sou.ports[1])
    annotation (Line(points={{12,0},{42,0}}, color={0,127,255}));
  connect(bou.m_flow_in, meaDat.y[3])
    annotation (Line(points={{-60,8},{-60,34},{-71,34}}, color={0,0,127}));
  connect(meaDat.y[2],TFluKel. Celsius) annotation (Line(points={{-71,34},{-60,34},
          {-60,16},{-92,16},{-92,4},{-88,4}}, color={0,0,127}));
  connect(bou1.T_in, TFluKel1.Kelvin)
    annotation (Line(points={{-60,-28},{-76.5,-28}}, color={0,0,127}));
  connect(pvtColVal.port_a, bou1.ports[1])
    annotation (Line(points={{-8,-32},{-38,-32}}, color={0,127,255}));
  connect(pvtColVal.port_b, sou1.ports[1])
    annotation (Line(points={{12,-32},{42,-32}}, color={0,127,255}));
  connect(bou1.m_flow_in, meaDat.y[3]) annotation (Line(points={{-60,-24},{-72,
          -24},{-72,-6},{-92,-6},{-92,16},{-60,16},{-60,34},{-71,34}}, color={0,
          0,127}));
  connect(meaDat.y[2], TFluKel1.Celsius) annotation (Line(points={{-71,34},{-60,
          34},{-60,16},{-92,16},{-92,-28},{-88,-28}}, color={0,0,127}));
  connect(pvtCol.weaBus, weaDat.weaBus) annotation (Line(
      points={{-8,8},{-14,8},{-14,34},{-20,34}},
      color={255,204,51},
      thickness=0.5));
  connect(pvtColVal.weaBus, weaDat.weaBus) annotation (Line(
      points={{-8,-24},{-14,-24},{-14,34},{-20,34}},
      color={255,204,51},
      thickness=0.5));
  annotation ( Documentation(info =   "<html>
<p>
This model validates the thermal performance of the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">PVT_UN</a> collector, 
an uncovered and uninsulated PVT collector, using a long-term dataset from a test bench in Austria (Veynandt et al., 2023).
</p>
<p>
The model uses the quasi-dynamic ISO 9806:2017 formulation and includes:
</p>
<ul>
<li>
Linear and quadratic heat loss (<i>a<sub>1</sub></i>, <i>a<sub>2</sub></i>)
</li>
<li>
Wind‑dependent convective heat loss (<i>a<sub>3</sub></i>)
</li>
<li>
Sky‑temperature‑dependent radiative loss (<i>a<sub>4</sub></i>)
</li>
<li>
Effective thermal capacity (<i>a<sub>5</sub></i>)
</li>
<li>
Wind dependence of the zero‑loss efficiency (<i>a<sub>6</sub></i>)
</li>
<li>
Wind dependence of long‑wave radiative exchange (<i>a<sub>7</sub></i>)
</li>
<li>
Higher‑order temperature‑dependent radiation losses (<i>a<sub>8</sub></i>)
</li>
</ul>
<p>
The dataset includes days with several hours of high wind speeds up to <i>10–12&nbsp;m/s</i>, 
which significantly increase convective losses. 
Additionally, the circulation pump remains active throughout the test period, 
even when thermal output is negative—unlike real-world systems, which would deactivate the pump under such conditions.
</p>

<p>
Moreover, the experimental setup forces the collector to operate at unusually high
temperature differences between the HTF and the ambient air. This operating regime is 
not representative of practical unglazed PVT use, where collectors typically run at 
much lower temperatures due to their inherently high thermal losses.
</p>

<p>
As a result, the raw energy deviation of +54.9% is not a meaningful indicator of 
model performance. When filtered to periods with positive simulated thermal output, 
the deviation improves to +8.09% (Meertens et al., 2026). This filtered metric 
provides a more realistic assessment of the model's accuracy under these high operating 
temperatueres.
</p>

</html>",
revisions="<html>
<ul>
<li>
March 11, 2026, by Lone Meertens:<br/>
Updated thermal formulation from ISO 9806:2013 to ISO 9806:2017 and added
conversion support.This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1473\">#1473</a>.
</li>
<li>
September 3, 2025, by Jelger Jansen:<br/>
Introduce <code>week</code> parameter to change the weather dataset.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1462\">#1462</a>.
</li>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-86,96},{-14,60}},   lineColor={28,108,200}),
        Text(
          extent={{-84,96},{-14,80}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
thermal power"),
        Rectangle(extent={{-88,-56},{20,-94}},  lineColor={28,108,200}),
        Rectangle(extent={{8,96},{94,34}},    lineColor={28,108,200}),
        Text(
          extent={{10,98},{92,82}},
          textColor={28,108,200},
          textString="Distribution of heat losses ",
          textStyle={TextStyle.Bold}),
        Text(
          extent={{-82,-62},{4,-70}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Simulated thermal power, 
neglecting c3-, c4-, c6-, c7- and c8-term 
loss contributions")}),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UN/PVT_UN_Thermal.mos"
        "Simulate and plot"),
 experiment(
      StartTime=16502400,
      StopTime=21513595,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT_UN_Thermal;

within IDEAS.Fluid.PvtCollectors.Validation.PVT2.Thermal;
model PVT2_Thermal
  "Thermal Behavior of Unglazed Rear-Non-Insulated PVT Collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Antifreeze.PropyleneGlycolWater(
  property_T = 293.15,
  X_a = 0.43);
  parameter Modelica.Units.SI.Temperature T_start = 17.086651 + 273.15 "Initial temperature";

  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT2/PVT2_measurements.txt"),
    columns=1:26) annotation (Placement(transformation(extent={{-92,24},{-72,44}})));

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
  Modelica.Blocks.Sources.RealExpression meaQ(y=meaDat.y[24]) "[W]"
    annotation (Placement(transformation(extent={{-77,-82},{-51,-66}})));
  Modelica.Blocks.Sources.RealExpression c1_c2_term(y=PvtCol.heaLos.c1_c2_term) "[W]"
          annotation (Placement(transformation(extent={{25,-74},{51,-58}})));
  Modelica.Blocks.Sources.RealExpression c3_term(y=PvtCol.heaLos.c3_term) "[W]"
    annotation (Placement(transformation(extent={{25,-90},{51,-74}})));
  Modelica.Blocks.Sources.RealExpression c4_term(y=PvtCol.heaLos.c4_term) "[W]"
    annotation (Placement(transformation(extent={{63,-74},{89,-58}})));
  Modelica.Blocks.Sources.RealExpression c6_term(y=PvtCol.heaLos.c6_term) "[W]"
    annotation (Placement(transformation(extent={{63,-90},{89,-74}})));
  Modelica.Blocks.Sources.RealExpression simQ(y=Medium.cp_const*PvtCol.port_b.m_flow
        *(PvtCol.sta_a.T - PvtCol.sta_b.T))
                                      "[W]"
    annotation (Placement(transformation(extent={{-41,-82},{-15,-66}})));
  QDPvtCollectorValidationPVT2 PvtCol(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_start,
    show_T=true,
    azi=0,
    til=0.34906585039887,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPvtCol,
    pLossFactor=0.07,
    collectorType=IDEAS.Fluid.PvtCollectors.Types.CollectorType.Uncovered)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  parameter Data.Uncovered.UN_PVTHERMAU300 datPvtCol
    annotation (Placement(transformation(extent={{66,54},{86,74}})));
  inner BaseClasses.MySimInfoManager sim(filNam=
        Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT2/PVT2_Austria_wheaterData.mos"))
    annotation (Placement(transformation(extent={{-92,60},{-72,80}})));
equation
  connect(bou.T_in,TAmbKel. Kelvin)
    annotation (Line(points={{-60,4},{-76.5,4}}, color={0,0,127}));
  connect(PvtCol.port_a, bou.ports[1])
    annotation (Line(points={{-8,0},{-38,0}}, color={0,127,255}));
  connect(PvtCol.port_b, sou.ports[1])
    annotation (Line(points={{12,0},{42,0}}, color={0,127,255}));
  connect(bou.m_flow_in, meaDat.y[3])
    annotation (Line(points={{-60,8},{-60,34},{-71,34}}, color={0,0,127}));
  connect(meaDat.y[2], TAmbKel.Celsius) annotation (Line(points={{-71,34},{-60,34},
          {-60,16},{-92,16},{-92,4},{-88,4}}, color={0,0,127}));
  connect(sim.weaDatBus, PvtCol.weaBus) annotation (Line(
      points={{-72.1,70},{-14,70},{-14,8},{-8,8}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{12,-46},{96,-92}}, lineColor={28,108,200}),
        Text(
          extent={{14,-44},{96,-60}},
          textColor={28,108,200},
          textString="Distribution of heat losses ",
          textStyle={TextStyle.Bold}),
        Rectangle(extent={{-82,-46},{-10,-82}}, lineColor={28,108,200}),
        Text(
          extent={{-80,-46},{-10,-62}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
thermal power")}),experiment(
      StartTime=16502400,
      StopTime=21513595,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT2_Thermal;

within IDEAS.Fluid.PVTCollectors.Validation.PVT2;
model PVT2_Electrical
  "Electrical Behavior of Unglazed Rear-Non-Insulated PVT Collector"
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
  PVT2.PVTQuasiDynamicCollectorValidation PvtCol(
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
    collectorType=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  parameter Data.Uncovered.UN_Validation datPvtCol
    annotation (Placement(transformation(extent={{66,54},{86,74}})));
  inner PVT2.BaseClasses.MySimInfoManager sim(filNam=
        Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT2/PVT2_Austria_wheaterData.mos"))
    annotation (Placement(transformation(extent={{-92,60},{-72,80}})));
  Modelica.Blocks.Sources.RealExpression meaPel(y=meaDat.y[21]) "[W]"
    annotation (Placement(transformation(extent={{-75,-80},{-49,-64}})));
  Modelica.Blocks.Sources.RealExpression UAbsFluid(y=PvtCol.UAbsFluid)
    "[W/m2K]" annotation (Placement(transformation(extent={{17,-82},{43,-66}})));
  Modelica.Blocks.Sources.RealExpression simPel(y=PvtCol.pEl) "[W]"
    annotation (Placement(transformation(extent={{-39,-80},{-13,-64}})));
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
  annotation (Documentation(info=     "<html>
  <p>
  This model validates the electrical performance of the PVT2 collector, an uncovered and uninsulated PVT collector, using the same 58-day outdoor dataset as the thermal model (Veynandt et al., 2023).
  </p>

  <p>
  The model uses the PVWatts V5 formulation and includes:
  </p>
  <ul>
    <li>Temperature-dependent efficiency losses</li>
    <li>Datasheet-based estimation of <i>UAbsFluid</i></li>
    <li>Constant system loss factor (7%)</li>
  </ul>

  <p>
  The PV cell temperature is derived from the thermal model using a two-node coupling via <i>UAbsFluid</i>, ensuring accurate representation of the thermal-electrical interaction.
  </p>

  <p>
  Despite the presence of extreme weather conditions, including wind speeds up to 10–12&nbsp;m/s and continuous pump operation, the electrical model remains robust. Validation shows excellent agreement with measurements, with a normalized MAE of 5.2% and nRMSE of 9.9%.
  </p>

  <p>
  The model's accuracy confirms the reliability of the datasheet-based estimation method for <i>UAbsFluid</i>, even under challenging real-world conditions.
  </p>
  </html>",
revisions="<html>
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
   Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{14,-42},{48,-82}}, lineColor={28,108,200}),
        Text(
          extent={{10,-44},{50,-62}},
          textColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Calculated 
UAbsFluid 
[W/m2K]"),
        Rectangle(extent={{-80,-44},{-8,-80}},  lineColor={28,108,200}),
        Text(
          extent={{-78,-38},{-12,-66}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
electrical power")}),
                  experiment(
      StartTime=16502400,
      StopTime=21513595,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT2_Electrical;

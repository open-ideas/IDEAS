within IDEAS.Fluid.PVTCollectors.Validation.PVT_UN;
model PVT_UN_Electrical
  "Electrical behavior of an unglazed rear‑non‑insulated PVT collector"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Antifreeze.PropyleneGlycolWater (
    property_T = 293.15,
    X_a = 0.43);
  parameter String week = "week1";
  parameter Modelica.Units.SI.Temperature T_start = 17.086651 + 273.15 "Initial temperature (from measurement data)";
  parameter Real eleLosFac = 0.07;
  parameter IDEAS.Fluid.PVTCollectors.Data.Uncovered.UN_Validation datPVTCol
    annotation (Placement(transformation(extent={{72,-16},{92,4}})));


  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/Fluid/PVTCollectors/Validation/PVT_UN/PVT_UN_measurements_"+week+".txt"),
    columns=1:26) annotation (Placement(transformation(extent={{-92,14},{-72,34}})));

  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TFluKel annotation (Placement(transformation(extent={{-87,-11},
            {-77,-1}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel;

  IDEAS.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p = 101325,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{62,-20},{42,0}})));
  IDEAS.Fluid.Sources.MassFlowSource_T bou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0.03,
    use_T_in=true,
    nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
    annotation (Placement(transformation(extent={{-58,-20},{-38,0}})));
  IDEAS.Fluid.PVTCollectors.Validation.BaseClasses.PVTCollectorValidation pvtCol(
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
    annotation (Placement(transformation(extent={{-8,-20},{12,0}})));

  Modelica.Blocks.Sources.RealExpression meaPel(y=meaDat.y[19]) "[W]"
    annotation (Placement(transformation(extent={{-83,58},{-57,74}})));
  Modelica.Blocks.Sources.RealExpression UAbsFluid(y=pvtCol.eleGen.UAbsFluid)
    "[W/m2K]" annotation (Placement(transformation(extent={{9,56},{35,72}})));
  Modelica.Blocks.Sources.RealExpression simPel(y=pvtCol.Pel) "[W]"
    annotation (Placement(transformation(extent={{-47,58},{-21,74}})));
  IDEAS.Fluid.PVTCollectors.Validation.BaseClasses.ElectricalPV
    electricalPV(
    P_STC=datPVTCol.P_nominal,
    beta=datPVTCol.beta,
    eleLosFac=eleLosFac,
    n=1,
    module_efficiency=datPVTCol.etaEl,
    til=0.34906585039887,
    azi=0) annotation (Placement(transformation(extent={{-64,-72},{-84,-54}})));
  Modelica.Blocks.Sources.RealExpression simPelPV(y=electricalPV.P) "[W]"
    annotation (Placement(transformation(extent={{-53,-68},{-27,-52}})));
  Modelica.Blocks.Sources.RealExpression simTcell(y=pvtCol.eleGen.TavgCel -
        273.15) "[°C]"
    annotation (Placement(transformation(extent={{-47,44},{-21,60}})));
  Modelica.Blocks.Sources.RealExpression simTcellPV(y=electricalPV.T_cell -
        273.15) "[°C]"
    annotation (Placement(transformation(extent={{-53,-82},{-27,-66}})));
  IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-38,16},{-18,36}})));
equation
  connect(bou.T_in,TFluKel. Kelvin)
    annotation (Line(points={{-60,-6},{-76.5,-6}},
                                                 color={0,0,127}));
  connect(pvtCol.port_a, bou.ports[1])
    annotation (Line(points={{-8,-10},{-38,-10}},
                                              color={0,127,255}));
  connect(pvtCol.port_b, sou.ports[1])
    annotation (Line(points={{12,-10},{42,-10}},
                                             color={0,127,255}));
  connect(bou.m_flow_in, meaDat.y[3])
    annotation (Line(points={{-60,-2},{-60,24},{-71,24}},color={0,0,127}));
  connect(meaDat.y[2],TFluKel. Celsius) annotation (Line(points={{-71,24},{-60,
          24},{-60,6},{-92,6},{-92,-6},{-88,-6}}, color={0,0,127}));
  connect(weaDat.weaBus,pvtCol. weaBus) annotation (Line(
      points={{-18,26},{-14,26},{-14,-2},{-8,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(meaDat.y[4], electricalPV.Gtil);
  connect(meaDat.y[10], electricalPV.winSpe);
  connect(meaDat.y[5], TAmbKel.Celsius);
  connect(TAmbKel.Kelvin, electricalPV.Tamb);
  annotation (Documentation(info = "<html>
<p>
This model validates the electrical performance of the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">PVT_UN</a> collector, 
an uncovered and uninsulated PVT collector.
</p>
<p>
See the documentation of
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">
PVT_UN
</a>
for details on the validation model and usage.
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
        Rectangle(extent={{6,96},{40,56}},    lineColor={28,108,200}),
        Text(
          extent={{2,94},{42,76}},
          textColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Calculated 
UAbsFluid 
[W/m2K]"),
        Rectangle(extent={{-88,94},{-14,46}},   lineColor={28,108,200}),
        Text(
          extent={{-86,100},{-20,72}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Measured and simulated
electrical power"),
        Rectangle(extent={{-90,-48},{-18,-84}}, lineColor={28,108,200})}),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UN/PVT_UN_Electrical.mos"
        "Simulate and plot"),
 experiment(
      StartTime=16502400,
      StopTime=21513595,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT_UN_Electrical;

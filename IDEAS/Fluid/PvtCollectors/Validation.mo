within IDEAS.Fluid.PvtCollectors;
package Validation "Collection of validation models"
  extends Modelica.Icons.ExamplesPackage;

  model EN12975_Array
    "Validation model for collector according to EN12975 in array configuration"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=solCol.per.A*
        solCol.per.mperA_flow_nominal "Nominal mass flow rate";

    model Collector
      extends IDEAS.Fluid.SolarCollectors.EN12975(
      redeclare final package Medium = IDEAS.Media.Water,
      final show_T = true,
      final per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel(),
      final shaCoe=0,
      final azi=0,
      final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      final rho=0.2,
      final nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      final til=0.78539816339745,
      final use_shaCoe_in=false,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series);

    end Collector;

    Collector solCol(
      nPanels=4,
      nSeg=3,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array,
      nPanelsSer=2,
      nPanelsPar=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));

    Collector solCol1(nSeg=3, nPanels=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));

    Collector solCol2(nSeg=3, nPanels=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
        computeWetBulbTemperature=false)
      "Weather data file reader"
      annotation (Placement(transformation(extent={{-88,60},{-68,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal/2,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

    Sensors.TemperatureTwoPort senTem(
       redeclare package Medium = Medium,
       tau=0,
       m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,40},{40,20}})));
    Sensors.TemperatureTwoPort senTem1(
      redeclare package Medium = Medium,
      tau=0,
      m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
    Modelica.Blocks.Math.Add dT(final k2=-1) "Temperature difference (must be zero)"
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
    Sources.MassFlowSource_T                 bou2(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal/2,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-68,70},{-50,70},{-50,-22}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{-60,-30},{-50,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(solCol.port_a, bou.ports[1]) annotation (Line(points={{-20,30},{-60,30}},
                             color={0,127,255}));
    connect(solCol.weaBus, weaDat.weaBus) annotation (Line(
        points={{-20,38},{-24,38},{-24,70},{-68,70}},
        color={255,204,51},
        thickness=0.5));
    connect(weaDat.weaBus, solCol2.weaBus) annotation (Line(
        points={{-68,70},{-50,70},{-50,-62}},
        color={255,204,51},
        thickness=0.5));
    connect(solCol.port_b, senTem.port_a)
      annotation (Line(points={{0,30},{20,30}}, color={0,127,255}));
    connect(senTem.port_b, sou.ports[1])
      annotation (Line(points={{40,30},{60,30}}, color={0,127,255}));
    connect(sou1.ports[1], senTem1.port_b)
      annotation (Line(points={{60,-30},{40,-30}}, color={0,127,255}));
    connect(dT.u1, senTem.T) annotation (Line(points={{58,-64},{50,-64},{50,0},{30,
            0},{30,19}},  color={0,0,127}));
    connect(senTem1.T, dT.u2) annotation (Line(points={{30,-41},{30,-76},{58,-76}},
                                         color={0,0,127}));
    connect(bou2.ports[1], solCol2.port_a)
      annotation (Line(points={{-60,-70},{-50,-70}}, color={0,127,255}));
    connect(solCol1.port_b, senTem1.port_a)
      annotation (Line(points={{-30,-30},{20,-30}}, color={0,127,255}));
    connect(solCol2.port_b, senTem1.port_a) annotation (Line(points={{-30,-70},{-20,
            -70},{-20,-30},{20,-30}}, color={0,127,255}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>
for the case where one model has multiple panels in a 2x2 array,
versus the case where two models are in parallel,
each having two panels in series.
The output of the block <code>dT</code> must be zero,
as both cases must have the same outlet temperatures.
Furthermore, the pressure drops over all models should be the same.
</p>
</html>",   revisions="<html>
<ul>
<li>
February 27, 2024, by Jelger Jansen:<br/>
First implementation.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/EN12975_Array.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400));
  end EN12975_Array;

  model FlatPlateNPanels
    "Validation model for flat plate collector with different settings for nPanel"
    extends IDEAS.Fluid.SolarCollectors.Validation.FlatPlate;
    parameter Integer nPanels = 10 "Number of panels";
    IDEAS.Fluid.SolarCollectors.ASHRAE93
     solCol1(
      redeclare package Medium = Medium,
      shaCoe=0,
      azi=0,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_TRNSYSValidation(),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nSeg=30,
      til=0.78539816339745,
      nPanels=nPanels)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true)
      "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Math.Gain gaiNPan(k=nPanels) "Gain for number of panels"
      annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
    Modelica.Blocks.Sources.RealExpression difHeaGai(y=solCol.QGai[30].Q_flow -
          solCol1.QGai[30].Q_flow/nPanels)
      "Difference in heat gain at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
    Modelica.Blocks.Sources.RealExpression difHeaLos(y=solCol.QLos[30].Q_flow -
          solCol1.QLos[30].Q_flow/nPanels)
      "Difference in heat loss at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-20,70},{20,70},{20,-32},{30,-32}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{10,-40},{30,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(add.y, bou1.T_in) annotation (Line(
        points={{-29,10},{-24,10},{-24,-36},{-12,-36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sou1.ports[1], solCol1.port_b) annotation (Line(
        points={{70,-40},{50,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(gaiNPan.y, bou1.m_flow_in)
      annotation (Line(points={{-29,-20},{-20,-20},{-20,-32},{-12,-32}},
                                                     color={0,0,127}));
    connect(gaiNPan.u, datRea.y[4]) annotation (Line(points={{-52,-20},{-64,-20},
            {-64,30},{-69,30}},color={0,0,127}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a>
for the case
where the number of panels is <i>1</i> for the instance <code>solCol</code>
and <i>10</i> for the instance <code>solCol1</code>.
The instances <code>difHeaGai</code> and <code>difHeaLos</code>
compare the heat gain and heat loss between the two models.
The output of these blocks should be zero, except for rounding errors.
</p>
</html>",
  revisions="<html>
<ul>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
November 21, 2017, by Michael Wetter:<br/>
First implementation to validate
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1073\">#1073</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/FlatPlateNPanels.mos"
      "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=86400));
  end FlatPlateNPanels;

  model Typ1
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium model";
    parameter String pvtTyp = "Typ1";
    parameter String datSet = "DatasetA";
    parameter Integer nSeg = 3 "Number of segments used to discretize the collector model";
    parameter Real U_pvt = 32.76 "Heat transfer coefficient between thermal and electrical part of pvt";
    // Define the PVT data once and reuse it throughout the model
    parameter IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per = IDEAS.Fluid.PvtCollectors.Data.WISC.WISC_TRNSYSValidation() "PVT data structure";
    parameter Real CTot = per.C "Total capacity of collector (J/K)";
    parameter Real rho = 0.2;
    parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature";
    parameter Modelica.Units.SI.Area totalArea = 1.66 "Total area of panels in the simulation";
    parameter Real n = 1;
    parameter Modelica.Units.SI.Angle til = 0.78539816339745 "Surface tilt of the photovoltaic installation (0°=horizontal, 90°=vertical)";
    parameter Modelica.Units.SI.Angle azi = 0 "Surface azimuth (0°=south, 90°=west, 180°=north, 270°=east)";
    parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma = -0.0041 "Temperature coefficient of the photovoltaic panel(s)";
    parameter Real tolEl = 1.0 "Tolerenace on electrical power output following datasheet";
    parameter Modelica.Units.SI.Power P_STC = tolEl*280 "Power of one photovoltaic panel at Standard Conditions, usually equal to power at Maximum Power Point (MPP)";
    parameter Modelica.Units.SI.Efficiency module_efficiency = 0.1687 "Module efficiency of the photovoltaic installation";
    parameter Real P_loss_factor = 0.07;

    inner IDEAS.BoundaryConditions.SimInfoManager sim(final filNam=Modelica.Utilities.Files.loadResource(
    "modelica://PvtMod/Resources/Validation/WeatherData/" + datSet + "/" + pvtTyp +
          "_PVT-A_Messdaten_Trnsys.mos"))
          annotation (Placement(transformation(extent={{-112,98},{-92,118}})));
    inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
      tableOnFile=true,
      tableName="data",
      fileName= Modelica.Utilities.Files.loadResource(
      "modelica://PvtMod/Resources/Validation/MeasurementData/" + datSet + "/" + pvtTyp + "_modelica.txt"),
      columns=1:25) annotation (Placement(transformation(extent={{-112,58},{-92,78}})));

    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel annotation (Placement(transformation(extent={{-77,63},
              {-67,73}})));

    IDEAS.Fluid.Sources.Boundary_pT sou6(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{72,54},{52,74}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou6(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      m_flow=0.03,
      use_T_in=true,
      nPorts=1) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
    IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector pvt(
      redeclare package Medium = Medium,
      rho=rho,
      CTot=CTot,
      nPanels=1,
      per=per,
      P_loss_factor=P_loss_factor,
      U_pvt=U_pvt,
      shaCoe=0,
      azi=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Area,
      nSeg=nSeg,
      til=til,
      totalArea=totalArea,
      P_STC=P_STC,
      gamma=gamma,
      T_start=T_start,
      show_T=true) annotation (Placement(transformation(extent={{4,54},{24,74}})));

  equation
    connect(meaDat.y[13], TAmbKel.Celsius) annotation (Line(points={{-91,68},{-78,
            68}},                                                                                         color={0,0,127}));
    connect(bou6.T_in, TAmbKel.Kelvin) annotation (Line(points={{-50,68},{-66.5,68}},
                                  color={0,0,127}));
    connect(bou6.ports[1], pvt.port_a)
      annotation (Line(points={{-28,64},{4,64}}, color={0,127,255}));
    connect(pvt.port_b, sou6.ports[1])
      annotation (Line(points={{24,64},{52,64}}, color={0,127,255}));
    connect(pvt.weaBus, sim.weaDatBus) annotation (Line(
        points={{4,72},{-22,72},{-22,108},{-92.1,108}},
        color={255,204,51},
        thickness=0.5));
    connect(bou6.m_flow_in, meaDat.y[17]) annotation (Line(points={{-50,72},{-64,72},
            {-64,78},{-84,78},{-84,68},{-91,68}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-100},{200,140}},
          grid={2,2})),                                            Diagram(
          coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-100},{200,140}},
          grid={2,2})),
      experiment(
        StartTime=18872521.2,
        StopTime=18909241.2,
        Interval=60,
        Tolerance=1e-06,
        __Dymola_Algorithm="Cvode"));
  end Typ1;
annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains validation models for the classes in
<a href=\"modelica://IDEAS.Fluid.SolarCollectors\">
IDEAS.Fluid.SolarCollectors</a>.
</p>
<p>
Note that most validation models contain simple input data
which may not be realistic, but for which the correct
output can be obtained through an analytic solution.
The examples plot various outputs, which have been verified against these
solutions. These model outputs are stored as reference data and
used for continuous validation whenever models in the library change.
</p>
</html>"));
end Validation;

within IDEAS.Fluid.PvtCollectors.Validation;
model Typ1
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Water "Medium model";
  parameter String pvtTyp = "Typ1";
  parameter String datSet = "DatasetA";
  parameter Integer nSeg = 3 "Number of segments used to discretize the collector model";
  parameter Real uPvt  = 32.76 "Heat transfer coefficient between thermal and electrical part of pvt";
  // Define the PVT data once and reuse it throughout the model
  parameter IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per=
      IDEAS.Fluid.PvtCollectors.Data.Uncovered.UI_TRNSYSValidation()
    "PVT data structure";
  parameter Real CTot = per.C "Total capacity of collector (J/K)";
  parameter Real rho = 0.2;
  parameter Modelica.Units.SI.Temperature T_start = 30.65195319 + 273.15 "Initial temperature";
  parameter Modelica.Units.SI.Area totalArea = 1.66 "Total area of panels in the simulation";
  parameter Real n = 1;
  parameter Modelica.Units.SI.Angle til = 0.78539816339745 "Surface tilt of the photovoltaic installation (0°=horizontal, 90°=vertical)";
  parameter Modelica.Units.SI.Angle azi = 0 "Surface azimuth (0°=south, 90°=west, 180°=north, 270°=east)";
  parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma = -0.0041 "Temperature coefficient of the photovoltaic panel(s)";
  parameter Real tolEl = 1.0 "Tolerenace on electrical power output following datasheet";
  parameter Modelica.Units.SI.Power Pstc = tolEl*280 "Power of one photovoltaic panel at Standard Conditions, usually equal to power at Maximum Power Point (MPP)";
  parameter Real pLossFactor = 0.07;

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
    pLossFactor=pLossFactor,
    uPvt =uPvt,
    shaCoe=0,
    azi=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Area,
    nSeg=nSeg,
    til=til,
    totalArea=totalArea,
    Pstc=Pstc,
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

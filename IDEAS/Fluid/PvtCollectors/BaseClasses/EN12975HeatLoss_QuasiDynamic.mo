within IDEAS.Fluid.PvtCollectors.BaseClasses;
model EN12975HeatLoss_QuasiDynamic
  "Calculate the quasi-dynamic heat loss of a pvt/solar collector following ISO 9806:2013 quasi-dynamic method"
  extends Modelica.Blocks.Icons.Block;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system";
  parameter Integer nSeg = 3 "Number of segments";

  parameter Real c1(final unit="W/(m2.K)", final min=0)
    "Linear heat loss coefficient";
  parameter Real c2(final unit="W/(m2.K2)", final min=0)
    "Quadratic heat loss coefficient";
  parameter Real c3(final unit="J/(m3.K)", final min=0)
    "Windspeed dependence of heat losses";
  parameter Real c4(final unit="", final min=0)
    "Sky temperature dependence of the heat-loss coefficient";
  parameter Real c6(final unit="s/m", final min=0)
    "Windspeed dependence of zero-loss efficiency";
  parameter Real A_c(final unit="m2", final min=0)
    "Collector gross area";

  Modelica.Blocks.Interfaces.RealOutput QLos_flow[nSeg]
    "Limited heat loss rate at current conditions"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput G
    "Global solar irradiance [W/m2]"
    annotation (Placement(transformation(extent={{-140,-34},{-100,6}})));

  Modelica.Blocks.Interfaces.RealInput TFlu[nSeg]
    "Temperature of the heat transfer fluid [K]"
    annotation (Placement(transformation(extent={{-140,-64},{-100,-24}})));

   Modelica.Blocks.Interfaces.RealInput windSpePlane
    "Wind speed normal to collector plane (m/s)"
    annotation (Placement(transformation(extent={{-140,-92},{-100,-52}})));

  IDEAS.BoundaryConditions.WeatherData.Bus WeaBus
    "Bus with weather data"
    annotation (Placement(transformation(extent={{-114,62},{-94,82}})));

  IDEAS.Fluid.PvtCollectors.BaseClasses.PartialEN12975HeatLoss_QuasiDynamic
    partialLoss(
    redeclare package Medium = IDEAS.Media.Water,
    nSeg=nSeg,
    c1=c1,
    c2=c2,
    c3=c3,
    c4=c4,
    c6=c6,
    A_c=A_c) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(TFlu, partialLoss.TFlu);
  connect(G, partialLoss.G);
  connect(partialLoss.TEnv, WeaBus.TDryBul);
  connect(partialLoss.E_L, WeaBus.HHorIR);
  connect(partialLoss.u, windSpePlane);
  connect(partialLoss.QLos_flow, QLos_flow);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end EN12975HeatLoss_QuasiDynamic;

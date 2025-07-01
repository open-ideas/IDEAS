within IDEAS.Fluid.PvtCollectors.BaseClasses;
model EN12975QuasiDynamicHeatLoss
  "Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method"
  extends Modelica.Blocks.Icons.Block;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system";
  parameter Integer nSeg = 3 "Number of segments";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0)
    "Linear heat loss coefficient";
  parameter Real c2(final unit="W/(m2.K2)", final min=0)
    "Quadratic heat loss coefficient";
  parameter Modelica.Units.SI.SpecificHeatCapacity c3(final min=0)
    "Wind speed dependence of heat loss";
  parameter Modelica.Units.SI.DimensionlessRatio c4(final min=0)
    "Sky temperature dependence of the heat-loss coefficient";
  parameter Real c6(final unit="s/m", final min=0)
    "Wind speed dependence of zero-loss efficiency";
  parameter Modelica.Units.SI.Area A_c(final min=0)
    "Collector area";

  Modelica.Blocks.Interfaces.RealOutput QLos_flow[nSeg]
    "Limited heat loss rate at current conditions"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput HGloHor "Global solar irradiance [W/m2]"
    annotation (Placement(transformation(extent={{-140,-34},{-100,6}})));

  Modelica.Blocks.Interfaces.RealInput TFlu[nSeg]
    "Temperature of the heat transfer fluid [K]"
    annotation (Placement(transformation(extent={{-140,-64},{-100,-24}})));

   Modelica.Blocks.Interfaces.RealInput winSpePla
    "Wind speed normal to collector plane [m/s]"
    annotation (Placement(transformation(extent={{-140,-92},{-100,-52}})));

  IDEAS.BoundaryConditions.WeatherData.Bus weaBus
    "Bus with weather data"
    annotation (Placement(transformation(extent={{-114,62},{-94,82}})));

  IDEAS.Fluid.PvtCollectors.BaseClasses.PartialEN12975HeatLoss_QuasiDynamic partialLoss(
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
  connect(HGloHor, partialLoss.G);
  connect(partialLoss.TEnv,weaBus. TDryBul);
  connect(partialLoss.E_L,weaBus. HHorIR);
  connect(partialLoss.u, winSpePla);
  connect(partialLoss.QLos_flow, QLos_flow);

  annotation (
  defaultComponentName="heaLos",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method.</p>
</html>"));
end EN12975QuasiDynamicHeatLoss;

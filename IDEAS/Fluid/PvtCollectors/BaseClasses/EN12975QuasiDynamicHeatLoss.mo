within IDEAS.Fluid.PvtCollectors.BaseClasses;
model EN12975QuasiDynamicHeatLoss
  "Model to calculate the quasi-dynamic heat loss of a PVT/solar collector following the ISO 9806:2013 quasi-dynamic method, extending the EN12975HeatLoss base"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss(
    // Override the internal heat-loss expression to include c3, c4 and c6 terms
    QLos_internal=A_c/nSeg*{dT[i]*(c1 - c2*dT[i] + c3*winSpePla) + c4*(HHorIR
         - sigma*TEnv^4) - c6*winSpePla*HGloTil for i in 1:nSeg},
    // Map original a1, a2 to renamed c1, c2
    a1=c1,
    a2=c2);

  // —— Renamed EN12975 coefficients ——
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0)
    "Linear heat loss coefficient (alias for a1)";
  parameter Real c2(final unit="W/(m2.K2)", final min=0)
    "Quadratic heat loss coefficient (alias for a2)";

  // —— Additional quasi-dynamic coefficients ——
  parameter Modelica.Units.SI.SpecificHeatCapacity c3(final min=0)
    "Wind-speed dependence of heat loss";
  parameter Modelica.Units.SI.DimensionlessRatio c4(final min=0)
    "Sky long-wave irradiance dependence";
  parameter Real c6(final unit="s/m", final min=0)
    "Wind-speed × global irradiance dependence";

  // —— Physical constant ——
  parameter Real sigma = 5.67e-8
    "Stefan–Boltzmann constant [W/m².K⁴]";

  // Quasi-dynamic inputs
  Modelica.Blocks.Interfaces.RealInput winSpePla(
    quantity="Windspeed",
    unit="m/s",
    displayUnit="m/s")
    "Wind speed normal to collector plane";
  Modelica.Blocks.Interfaces.RealInput HGloTil(
    quantity="Global solar irradiance",
    unit="W/m2",
    displayUnit="W/m2")
    "Global irradiance on tilted plane";
  Modelica.Blocks.Interfaces.RealInput HHorIR(
    quantity="Long-wave solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "Long-wave (sky) irradiance [W/m2]" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}),   iconTransformation(extent={{-140,-20},{-100,20}})));

annotation (
    defaultComponentName="heaLos",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>\
<p>Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method.</p>\
</html>"));
end EN12975QuasiDynamicHeatLoss;

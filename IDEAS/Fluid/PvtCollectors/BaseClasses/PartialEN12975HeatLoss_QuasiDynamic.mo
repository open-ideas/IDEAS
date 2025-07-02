within IDEAS.Fluid.PvtCollectors.BaseClasses;
block PartialEN12975HeatLoss_QuasiDynamic
  "Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method"
  extends IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss(
    QLos_internal=A_c/nSeg*{dT[i] * (c1 - c2 * dT[i] + c3*u) + c4*(E_L - sigma*TEnv^4) - c6*u*G for i in 1:nSeg},
    a1=c1,
    a2=c2);

  // Required: define the renamed parameters
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0) "Linear heat loss coefficient (alias for a1)";
  parameter Real c2(final unit="W/(m2.K2)", final min=0) "Quadratic heat loss coefficient (alias for a2)";

// Constants
  parameter Real c3(final unit = "J/(m3.K)", final min=0) "a3 from ratings data";
  parameter Real c4(final unit = "", final min=0) "c4 from ratings data";
  parameter Real c6(final unit = "J/(m3.K)", final min=0) "c6 from ratings data";
  parameter Real sigma = 5.67e-8 "Stefan-Boltzmann constant [W/m²K^4]";

  // Inputs
   Modelica.Blocks.Interfaces.RealInput u(
    quantity="Windspeed",
    unit="m/s",
    displayUnit="m/s") "windspeed of surrounding air"
    annotation (Placement(transformation(extent={{-142,0},{-100,42}}),
        iconTransformation(extent={{-142,0},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput E_L(
    quantity="long-wave solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "Long-wave solar irradiance [W/m2]" annotation (Placement(
        transformation(extent={{-21,-21},{21,21}},
        rotation=0,
        origin={-121,-99}),  iconTransformation(
          extent={{-142,-120},{-100,-78}})));

   Modelica.Blocks.Interfaces.RealInput G(
    quantity="Global solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "global solar irradiance [W/m2]" annotation (Placement(
        transformation(extent={{-21,-21},{21,21}},
        rotation=0,
        origin={-121,-21}),                               iconTransformation(
          extent={{-140,-42},{-98,0}})));

  annotation (Documentation(info="<html>
<p>Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method.</p>
</html>"));
end PartialEN12975HeatLoss_QuasiDynamic;

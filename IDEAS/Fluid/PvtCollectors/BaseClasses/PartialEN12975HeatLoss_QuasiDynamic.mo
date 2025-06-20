within IDEAS.Fluid.PvtCollectors.BaseClasses;
block PartialEN12975HeatLoss_QuasiDynamic
  "Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method"
  extends IDEAS.Fluid.PvtCollectors.BaseClasses.EN12975HeatLoss(
    QLos_internal=A_c/nSeg*{dT[i] * (c1 - c2 * dT[i] + c3*u) + c4*(E_L - sigma*TEnv^4) -
        c6*u*G for i in 1:nSeg});

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
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput E_L(
    quantity="long-wave solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "Long-wave solar irradiance [W/m2]" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-100}), iconTransformation(
          extent={{-140,-120},{-100,-80}})));
   Modelica.Blocks.Interfaces.RealInput G(
    quantity="Global solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "global solar irradiance [W/m2]" annotation (Placement(
        transformation(extent={{-21,-21},{21,21}},
        rotation=0,
        origin={-121,-21}),                               iconTransformation(
          extent={{-140,-40},{-100,0}})));

  // Internal variables to be visible in simulation results
  Real c1_c2_term(unit="W");
  Real c3_term(unit="W");
  Real c4_term(unit="W");
  Real c6_term(unit="W");

  // Equations for terms
equation
    c1_c2_term = sum(A_c/nSeg*{dT[i]*(c1 - c2*dT[i]) for i in 1:nSeg});
    c3_term = sum(A_c/nSeg*{dT[i]*(c3*u) for i in 1:nSeg});
    c4_term = sum(A_c/nSeg*{c4*(E_L - sigma*TEnv^4) for i in 1:nSeg});
    c6_term = sum(A_c/nSeg*{(-1)* c6*u*G  for i in 1:nSeg});

  annotation (Documentation(info="<html>
<p>Model to calculate the quasi-dynamic heat loss of a pvt/solar collector following the ISO 9806:2013 quasi-dynamic method.</p></html>
</html>"));
end PartialEN12975HeatLoss_QuasiDynamic;

within IDEAS.Fluid.PvtCollectors.Validation.PVT1.BaseClasses;
block EN12975HeatLossValidationPVT1
  extends PvtMod.Components.Stc.BaseClasses.EN12975HeatLoss
                         (QLos_internal=A_c/nSeg*{dT[i]*(c1 - c2*(if linearize
         then -abs(dT_nominal) else dT[i]) + c3*u) + c4*(E_L - sigma*TEnv^4) -
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

  // Internal variables to be visible in simulation results
  Real c1_c2_term(unit="W");
  Real c3_term(unit="W");
  Real c4_term(unit="W");
  Real c6_term(unit="W");
  Real EL_term( unit="W/m2");

  Real pvt_st_st(unit="W");
  Real pvt_c3(unit="W");
  Real pvt_c4(unit="W");
  Real pvt_c6(unit="W");

  // Equations for terms
equation
    c1_c2_term = sum(A_c/nSeg*{dT[i]*(c1 - c2*(if linearize then -abs(dT_nominal) else dT[i])) for i in 1:nSeg});
    c3_term = sum(A_c/nSeg*{dT[i]*(c3*u) for i in 1:nSeg});
    c4_term = sum(A_c/nSeg*{c4*(E_L - sigma*TEnv^4) for i in 1:nSeg});
    EL_term = E_L - sigma*TEnv^4;
    c6_term = sum(A_c/nSeg*{(-1)* c6*u*G  for i in 1:nSeg});
    pvt_st_st = c1_c2_term;
    pvt_c3 = c1_c2_term + c3_term;
    pvt_c4 = c1_c2_term + c3_term + c4_term;
    pvt_c6 = c1_c2_term + c3_term + c4_term + c6_term;

end EN12975HeatLossValidationPVT1;

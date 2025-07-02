within IDEAS.Fluid.PvtCollectors.Validation.BaseClasses;
block EN12975QuasiDynamicHeatLossValidation
  extends IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss(
    QLos_internal=A_c/nSeg*{dT[i]*(c1 - c2*dT[i] + c3*winSpePla) + c4*(HHorIR
         - sigma*TEnv^4) - c6*winSpePla*HGloTil for i in 1:nSeg},
    a1=c1,
    a2=c2);

  // Required: define the renamed parameters
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0) "Linear heat loss coefficient (alias for a1)";
  parameter Real c2(final unit="W/(m2.K2)", final min=0) "Quadratic heat loss coefficient (alias for a2)";

  // Additional parameters (new to quasi-dynamic model)
  parameter Real c3(final unit = "J/(m3.K)", final min=0) "a3 from ratings data";
  parameter Real c4(final unit = "", final min=0) "c4 from ratings data";
  parameter Real c6(final unit = "J/(m3.K)", final min=0) "c6 from ratings data";
  parameter Real sigma = 5.67e-8 "Stefan-Boltzmann constant [W/m²K^4]";

  // Inputs
  Modelica.Blocks.Interfaces.RealInput winSpePla(
    quantity="Windspeed",
    unit="m/s",
    displayUnit="m/s")
    "windspeed of surrounding air measured in collector plane" annotation (
      Placement(transformation(extent={{-140,0},{-100,40}}), iconTransformation(
          extent={{-140,0},{-100,40}})));

  Modelica.Blocks.Interfaces.RealInput HHorIR(
    quantity="long-wave solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "Long-wave solar irradiance [W/m2]" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-100}), iconTransformation(extent={{-140,-120},{-100,-80}})));

  Modelica.Blocks.Interfaces.RealInput HGloTil(
    quantity="Global solar irradiance",
    unit="W/m2",
    displayUnit="W/m2") "global solar irradiance on tilted surface [W/m2]"
    annotation (Placement(transformation(
        extent={{-21,-21},{21,21}},
        rotation=0,
        origin={-121,-21}), iconTransformation(extent={{-140,-40},{-100,0}})));

  // Internal variables to be visible in simulation results
  Real c1_c2_term(unit="W");
  Real c3_term(unit="W");
  Real c4_term(unit="W");
  Real c6_term(unit="W");
  Real EL_term(unit="W/m2");

  Real pvt_st_st(unit="W");
  Real pvt_c3(unit="W");
  Real pvt_c4(unit="W");
  Real pvt_c6(unit="W");

equation
  c1_c2_term = sum(A_c/nSeg*{dT[i]*(c1 - c2*dT[i]) for i in 1:nSeg});
  c3_term =sum(A_c/nSeg*{dT[i]*c3*winSpePla for i in 1:nSeg});
  c4_term =sum(A_c/nSeg*{c4*(HHorIR - sigma*TEnv^4) for i in 1:nSeg});
  c6_term =sum(A_c/nSeg*{(-1)*c6*winSpePla*HGloTil for i in 1:nSeg});
  EL_term =HHorIR - sigma*TEnv^4;

  pvt_st_st = c1_c2_term;
  pvt_c3 = c1_c2_term + c3_term;
  pvt_c4 = pvt_c3 + c4_term;
  pvt_c6 = pvt_c4 + c6_term;

end EN12975QuasiDynamicHeatLossValidation;

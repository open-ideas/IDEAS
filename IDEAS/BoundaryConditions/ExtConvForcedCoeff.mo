within IDEAS.BoundaryConditions;
model ExtConvForcedCoeff
  "Calculates convection coefficient for forced flow at an exterior surface as a function of wind speed and direction"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle inc "Surface inclination";
  parameter Modelica.SIunits.Angle azi "Surface azimith";

  Modelica.Blocks.Interfaces.RealOutput hForcedConExt "Forced flow convective heat transfer coefficient at exterior surface" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Interfaces.RealInput Va "Wind speed" annotation (Placement(transformation(extent={{-126,-30},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput Vdir "Wind direction" annotation (Placement(transformation(extent={{-126,-58},{-100,-32}})));

  // If surface is horizontal then treat it as a ceiling or a floor.
  // If not horizontal, then treat the surface as vertical.
protected
  final parameter Boolean isCeiling=abs(sin(inc)) < 10E-5 and cos(inc) > 0
    "true if ceiling"
    annotation(Evaluate=true);
  final parameter Boolean isFloor=abs(sin(inc)) < 10E-5 and cos(inc) < 0
    "true if floor"
    annotation(Evaluate=true);

  // Only used to simulate with fixed conv coeffs: applies to all surfaces. ToDo: Move to Exterior Convection.
  //parameter Boolean UseFixedHTC=false "Set to true to use fixed conv coeffs";
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer fixedHTC=10 "Only used if UseFixedHTC=true";

  // Forced convection correlation coefficients based on MoWiTT test facility.
  // Taken from Table 3.9 of EnergyPlus Engineering Reference (p95).
  Real a;
  Real b;
  constant Real a_windward=3.26 "MoWiTT coeff";
  constant Real b_windward=0.89 "MoWiTT coeff";
  constant Real a_leeward=3.55 "MoWiTT coeff";
  constant Real b_leeward=0.617 "MoWiTT coeff";

  constant Modelica.SIunits.Angle WindwardVsLeeward=Modelica.SIunits.Conversions.from_deg(100)
    "Angle at which windward vs leeward transition occurs in MoWiTT model";
  constant Real cosWindwardVsLeeward=Modelica.Math.cos(WindwardVsLeeward)
    "Cosine of transition angle";

//   // Natural convection correlation coefficients based on TARP algorithm.
//   // Taken from Equations 3.75 to 3.77 of EnergyPlus Engineering Reference (p94).
//   constant Real C_vertical=1.31;
//   constant Real C_horz_buoyant=1.509;
//   constant Real C_horz_stable=0.76;
//   constant Real n=1/3;  // Question: Add annotate(Evaluate=true) ?

equation

  // Assign MoWiTT empirical coefficients according to whether surface is windward or leeward.
  // In this model a vertical surface is considered leeward if the wind angle is more than
  // 100 degrees from normal incidennce. Always treat ceilings as windward, and floors as leeward.
  // ToDo: What is EnergyPlus doing?
  if isCeiling then
    a = a_windward;
    b = b_windward;
  elseif isFloor then
    a = a_leeward;
    b = b_leeward;
  else // Treat as a vertical surface
    a = IDEAS.Utilities.Math.Functions.spliceFunction(
      pos=a_leeward,
      neg=a_windward,
      x=cosWindwardVsLeeward - Modelica.Math.cos(azi + Modelica.Constants.pi -
        Vdir),
      deltax=0.05);
    b = IDEAS.Utilities.Math.Functions.spliceFunction(
      pos=b_leeward,
      neg=b_windward,
      x=cosWindwardVsLeeward - Modelica.Math.cos(azi + Modelica.Constants.pi -
        Vdir),
      deltax=0.05);
  end if;

  hForcedConExt = a * Va^b;

  annotation (Documentation(revisions="<html>
<ul>
<li>
November 22, 2019, by Ian Beausoleil-Morrison:<br/>
First implementation.
</li>
</ul>
</html>"));
end ExtConvForcedCoeff;

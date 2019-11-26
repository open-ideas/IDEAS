within IDEAS.BoundaryConditions;
model ExtConvCoeff
  "Calculates convection coefficient at an exterior surface as a function of wind speed and direction"
    extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealOutput hConExt "Convective heat transfer coefficient at exterior surface" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Interfaces.RealInput Va "Wind speed" annotation (Placement(transformation(extent={{-126,-30},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput Vdir "Wind direction" annotation (Placement(transformation(extent={{-126,-58},{-100,-32}})));
  Modelica.Blocks.Interfaces.RealInput azi "Surface azimuth angle" annotation (Placement(transformation(extent={{-126,16},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput inc "surface tilt angle" annotation (Placement(transformation(extent={{-126,40},{-100,66}})));

protected
  Real hNatConExt;
  Real hForcedConExt;

  // Surfaces will be treated as ceilings or floors if they are horizontal; otherwise they will be treated as vertical.
  Real SurfType;
  parameter Real ceiling=1;
  parameter Real floor=2;
  parameter Real vertical=3;
//   parameter Real SurfType=
//       if IDEAS.Utilities.Math.Functions.isAngle(inc, 0) then ceiling
//       elseif IDEAS.Utilities.Math.Functions.isAngle(inc, Modelica.Constants.pi) then floor
//       else vertical
//   "" annotation (Evaluate=true);


  // Only used if simulation to be performed with fixed conv coeffs.
  parameter Boolean UseFixedHTC=true "Set to true to use fixed conv coeffs";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer fixedHTC=10 "Only used if UseFixedHTC=true";

  // Forced convection correlation coefficients based on MoWiTT test facility.
  // Taken from Table 3.9 of EnergyPlus Engineering Reference (p95).
  constant Real a_windward=3.26;
  constant Real b_windward=0.89;
  constant Real a_leeward=3.55;
  constant Real b_leeward=0.617;

equation

  // Determine how to treat the surface. If it is not close to horizontal then treat it as vertical.
  if IDEAS.Utilities.Math.Functions.isAngle(inc, 0) then
    SurfType = ceiling;
  elseif IDEAS.Utilities.Math.Functions.isAngle(inc, Modelica.Constants.pi) then
    SurfType = floor;
  else
    SurfType = vertical;
  end if;



  // Natural convection coefficient.
  if UseFixedHTC then
    hNatConExt = 0;
  else
    hNatConExt = 0;
//     if SurfType==ceiling then
//       hNatConExt = 99;
//     elseif SurfType==floor then
//       hNatConExt = 99;
//     else
//       hNatConExt = 99;
//     end if;
  end if;


  hForcedConExt = 10.; // Temporary for testing
  hConExt = ( hNatConExt^2 + hForcedConExt^2)^0.5;


  annotation (Documentation(revisions="<html>
<ul>
<li>
November 22, 2019, by Ian Beausoleil-Morrison:<br/>
First implementation.
</li>
</ul>
</html>"));
end ExtConvCoeff;

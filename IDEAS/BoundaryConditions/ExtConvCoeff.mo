within IDEAS.BoundaryConditions;
model ExtConvCoeff
  "Calculates convection coefficient at an exterior surface as a function of wind speed and direction"
    extends Modelica.Blocks.Icons.Block;

  Real LocalVar1;
  Real SurfType;

  Modelica.Blocks.Interfaces.RealOutput hConExt "Convective heat transfer coefficient at exterior surface" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));

  Modelica.Blocks.Interfaces.RealInput Va "Wind speed"
    annotation (Placement(transformation(extent={{-126,-30},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput Vdir "Wind direction"
    annotation (Placement(transformation(extent={{-126,-58},{-100,-32}})));
  Modelica.Blocks.Interfaces.RealInput azi "Surface azimuth angle"
    annotation (Placement(transformation(extent={{-126,16},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput tilt "surface tilt angle"
    annotation (Placement(transformation(extent={{-126,40},{-100,66}})));
equation
  hConExt = 10;
  LocalVar1 = 5 + Va;
  // LocalVar1 = 5;

  // SurfType=1 for ceilings; 2 for floors; 3 for walls.
  if IDEAS.Utilities.Math.Functions.isAngle(tilt, 0) then
    SurfType = 1;
  elseif IDEAS.Utilities.Math.Functions.isAngle(tilt, Modelica.Constants.pi) then
    SurfType = 2;
  else
    SurfType = 3;
  end if;


  annotation (Documentation(revisions="<html>
<ul>
<li>
November 22, 2019, by Ian Beausoleil-Morrison:<br/>
First implementation.
</li>
</ul>
</html>"));
end ExtConvCoeff;

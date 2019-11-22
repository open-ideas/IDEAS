within IDEAS.BoundaryConditions;
model ExtConvCoeff
  "Calculates convection coefficient at an exterior surface as a function of wind speed and direction"
    extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealOutput hConExt "Convective heat transfer coefficient at exterior surface" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  //WeatherData.Bus weaBus "Bus with weather data"
  //  annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  // Remove reference to weaBus as I will use connections to push wind speed and direction into here.

  Modelica.Blocks.Interfaces.RealInput Va "Wind speed"
    annotation (Placement(transformation(extent={{-126,18},{-100,44}})));
  Modelica.Blocks.Interfaces.RealInput Vdir "Wind direction"
    annotation (Placement(transformation(extent={{-126,-20},{-100,6}})));
equation
  hConExt = 10;

  annotation (Documentation(revisions="<html>
<ul>
<li>
November 22, 2019, by Ian Beausoleil-Morrison:<br/>
First implementation.
</li>
</ul>
</html>"));
end ExtConvCoeff;

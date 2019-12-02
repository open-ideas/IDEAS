within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.Examples;
model ExtConvForcedCoeff "Test for ExtConvForcedCoeff"
  extends Modelica.Icons.Example;
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExtConvForcedCoeff
    extConvForcedCoeffWall(inc=IDEAS.Types.Tilt.Wall, azi=IDEAS.Types.Azimuth.E)
    "Exterior forced convection for wall orientation"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Ramp winDir(
    height=4*Modelica.Constants.pi,
    duration=1,
    offset=-2*Modelica.Constants.pi) "Wind direction"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant winSpe(k=5) "Wind speed"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExtConvForcedCoeff
    extConvForcedCoeffCeiling(inc=IDEAS.Types.Tilt.Ceiling, azi=IDEAS.Types.Azimuth.E)
    "Exterior forced convection for ceiling orientation"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExtConvForcedCoeff
    extConvForcedCoeffFloor(inc=IDEAS.Types.Tilt.Floor, azi=IDEAS.Types.Azimuth.E)
    "Exterior forced convection for floor orientation"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(extConvForcedCoeffWall.Vdir, winDir.y) annotation (Line(points={{-21.3,
          45.5},{-59,45.5},{-59,10}}, color={0,0,127}));
  connect(winSpe.y, extConvForcedCoeffWall.Va) annotation (Line(points={{-59,50},
          {-40,50},{-40,48.3},{-21.3,48.3}}, color={0,0,127}));
  connect(extConvForcedCoeffCeiling.Va, winSpe.y) annotation (Line(points={{-21.3,
          8.3},{-40,8.3},{-40,50},{-59,50}}, color={0,0,127}));
  connect(extConvForcedCoeffFloor.Va, winSpe.y) annotation (Line(points={{-21.3,
          -31.7},{-40,-31.7},{-40,50},{-59,50}}, color={0,0,127}));
  connect(extConvForcedCoeffCeiling.Vdir, winDir.y) annotation (Line(points={{-21.3,
          5.5},{-59,5.5},{-59,10}}, color={0,0,127}));
  connect(extConvForcedCoeffFloor.Vdir, winDir.y) annotation (Line(points={{-21.3,
          -34.5},{-59,-34.5},{-59,10}}, color={0,0,127}));
  annotation (experiment(StopTime=1,Tolerance=1e-06, __Dymola_Algorithm="Lsodar"));
end ExtConvForcedCoeff;

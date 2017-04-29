within IDEAS.Buildings.Components.Examples;
model horizontalFins
  extends Modelica.Icons.Example;

  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = IDEAS.Media.Air,
    nSurf=2,
    V=60,
    hZone=3) annotation (Placement(transformation(extent={{0,20},{20,40}})));
  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = IDEAS.Media.Air,
    nSurf=2,
    V=60,
    hZone=3)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=15) annotation (Placement(transformation(extent={{-60,20},{-48,40}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=15)
    annotation (Placement(transformation(extent={{-60,-40},{-48,-20}})));
  IDEAS.Buildings.Components.Window window(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare IDEAS.Buildings.Data.Frames.Wood fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    annotation (Placement(transformation(extent={{-60,40},{-48,60}})));
  IDEAS.Buildings.Components.Window window1(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare IDEAS.Buildings.Data.Frames.Wood fraType,
    redeclare HorizontalFins.HorizontalFins shaType)
    annotation (Placement(transformation(extent={{-60,-20},{-48,0}})));
equation
  connect(zone.propsBus[1], outerWall.propsBus_a) annotation (Line(
      points={{0,35},{-24,35},{-24,32},{-49,32}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[2], window.propsBus_a) annotation (Line(
      points={{0,33},{0,33},{0,54},{0,52},{-49,52}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.propsBus[1], outerWall1.propsBus_a) annotation (Line(
      points={{0,-25},{-24,-25},{-24,-28},{-49,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.propsBus[2], window1.propsBus_a) annotation (Line(
      points={{0,-27},{0,-27},{0,-8},{-49,-8}},
      color={255,204,51},
      thickness=0.5));
  annotation ();
end horizontalFins;

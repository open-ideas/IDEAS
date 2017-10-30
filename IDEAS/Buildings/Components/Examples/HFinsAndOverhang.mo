within IDEAS.Buildings.Components.Examples;
model HFinsAndOverhang
  extends Modelica.Icons.Example;

  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = IDEAS.Media.Air,
    nSurf=2,
    V=60,
    hZone=3) annotation (Placement(transformation(extent={{0,48},{20,68}})));
  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = IDEAS.Media.Air,
    nSurf=2,
    V=60,
    hZone=3)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=15) annotation (Placement(transformation(extent={{-60,48},{-48,68}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=15)
    annotation (Placement(transformation(extent={{-60,0},{-48,20}})));
  IDEAS.Buildings.Components.Window window(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare IDEAS.Buildings.Data.Frames.Wood fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    annotation (Placement(transformation(extent={{-60,68},{-48,88}})));
  IDEAS.Buildings.Components.Window window1(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare IDEAS.Buildings.Data.Frames.Wood fraType,
    redeclare Shading.HorizontalFins shaType(
      l=1,
      D=0.3,
      w=0.001,
      beta=0.00017453292519943))
    annotation (Placement(transformation(extent={{-60,20},{-48,40}})));
  IDEAS.Buildings.Components.Zone zone2(
    redeclare package Medium = IDEAS.Media.Air,
    nSurf=2,
    V=60,
    hZone=3)
    annotation (Placement(transformation(extent={{0,-48},{20,-28}})));
  IDEAS.Buildings.Components.OuterWall outerWall2(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=15)
    annotation (Placement(transformation(extent={{-60,-48},{-48,-28}})));
  IDEAS.Buildings.Components.Window window2(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare IDEAS.Buildings.Data.Frames.Wood fraType,
    redeclare Shading.OverhangAndHFins shaType(
      hWin=2,
      wWin=1,
      dep=5,
      wLeft=5,
      wRight=5,
      gap=5,
      beta=0.00017453292519943,
      l=1,
      D=0.3,
      w=0.001))
    annotation (Placement(transformation(extent={{-60,-28},{-48,-8}})));
equation
  connect(zone.propsBus[1], outerWall.propsBus_a) annotation (Line(
      points={{0,63},{-24,63},{-24,60},{-49,60}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[2], window.propsBus_a) annotation (Line(
      points={{0,61},{0,61},{0,82},{0,80},{-49,80}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.propsBus[1], outerWall1.propsBus_a) annotation (Line(
      points={{0,15},{-24,15},{-24,12},{-49,12}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.propsBus[2], window1.propsBus_a) annotation (Line(
      points={{0,13},{0,13},{0,32},{-49,32}},
      color={255,204,51},
      thickness=0.5));
  connect(zone2.propsBus[1],outerWall2. propsBus_a) annotation (Line(
      points={{0,-33},{-34,-33},{-34,-36},{-49,-36}},
      color={255,204,51},
      thickness=0.5));
  connect(zone2.propsBus[2],window2. propsBus_a) annotation (Line(
      points={{0,-35},{0,-26},{-49,-26},{-49,-16}},
      color={255,204,51},
      thickness=0.5));
  annotation ();
end HFinsAndOverhang;

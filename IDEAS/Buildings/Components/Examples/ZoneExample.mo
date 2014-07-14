within IDEAS.Buildings.Components.Examples;
model ZoneExample
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  Zone zone(
    nSurf=5,
    redeclare package Medium = Medium,
    V=2) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  CommonWall commonWall(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    insulationThickness=0.1,
    AWall=10,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,-2},{-44,18}})));
  Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Fluid.Sources.MassFlowSource_T boundary(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

  inner SimInfoManager sim(use_lin=true)
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  CommonWall commonWall1(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    insulationThickness=0.1,
    AWall=10,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,-26},{-44,-6}})));
  Window window(
    A=1,
    inc=0,
    azi=0,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Interfaces.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    annotation (Placement(transformation(extent={{-54,-82},{-44,-62}})));
  SlabOnGround slabOnGround(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Pir insulationType,
    insulationThickness=0.1,
    AWall=20,
    PWall=3,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
  OuterWall outerWall(
    inc=0,
    azi=0,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Glasswool insulationType,
    AWall=10)
    annotation (Placement(transformation(extent={{-54,-58},{-44,-38}})));
  Interfaces.RadSolBus radSolBus
    annotation (Placement(transformation(extent={{-102,-70},{-62,-30}})));
  Interfaces.winSigBus winSigBus(nLay=window.glazing.nLay)
    annotation (Placement(transformation(extent={{-100,-98},{-60,-58}})));
  Modelica.Blocks.Sources.RealExpression[window.glazing.nLay] realExpression(
      each y=1)
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-120,-126},{-94,-106}})));
equation
  connect(commonWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-44,12},{-42,12},{-42,-4.4},{20,-4.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bou.ports[1], zone.flowPort_In) annotation (Line(
      points={{-40,90},{32,90},{32,4.44089e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], zone.flowPort_Out) annotation (Line(
      points={{-40,50},{28,50},{28,4.44089e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(commonWall1.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{-44,-12},{-42,-12},{-42,-5.2},{20,-5.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(window.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{-44,-68},{-32,-68},{-32,-6},{20,-6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slabOnGround.propsBus_a, zone.propsBus[4]) annotation (Line(
      points={{-44,34},{-28,34},{-28,-6.8},{20,-6.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(outerWall.propsBus_a, zone.propsBus[5]) annotation (Line(
      points={{-44,-44},{20,-44},{20,-7.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  if sim.use_lin then
    connect(outerWall.radSolBus, radSolBus);
    connect(window.winSigBus, winSigBus);
    connect(realExpression.y, winSigBus.QISolAbsSig) annotation (Line(
        points={{-89,-100},{-84,-100},{-84,-78},{-80,-78}},
        color={0,0,127},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(realExpression2.y, winSigBus.QISolDirSig) annotation (Line(
        points={{-92.7,-116},{-80,-116},{-80,-78}},
        color={0,0,127},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(realExpression2.y, winSigBus.QISolDifSig) annotation (Line(
        points={{-92.7,-116},{-80,-116},{-80,-78}},
        color={0,0,127},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    connect(realExpression2.y, radSolBus.solDir) annotation (Line(
      points={{-92.7,-116},{-82,-116},{-82,-50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    connect(realExpression2.y, radSolBus.solDif) annotation (Line(
      points={{-92.7,-116},{-82,-116},{-82,-50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ZoneExample;

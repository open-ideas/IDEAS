within IDEAS.Buildings.Linearisation.BaseClasses;
model LinCase900
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
        nWindow=3));
  package Medium = IDEAS.Media.Air;

  Components.LinZone        gF(
    V=129.6,
    corrCV=0.822,
    nSurf=9,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{50,-2},{90,38}})));
  Buildings.Components.OuterWall[4] wall(
    final AWall={21.6,16.2,9.6,16.2},
    final azi={IDEAS.Constants.North,IDEAS.Constants.East,IDEAS.Constants.South,
        IDEAS.Constants.West},
    final inc={IDEAS.Constants.Wall,IDEAS.Constants.Wall,IDEAS.Constants.Wall,
        IDEAS.Constants.Wall},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.foaminsulation insulationType,
    final insulationThickness={0.0615,0.0615,0.0615,0.0615},
    each T_start=293.15)      annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-39,-16})));

  Buildings.Components.BoundaryWall floor(
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.insulation insulationType,
    final insulationThickness=1.003,
    final AWall=48,
    final inc=IDEAS.Constants.Floor,
    final azi=IDEAS.Constants.South,
    T_start=293.15)                  annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-9,-16})));

  Buildings.Linearisation.Components.LinWindow[3] win(
    final A={6,6,6},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    each inc=IDEAS.Constants.Wall,
    each azi=IDEAS.Constants.South,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0,
    final indexWindow={1,2,3})
                       annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={21,-16})));
    //    eCon(linearise=false),
    //eConFra(linearise=true)
  Buildings.Components.OuterWall roof(
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.LightRoof constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.fiberglass insulationType,
    final insulationThickness=0.1118,
    final AWall=48,
    final inc=IDEAS.Constants.Ceiling,
    final azi=IDEAS.Constants.South,
    T_start=293.15) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-69,-16})));

  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{72,-30},{52,-10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
equation
   connect(roof.propsBus_a,gF. propsBus[1]) annotation (Line(
      points={{-73,-11},{-73,29.5556},{50,29.5556}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a,gF. propsBus[2:5]) annotation (Line(
      points={{-43,-11},{-43,26},{50,26}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(floor.propsBus_a,gF. propsBus[6]) annotation (Line(
      points={{-13,-11},{-13,25.1111},{50,25.1111}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(win.propsBus_a,gF. propsBus[7:9]) annotation (Line(
      points={{17,-11},{17,22.4444},{50,22.4444}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(const.y, win[1].Ctrl) annotation (Line(
      points={{51,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[2].Ctrl) annotation (Line(
      points={{51,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{51,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gF.TSensor, y) annotation (Line(
      points={{91.2,18},{106,18},{106,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html>
<p>Run script to linearise:</p>
<pre> 
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(&QUOT;IDEAS.Buildings.Linearisation.BaseClasses.LinCase900&QUOT;);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;A&QUOT;,matrix=re.A);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;B&QUOT;,matrix=re.B, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;C&QUOT;,matrix=re.C, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;D&QUOT;,matrix=re.D, append=true);</pre>
</html>", revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end LinCase900;

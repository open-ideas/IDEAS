within IDEAS.Buildings.Linearisation.Examples.BaseClasses;
model LinCase900
  import IDEAS;
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
        nWindow=3));
  package Medium = IDEAS.Media.Air;

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Formulation of energy balance";
  parameter SI.Temperature T_start=293.15
    "Start temperature for each of the layers";

  Components.LinZone        gF(
    V=129.6,
    corrCV=0.822,
    redeclare package Medium = Medium,
    T_start=T_start,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nSurf=10)
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
    each T_start=T_start,
    each energyDynamics=energyDynamics)
                              annotation (Placement(transformation(
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
    T_start=T_start,
    energyDynamics=energyDynamics)                 annotation (Placement(transformation(
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

  Buildings.Components.OuterWall roof(
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.LightRoof constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.fiberglass insulationType,
    final insulationThickness=0.1118,
    final AWall=48,
    final inc=IDEAS.Constants.Ceiling,
    final azi=IDEAS.Constants.South,
    T_start=T_start,
    energyDynamics=energyDynamics)
                    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-69,-16})));

  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{12,-48},{32,-28}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));

  IDEAS.Buildings.Components.SlabOnGround slabOnGround(
    inc=0,
    azi=0,
    insulationThickness=0.2,
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround constructionType,
    AWall=20,
    PWall=24,
    T_start=T_start,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) annotation (
      Placement(transformation(
        extent={{5,10},{-5,-10}},
        rotation=270,
        origin={51,-16})));

  IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=
       1) if gF.useFluidPorts annotation (Placement(transformation(extent={{20,60},{40,80}})));
  IDEAS.Utilities.IO.heatPortPrescribedHeatFlow heatPortPrescribedHeatFlow
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Interfaces.RealInput QCon
    annotation (Placement(transformation(extent={{-130,-80},{-90,-40}})));
  IDEAS.Utilities.IO.heatPortPrescribedHeatFlow heatPortPrescribedHeatFlow1
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Interfaces.RealInput QGaiRad
    annotation (Placement(transformation(extent={{-130,20},{-90,60}})));
equation
   connect(roof.propsBus_a,gF. propsBus[1]) annotation (Line(
      points={{-73,-11},{-73,29.6},{50,29.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a,gF. propsBus[2:5]) annotation (Line(
      points={{-43,-11},{-43,26.4},{50,26.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(floor.propsBus_a,gF. propsBus[6]) annotation (Line(
      points={{-13,-11},{-13,25.6},{50,25.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(win.propsBus_a,gF. propsBus[7:9]) annotation (Line(
      points={{17,-11},{17,23.2},{50,23.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(const.y, win[1].Ctrl) annotation (Line(
      points={{33,-38},{38,-38},{38,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[2].Ctrl) annotation (Line(
      points={{33,-38},{38,-38},{38,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{33,-38},{38,-38},{38,-20},{31,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gF.TSensor, y) annotation (Line(
      points={{91.2,18},{106,18},{106,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(slabOnGround.propsBus_a, gF.propsBus[10]) annotation (Line(
      points={{47,-11},{40,-11},{40,22.4},{50,22.4}},
      color={255,204,51},
      thickness=0.5));
  connect(bou.ports[1], gF.flowPort_Out)
    annotation (Line(points={{40,70},{66,70},{66,38}}, color={0,127,255}));
  connect(heatPortPrescribedHeatFlow.port1, gF.gainCon) annotation (Line(points
        ={{-20,-90},{94,-90},{94,-4},{102,-4},{102,12},{90,12}}, color={191,0,0}));
  connect(heatPortPrescribedHeatFlow.Q_flow, QCon) annotation (Line(points={{
          -40.8,-83},{-90,-83},{-90,-60},{-110,-60}}, color={0,0,127}));
  connect(heatPortPrescribedHeatFlow1.Q_flow, QGaiRad) annotation (Line(points=
          {{-40.8,-53},{-62,-53},{-62,-54},{-84,-54},{-84,40},{-110,40}}, color
        ={0,0,127}));
  connect(heatPortPrescribedHeatFlow1.port1, gF.gainRad) annotation (Line(
        points={{-20,-60},{32,-60},{88,-60},{88,-2},{96,-2},{96,6},{90,6}},
        color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html>
<p>
This example model is used to demonstrate the linearisation technique.
</p>
<p>Run script to linearise:</p>
<pre> 
OutputCPUtime:=false;
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(&QUOT;IDEAS.Buildings.Linearisation.Examples.BaseClasses.LinCase900&QUOT;);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;A&QUOT;,matrix=re.A);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;B&QUOT;,matrix=re.B, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;C&QUOT;,matrix=re.C, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;D&QUOT;,matrix=re.D, append=true);
OutputCPUtime:=true;
</pre>
</html>", revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    experiment(StopTime=1e+006, Tolerance=1e-007),
    __Dymola_experimentSetupOutput);
end LinCase900;

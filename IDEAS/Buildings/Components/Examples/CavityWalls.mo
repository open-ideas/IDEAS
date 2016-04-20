within IDEAS.Buildings.Components.Examples;
model CavityWalls
  "Check of air cavity models in glazing and partially filled cavity walls"
  package Medium = IDEAS.Media.Air;
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));

  extends Modelica.Icons.Example;
  IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=2)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    inc=IDEAS.Constants.Wall,
    azi=IDEAS.Constants.South,
    insulationThickness=0.1,
    redeclare parameter
      IDEAS.Buildings.Data.Constructions.CavityWallPartialFill
      constructionType,
    redeclare Data.Insulation.Rockwool insulationType,
    AWall=10) "Vertical wall with partially filled cavity"
    annotation (Placement(transformation(extent={{-54,-32},{-44,-12}})));

  IDEAS.Buildings.Components.Window winLin(
    A=1,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Constants.Wall,
    azi=IDEAS.Constants.South,
    redeclare Data.Glazing.Ins2Ar glazing,
    windowDynamicsType=IDEAS.Buildings.Components.BaseClasses.WindowDynamicsType.Two)
    "Window with linear convection correlations inside the window"
    annotation (Placement(transformation(extent={{-54,-56},{-44,-36}})));
equation
  connect(outerWall.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44,-18},{-28,-18},{-28,-16},{20,-16},{20,-57}},
      color={255,204,51},
      thickness=0.5));
  connect(winLin.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-44,-42},{-32,-42},{20,-42},{20,-55}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.flowPort_In, bou.ports[1])
    annotation (Line(points={{32,-50},{32,90},{-40,90}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/CavityWalls.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
February 16, 2016, by Glenn Reynders:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(StopTime=1e+06, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end CavityWalls;

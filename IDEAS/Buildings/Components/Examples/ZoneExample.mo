within IDEAS.Buildings.Components.Examples;
model ZoneExample
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Components.Interfaces.LinearisationInterface(sim(
        nWindow=1, linearise=false));
  LinZone
       zone(
    redeclare package Medium = Medium,
    V=2,
    allowFlowReversal=true,
    nSurf=2)
         annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  BoundaryWall
             commonWall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    insulationThickness=0.1,
    AWall=10,
    inc=0,
    azi=0)
    annotation (Placement(transformation(extent={{-54,-2},{-44,18}})));

  SlabOnGround slabOnGround(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Pir insulationType,
    insulationThickness=0.1,
    AWall=20,
    PWall=3,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
  OuterWall outerWall(
    inc=0,
    azi=0,
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Glasswool insulationType,
    AWall=10,
    insulationThickness=0)
    annotation (Placement(transformation(extent={{-54,-58},{-44,-38}})));
  LinZone
       zone1(
    nSurf=2,
    redeclare package Medium = Medium,
    V=2,
    allowFlowReversal=true)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  OuterWall outerWall1(
    inc=0,
    azi=0,
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Glasswool insulationType,
    AWall=10,
    insulationThickness=0)
    annotation (Placement(transformation(extent={{-44,-48},{-34,-28}})));
equation
  connect(commonWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-44,12},{-12,12},{-12,-5},{20,-5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(outerWall.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44,-44},{-14,-44},{-14,-57},{20,-57}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall1.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-34,-34},{-8,-34},{-8,-55},{20,-55}},
      color={255,204,51},
      thickness=0.5));
  connect(slabOnGround.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{-44,34},{-12,34},{-12,-7},{20,-7}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/ZoneExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
By Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneExample;

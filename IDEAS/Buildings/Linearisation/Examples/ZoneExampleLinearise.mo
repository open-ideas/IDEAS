within IDEAS.Buildings.Linearisation.Examples;
model ZoneExampleLinearise
  import IDEAS;
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(
                                                                       sim(nWindow=2,
        linearise=true));
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  Linearisation.Components.LinZone zone(
    redeclare package Medium = Medium,
    V=2,
    allowFlowReversal=true,
    nSurf=5) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  IDEAS.Buildings.Components.BoundaryWall commonWall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    insulationThickness=0.1,
    AWall=10,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,-2},{-44,18}})));

  IDEAS.Buildings.Components.InternalWall commonWall1(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    insulationThickness=0.1,
    AWall=10,
    inc=0,
    azi=0) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={11,-38})));

  Linearisation.Components.LinWindow window(
    A=1,
    inc=0,
    azi=0,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Interfaces.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.Screen shaType,
    final indexWindow=1)
    annotation (Placement(transformation(extent={{-54,-82},{-44,-62}})));
  IDEAS.Buildings.Components.SlabOnGround slabOnGround(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Pir insulationType,
    insulationThickness=0.1,
    AWall=20,
    PWall=3,
    inc=0,
    azi=0) annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    inc=0,
    azi=0,
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    redeclare parameter IDEAS.Buildings.Data.Insulation.Glasswool
      insulationType,
    AWall=10,
    insulationThickness=0)
    annotation (Placement(transformation(extent={{-54,-58},{-44,-38}})));
  Linearisation.Components.LinZone zone1(
    nSurf=2,
    redeclare package Medium = Medium,
    V=2,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.Shading.ShadingControl shadingControl
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Linearisation.Components.LinWindow window1(
    inc=0,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Interfaces.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.Screen shaType,
    azi=IDEAS.Constants.West,
    final indexWindow=2,
    A=2) annotation (Placement(transformation(extent={{-54,-26},{-44,-6}})));
  IDEAS.Buildings.Components.Shading.ShadingControl shadingControl1
    annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
equation
  connect(commonWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-44,12},{-12,12},{-12,-4.4},{20,-4.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(commonWall1.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{7,-33},{6,-33},{6,-5.2},{20,-5.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(window.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44,-68},{6,-68},{6,-57},{20,-57}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(outerWall.propsBus_a, zone.propsBus[4]) annotation (Line(
      points={{-44,-44},{-12,-44},{-12,-6.8},{20,-6.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slabOnGround.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{-44,34},{-12,34},{-12,-6},{20,-6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(commonWall1.propsBus_b, zone1.propsBus[1]) annotation (Line(
      points={{7,-43},{6.5,-43},{6.5,-55},{20,-55}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(shadingControl.y, window.Ctrl) annotation (Line(
      points={{-60,-84},{-58,-84},{-58,-86},{-53,-86},{-53,-82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shadingControl1.y, window1.Ctrl) annotation (Line(
      points={{-60,-28},{-58,-28},{-58,-30},{-53,-30},{-53,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(window1.propsBus_a, zone.propsBus[5]) annotation (Line(
      points={{-44,-12},{-12,-12},{-12,-7.6},{20,-7.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>
By Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>Linearise this model to obtain a state space model representation of the building model. Model IDEAS.Buildings.Linearisation.Examples.ZoneExampleCreateOutputs can be used to create a file with the state space model inputs.</p>
</html>"),
    experiment(StopTime=1e+006),
    __Dymola_experimentSetupOutput);
end ZoneExampleLinearise;

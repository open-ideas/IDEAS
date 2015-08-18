within IDEAS.Buildings.Linearisation.Examples;
model linCase900
  extends Modelica.Icons.Example;
  Components.StateSpace stateSpace
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  inner SimInfoManager sim(createOutputs=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Components.LinWindow[                        3] win(
    final A={6,6,6},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    each inc=IDEAS.Constants.Wall,
    each azi=IDEAS.Constants.South,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0,
    final indexWindow={1,2,3},
    createOutputs=true,
    linearise=true)    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-45,62})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
equation
  connect(const.y,win [3].Ctrl) annotation (Line(
      points={{-59,40},{-48,40},{-48,52},{-49,52}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end linCase900;

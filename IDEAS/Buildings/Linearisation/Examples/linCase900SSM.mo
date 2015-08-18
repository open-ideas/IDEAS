within IDEAS.Buildings.Linearisation.Examples;
model linCase900SSM
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Linearisation.Interfaces.StateSpaceModelInterface;

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
    removeDynamics=true)
                       annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-45,62})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Modelica.Blocks.Interfaces.RealOutput y1[size(ssm.y, 1)]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(const.y,win [3].Ctrl) annotation (Line(
      points={{-59,40},{-48,40},{-48,52},{-49,52}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ssm.y, y1) annotation (Line(points={{76.4,54},{80,54},{80,0},{100,0}},
        color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end linCase900SSM;

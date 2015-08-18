within IDEAS.Buildings.Linearisation.Examples;
model linCase900
  extends Modelica.Icons.Example;
  inner SimInfoManager sim(createOutputs=true, nWindow=3)
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
    removeDynamics=true)
                       annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-45,62})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  inner IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
    winBusOut(each nLay=sim.nLayWin) annotation (Placement(transformation(extent={{-20,-20},
            {20,20}},
        rotation=270,
        origin={-20,60})));
protected
  output IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
    windowBusOut(each nLay=sim.nLayWin) "Dummy for getting outputs"
                                annotation (Placement(transformation(extent={{-20,-20},
            {20,20}},
        rotation=270,
        origin={18,60})));
protected
  inner input IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
    winBusIn(each nLay=sim.nLayWin) if sim.linearise;
public
  Components.StateSpace stateSpace
    annotation (Placement(transformation(extent={{56,44},{76,64}})));
equation
  connect(const.y,win [3].Ctrl) annotation (Line(
      points={{-59,40},{-48,40},{-48,52},{-49,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowBusOut, winBusOut) annotation (Line(
      points={{18,60},{-20,60},{-20,60}},
      color={255,204,51},
      thickness=0.5));
  connect(windowBusOut, stateSpace.winBus) annotation (Line(
      points={{18,60},{37,60},{56,60}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end linCase900;

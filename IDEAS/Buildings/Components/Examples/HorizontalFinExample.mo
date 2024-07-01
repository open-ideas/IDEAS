within IDEAS.Buildings.Components.Examples;
model HorizontalFinExample "Examples of horizontal fin model"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
protected
  Interfaces.WeaBus                  weaBus(numSolBus=sim.numIncAndAziInBus)
    annotation (Placement(transformation(extent={{-64,24},{-44,44}})));
public
  Modelica.Blocks.Sources.Constant azi(k=IDEAS.Types.Azimuth.W)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant hWin(k=1) "Window height"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant wWin(k=2) "Window Width"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Shading.HorizontalFins horizontalFins(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0.5,
    haveBoundaryPorts=false,
    s=0.2,
    w=0.1,
    use_betaInput=false,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02) "Horizontal fin model with fins at 45 degrees"
    annotation (Placement(transformation(extent={{-16,20},{-6,40}})));
  Shading.HorizontalFins horizontalFinsBeta(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0.5,
    haveBoundaryPorts=false,
    s=0.2,
    w=0.1,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02,
    use_betaInput=true) "Horizontal fin model with control input for beta"
    annotation (Placement(transformation(extent={{24,20},{34,40}})));
  Shading.HorizontalFins horizontalFinsDisp(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0.5,
    haveBoundaryPorts=false,
    s=0.2,
    w=0.1,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02,
    use_displacementInput=true)
    "Horizontal fin model with control input for displacement"
    annotation (Placement(transformation(extent={{64,20},{74,40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    offset=0.5,
    f=1/30000) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Sources.Pulse pulse(period=3600*4)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Shading.HorizontalFins horizontalFinsOpen(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0.5,
    haveBoundaryPorts=false,
    s=0.2,
    w=0.1,
    use_betaInput=false,
    azi=azi.k,
    t=0.02,
    beta=0) "Horizontal fin model with opened fins"
    annotation (Placement(transformation(extent={{4,20},{14,40}})));
equation
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-81,1},{-81,34},{-54,34}},
      color={255,204,51},
      thickness=0.5));
  connect(horizontalFinsBeta.HDirTil, horizontalFins.HDirTil)
    annotation (Line(points={{26.5,30.6667},{18,30.6667},{18,30},{8.5,30},{8.5,
          30.6667},{-13.5,30.6667}},            color={0,0,127}));
  connect(horizontalFins.HGroDifTil, horizontalFinsBeta.HGroDifTil)
    annotation (Line(points={{-13.5,28},{-2,28},{-2,24},{8.5,24},{8.5,28},{26.5,
          28}},                                 color={0,0,127}));
  connect(horizontalFinsBeta.HSkyDifTil, horizontalFins.HSkyDifTil)
    annotation (Line(points={{26.5,29.3333},{18,29.3333},{18,30},{8.5,30},{8.5,
          29.3333},{-13.5,29.3333}},            color={0,0,127}));
  connect(horizontalFinsBeta.angInc, horizontalFins.angInc)
    annotation (Line(points={{26.5,24},{18,24},{18,22},{8.5,22},{8.5,24},{-13.5,
          24}},                                 color={0,0,127}));
  connect(horizontalFinsBeta.angZen, horizontalFins.angZen)
    annotation (Line(points={{26.5,22.6667},{18,22.6667},{18,22},{8.5,22},{8.5,
          22.6667},{-13.5,22.6667}},            color={0,0,127}));
  connect(horizontalFinsBeta.angAzi, horizontalFins.angAzi)
    annotation (Line(points={{26.5,21.3333},{18,21.3333},{18,22},{8.5,22},{8.5,
          21.3333},{-13.5,21.3333}},            color={0,0,127}));
  connect(horizontalFinsDisp.HDirTil, horizontalFinsBeta.HDirTil)
    annotation (Line(points={{66.5,30.6667},{58,30.6667},{58,30},{48.5,30},{
          48.5,30.6667},{26.5,30.6667}},       color={0,0,127}));
  connect(horizontalFinsDisp.HSkyDifTil, horizontalFinsBeta.HSkyDifTil)
    annotation (Line(points={{66.5,29.3333},{58,29.3333},{58,30},{48.5,30},{
          48.5,29.3333},{26.5,29.3333}},       color={0,0,127}));
  connect(horizontalFinsDisp.HGroDifTil, horizontalFinsBeta.HGroDifTil)
    annotation (Line(points={{66.5,28},{58,28},{58,24},{48.5,24},{48.5,28},{
          26.5,28}},                           color={0,0,127}));
  connect(horizontalFinsDisp.angInc, horizontalFinsBeta.angInc)
    annotation (Line(points={{66.5,24},{58,24},{58,22},{48.5,22},{48.5,24},{
          26.5,24}},                           color={0,0,127}));
  connect(horizontalFinsDisp.angZen, horizontalFinsBeta.angZen)
    annotation (Line(points={{66.5,22.6667},{58,22.6667},{58,22},{48.5,22},{
          48.5,22.6667},{26.5,22.6667}},       color={0,0,127}));
  connect(horizontalFinsDisp.angAzi, horizontalFinsBeta.angAzi)
    annotation (Line(points={{66.5,21.3333},{58,21.3333},{58,22},{48.5,22},{
          48.5,21.3333},{26.5,21.3333}},       color={0,0,127}));
  connect(sine.y, horizontalFinsBeta.Ctrl)
    annotation (Line(points={{21,-10},{29,-10},{29,20}}, color={0,0,127}));
  connect(pulse.y, horizontalFinsDisp.Ctrl)
    annotation (Line(points={{61,-10},{69,-10},{69,20}}, color={0,0,127}));
  connect(horizontalFins.angAzi, weaBus.solBus[3].angAzi) annotation (Line(points={{-13.5,
          21.3333},{-53.95,21.3333},{-53.95,34.05}},
                                                color={0,0,127}));
  connect(horizontalFins.angZen, weaBus.solBus[3].angZen) annotation (Line(points={{-13.5,
          22.6667},{-53.95,22.6667},{-53.95,34.05}},
                                                color={0,0,127}));
  connect(horizontalFins.angInc, weaBus.solBus[3].angInc) annotation (Line(points={{-13.5,
          24},{-53.95,24},{-53.95,34.05}},      color={0,0,127}));
  connect(horizontalFins.HGroDifTil, weaBus.solBus[3].HGroDifTil) annotation (Line(
        points={{-13.5,28},{-53.95,28},{-53.95,34.05}},
                                                      color={0,0,127}));
  connect(horizontalFins.HSkyDifTil, weaBus.solBus[3].HSkyDifTil) annotation (Line(
        points={{-13.5,29.3333},{-54,29.3333},{-54,34.05},{-53.95,34.05}},
                                                               color={0,0,127}));
  connect(horizontalFins.HDirTil, weaBus.solBus[3].HDirTil) annotation (Line(
        points={{-13.5,30.6667},{-53.95,30.6667},{-53.95,34.05}},
                                                      color={0,0,127}));
  connect(horizontalFinsOpen.HDirTil, horizontalFins.HDirTil)
    annotation (Line(points={{6.5,30.6667},{2,30.6667},{2,30},{2,25.3334},{2,
          30.6667},{-13.5,30.6667}},           color={0,0,127}));
  connect(horizontalFinsOpen.HSkyDifTil, horizontalFins.HSkyDifTil)
    annotation (Line(points={{6.5,29.3333},{2,29.3333},{2,30},{2,24.6666},{2,
          29.3333},{-13.5,29.3333}},           color={0,0,127}));
  connect(horizontalFinsOpen.HGroDifTil, horizontalFins.HGroDifTil)
    annotation (Line(points={{6.5,28},{2,28},{2,24},{-1.5,24},{-1.5,28},{-13.5,
          28}},                                color={0,0,127}));
  connect(horizontalFinsOpen.angInc, horizontalFins.angInc)
    annotation (Line(points={{6.5,24},{2,24},{2,22},{-1.5,22},{-1.5,24},{-13.5,
          24}},                                color={0,0,127}));
  connect(horizontalFinsOpen.angAzi, horizontalFins.angAzi)
    annotation (Line(points={{6.5,21.3333},{2,21.3333},{2,22},{-1.5,22},{-1.5,
          21.3333},{-13.5,21.3333}},           color={0,0,127}));
  connect(horizontalFinsOpen.angZen, horizontalFins.angZen)
    annotation (Line(points={{6.5,22.6667},{2,22.6667},{2,22},{-1.5,22},{-1.5,
          22.6667},{-13.5,22.6667}},           color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StartTime=2000000,
      StopTime=3000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/HorizontalFinExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
August 9, 2022, by Filip Jorissen:<br/>
Updated example after modified component connectors for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a>.
</li>
<li>
March 18, 2019, by Filip Jorissen:<br/>
First implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/992\">#992</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model demonstrates the impact of the BuildingShade component on the solar radiation.
</p>
</html>"));
end HorizontalFinExample;

within IDEAS.Buildings.Components.Examples;
model BuildingShadeExample
  extends Modelica.Icons.Example;
  Shading.BuildingShade buildingShade(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,
    azi=azi.k,
    haveBoundaryPorts=false,
    hWin=hWin.k,
    L=16,
    dh=9)
    annotation (Placement(transformation(extent={{-24,20},{-14,40}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Shading.None none(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,    
    azi=azi.k,
    haveBoundaryPorts=false)
    annotation (Placement(transformation(extent={{-24,60},{-14,80}})));
  Shading.Overhang overhang(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,
    azi=azi.k,
    haveBoundaryPorts=false,
    hWin=hWin.k,
    wWin=wWin.k,
    wLeft=0.5,
    wRight=0.5,
    dep=1,
    gap=0.3) annotation (Placement(transformation(extent={{-24,-20},{-14,0}})));
  Modelica.Blocks.Sources.Constant azi(k=IDEAS.Types.Azimuth.W)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant hWin(k=1) "Window height"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant wWin(k=2) "Window Width"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Shading.Screen screen(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,
    azi=azi.k,
    haveBoundaryPorts=false)
    annotation (Placement(transformation(extent={{-24,-60},{-14,-40}})));
  Modelica.Blocks.Sources.Cosine ctrl(
    amplitude=0.5,
    offset=0.5,
    f=1/3600/3) "Dummy control signal"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Shading.SideFins sideFins(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,
    azi=azi.k,
    haveBoundaryPorts=false,
    hWin=hWin.k,
    wWin=wWin.k,
    hFin=0.5,
    dep=0.5,
    gap=0.3)
    annotation (Placement(transformation(extent={{-24,-100},{-14,-80}})));
  Shading.HorizontalFins horizontalFins(
    A_glazing=0,
    A_frame=0,
    inc=0,
    epsSw_frame=1,
    epsLw_frame=1,
    epsLw_glazing=1,
    g_glazing=0,
    haveBoundaryPorts=false,
    s=0.2,
    w=0.1,
    use_betaInput=false,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02) "Horizontal fin model"
    annotation (Placement(transformation(extent={{14,20},{24,40}})));
  Modelica.Blocks.Sources.Constant m_flow(k=0) "Mass flow rate" annotation (Placement(visible = true, transformation(origin = {0, -60}, extent = {{-100, 20}, {-80, 40}}, rotation = 0)));
protected
  Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus)
    annotation (Placement(transformation(extent={{-64,24},{-44,44}})));
equation
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-81,1},{-81,34},{-54,34}},
      color={255,204,51},
      thickness=0.5));
  connect(buildingShade.HDirTil, weaBus.solBus[3].HDirTil) annotation (Line(points={{-21.5,
          30.6667},{-53.95,30.6667},{-53.95,34.05}},
                                                color={0,0,127}));
  connect(buildingShade.HSkyDifTil, weaBus.solBus[3].HSkyDifTil) annotation (Line(points={{-21.5,
          29.3333},{-53.95,29.3333},{-53.95,34.05}},
                                                color={0,0,127}));
  connect(buildingShade.angInc, weaBus.solBus[3].angInc) annotation (Line(points={{-21.5,
          24},{-53.95,24},{-53.95,34.05}},       color={0,0,127}));
  connect(buildingShade.angAzi, weaBus.solBus[3].angAzi) annotation (Line(points={{-21.5,
          21.3333},{-53.95,21.3333},{-53.95,34.05}},
                                                 color={0,0,127}));
  connect(buildingShade.angZen, weaBus.solBus[3].angZen) annotation (Line(points={{-21.5,
          22.6667},{-21.5,22.6667},{-53.95,22.6667},{-53.95,34.05}},
                                                           color={0,0,127}));
  connect(none.HDirTil, buildingShade.HDirTil) annotation (Line(points={{-21.5,
          70.6667},{-40,70.6667},{-40,30.6667},{-21.5,30.6667}},
                                      color={0,0,127}));
  connect(none.HSkyDifTil, buildingShade.HSkyDifTil) annotation (Line(points={{-21.5,
          69.3333},{-38,69.3333},{-38,29.3333},{-21.5,29.3333}},
                                      color={0,0,127}));
  connect(none.angInc, buildingShade.angInc) annotation (Line(points={{-21.5,64},
          {-21.5,64},{-34,64},{-34,24},{-21.5,24}},
                                                 color={0,0,127}));
  connect(none.angAzi, buildingShade.angAzi) annotation (Line(points={{-21.5,
          61.3333},{-30,61.3333},{-30,21.3333},{-21.5,21.3333}},
                                   color={0,0,127}));
  connect(none.angZen, buildingShade.angZen) annotation (Line(points={{-21.5,
          62.6667},{-32,62.6667},{-32,22.6667},{-21.5,22.6667}},
                                        color={0,0,127}));
  connect(overhang.angAzi, none.angAzi) annotation (Line(points={{-21.5,
          -18.6667},{-30,-18.6667},{-30,61.3333},{-21.5,61.3333}},
                                   color={0,0,127}));
  connect(overhang.angZen, none.angZen) annotation (Line(points={{-21.5,
          -17.3333},{-32,-17.3333},{-32,62.6667},{-21.5,62.6667}},
                                   color={0,0,127}));
  connect(overhang.angInc, none.angInc) annotation (Line(points={{-21.5,-16},{
          -34,-16},{-34,64},{-21.5,64}},
                                   color={0,0,127}));
  connect(overhang.HSkyDifTil, none.HSkyDifTil) annotation (Line(points={{-21.5,
          -10.6667},{-38,-10.6667},{-38,69.3333},{-21.5,69.3333}},
                                  color={0,0,127}));
  connect(overhang.HDirTil, none.HDirTil) annotation (Line(points={{-21.5,
          -9.33333},{-40,-9.33333},{-40,70.6667},{-21.5,70.6667}},
                                  color={0,0,127}));
  connect(screen.HDirTil, overhang.HDirTil) annotation (Line(points={{-21.5,
          -49.3333},{-40,-49.3333},{-40,-9.33333},{-21.5,-9.33333}},
                                       color={0,0,127}));
  connect(screen.HSkyDifTil, overhang.HSkyDifTil) annotation (Line(points={{-21.5,
          -50.6667},{-38,-50.6667},{-38,-10.6667},{-21.5,-10.6667}},
                                       color={0,0,127}));
  connect(screen.angInc, overhang.angInc) annotation (Line(points={{-21.5,-56},
          {-34,-56},{-34,-16},{-21.5,-16}},
                                         color={0,0,127}));
  connect(screen.angAzi, overhang.angAzi) annotation (Line(points={{-21.5,
          -58.6667},{-30,-58.6667},{-30,-18.6667},{-21.5,-18.6667}},
                                         color={0,0,127}));
  connect(screen.angZen, overhang.angZen) annotation (Line(points={{-21.5,
          -57.3333},{-32,-57.3333},{-32,-17.3333},{-21.5,-17.3333}},
                                                   color={0,0,127}));
  connect(ctrl.y, screen.Ctrl)
    annotation (Line(points={{-59,-70},{-19,-70},{-19,-60}}, color={0,0,127}));
  connect(sideFins.angAzi, screen.angAzi) annotation (Line(points={{-21.5,
          -98.6667},{-30,-98.6667},{-30,-58.6667},{-21.5,-58.6667}},
                                                   color={0,0,127}));
  connect(sideFins.angZen, screen.angZen) annotation (Line(points={{-21.5,
          -97.3333},{-32,-97.3333},{-32,-57.3333},{-21.5,-57.3333}},
                                                   color={0,0,127}));
  connect(sideFins.angInc, screen.angInc) annotation (Line(points={{-21.5,-96},
          {-34,-96},{-34,-56},{-21.5,-56}},                  color={0,0,127}));
  connect(sideFins.HSkyDifTil, screen.HSkyDifTil) annotation (Line(points={{-21.5,
          -90.6667},{-38,-90.6667},{-38,-50.6667},{-21.5,-50.6667}},
                                                   color={0,0,127}));
  connect(sideFins.HDirTil, screen.HDirTil) annotation (Line(points={{-21.5,
          -89.3333},{-40,-89.3333},{-40,-49.3333},{-21.5,-49.3333}},
                                                   color={0,0,127}));
  connect(buildingShade.HGroDifTil, weaBus.solBus[2].HGroDifTil) annotation (Line(
        points={{-21.5,28},{-53.95,28},{-53.95,34.05}},
                                                      color={0,0,127}));
  connect(none.HGroDifTil, buildingShade.HGroDifTil) annotation (Line(points={{-21.5,
          68},{-30,68},{-36,68},{-36,28},{-21.5,28}},
                                                    color={0,0,127}));
  connect(overhang.HGroDifTil, buildingShade.HGroDifTil) annotation (Line(
        points={{-21.5,-12},{-36,-12},{-36,28},{-21.5,28}},
                                                      color={0,0,127}));
  connect(screen.HGroDifTil, overhang.HGroDifTil) annotation (Line(points={{-21.5,
          -52},{-36,-52},{-36,-12},{-21.5,-12}},       color={0,0,127}));
  connect(sideFins.HGroDifTil, screen.HGroDifTil) annotation (Line(points={{-21.5,
          -92},{-36,-92},{-36,-52},{-21.5,-52}},
                                               color={0,0,127}));
  connect(horizontalFins.HDirTil, buildingShade.HDirTil)
    annotation (Line(points={{16.5,30.6667},{8,30.6667},{8,30},{-1.5,30},{-1.5,
          30.6667},{-21.5,30.6667}},            color={0,0,127}));
  connect(horizontalFins.HGroDifTil, buildingShade.HGroDifTil)
    annotation (Line(points={{16.5,28},{8,28},{8,24},{-1.5,24},{-1.5,28},{-21.5,
          28}},                                 color={0,0,127}));
  connect(horizontalFins.HSkyDifTil, buildingShade.HSkyDifTil) annotation (Line(
        points={{16.5,29.3333},{-6,29.3333},{-6,29.3333},{-21.5,29.3333}},
                                                   color={0,0,127}));
  connect(horizontalFins.angInc, buildingShade.angInc)
    annotation (Line(points={{16.5,24},{8,24},{8,22},{-1.5,22},{-1.5,24},{-21.5,
          24}},                                 color={0,0,127}));
  connect(horizontalFins.angAzi, buildingShade.angAzi) annotation (Line(points={{16.5,
          21.3333},{-6,21.3333},{-6,21.3333},{-21.5,21.3333}},
                                              color={0,0,127}));
  connect(buildingShade.angZen, horizontalFins.angZen)
    annotation (Line(points={{-21.5,22.6667},{-12,22.6667},{-12,22},{-1.5,22},{
          -1.5,22.6667},{16.5,22.6667}},        color={0,0,127}));
  connect(m_flow.y, overhang.m_flow) annotation(
    Line(points = {{-78, -30}, {-16, -30}, {-16, -20}, {-18, -20}}, color = {0, 0, 127}));
  connect(m_flow.y, screen.m_flow) annotation(
    Line(points = {{-78, -30}, {-18, -30}, {-18, -60}}, color = {0, 0, 127}));
  connect(m_flow.y, sideFins.m_flow) annotation(
    Line(points = {{-78, -30}, {-18, -30}, {-18, -100}}, color = {0, 0, 127}));
  connect(m_flow.y, buildingShade.m_flow) annotation(
    Line(points = {{-78, -30}, {-18, -30}, {-18, 20}}, color = {0, 0, 127}));
  connect(m_flow.y, horizontalFins.m_flow) annotation(
    Line(points = {{-78, -30}, {20, -30}, {20, 20}}, color = {0, 0, 127}));
  connect(m_flow.y, none.m_flow) annotation(
    Line(points = {{-78, -30}, {-16, -30}, {-16, 60}, {-18, 60}}, color = {0, 0, 127}));
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
          "Resources/Scripts/Dymola/Buildings/Components/Examples/BuildingShadeExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
August 9, 2022, by Filip Jorissen:<br/>
Updated example after modified component connectors for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a>.
</li>
<li>
March 23, 2018 by Filip Jorissen:<br/>
Added test for horizontal fin model.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/697\">
#697</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016, by Filip Jorissen:<br/>
Using west oriented data since this orientation
is more likeley to catch a bug.
</li>
<li>
July 18, 2016, by Filip Jorissen:<br/>
Extended implementation.
</li>
<li>
June 12, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model demonstrates the impact of the BuildingShade component on the solar radiation.
</p>
</html>"));
end BuildingShadeExample;
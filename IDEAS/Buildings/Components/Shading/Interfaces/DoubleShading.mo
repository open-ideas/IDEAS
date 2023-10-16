within IDEAS.Buildings.Components.Shading.Interfaces;
model DoubleShading "Two shading components in series"
  extends PartialShading(
    final controlled=stateShading1.controlled or
        stateShading2.controlled);
  replaceable PartialShading stateShading1
  constrainedby PartialShading(
    haveFrame=haveFrame,
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi)
    "First shading device"
    annotation (Placement(transformation(extent={{-28,-18},{-18,2}})));
  replaceable PartialShading stateShading2
  constrainedby PartialShading(
    haveFrame=haveFrame,
    A_glazing=A_glazing,
    g_glazing=g_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi)
    "Second shading device"
    annotation (Placement(transformation(extent={{-4,-18},{6,2}})));

equation
  assert(not (stateShading1.haveBoundaryPorts and stateShading2.haveBoundaryPorts),
    "In " + getInstanceName() + ": haveBoundaryPorts must be disabled for either of the two shading devices, or for both.");
    //in case of both: implement a custom thermal model
  connect(stateShading1.angInc, angInc) annotation (Line(points={{-25.5,-14},{-34,
          -14},{-34,-50},{-60,-50}}, color={0,0,127}));
  connect(stateShading1.angAzi, angAzi) annotation (Line(points={{-25.5,
          -16.6667},{-30,-16.6667},{-30,-90},{-60,-90}},
                                     color={0,0,127}));
  connect(stateShading1.angZen, angZen) annotation (Line(points={{-25.5,
          -15.3333},{-32,-15.3333},{-32,-16},{-32,-70},{-60,-70}},
                                               color={0,0,127}));
  connect(Ctrl, stateShading1.Ctrl) annotation (Line(points={{-10,-110},{-10,-80},
          {-23,-80},{-23,-18}}, color={0,0,127}));
  connect(Ctrl,stateShading2. Ctrl) annotation (Line(points={{-10,-110},{-10,-80},
          {1,-80},{1,-18}}, color={0,0,127}));
  connect(stateShading1.angAzi, stateShading2.angAzi)
    annotation (Line(points={{-25.5,-16.6667},{-18,-16.6667},{-18,-16},{-11.5,
          -16},{-11.5,-16.6667},{-1.5,-16.6667}}, color={0,0,127}));
  connect(stateShading1.angZen, stateShading2.angZen)
    annotation (Line(points={{-25.5,-15.3333},{-1.5,-15.3333},{-1.5,-15.3333}},
                                                            color={0,0,127}));
  connect(stateShading1.iAngInc, stateShading2.angInc)
    annotation (Line(points={{-20.5,-14},{-11,-14},{-1.5,-14}},
                                                            color={0,0,127}));
  connect(stateShading2.iAngInc, iAngInc) annotation (Line(points={{3.5,-14},{14,
          -14},{14,-50},{40,-50}},
                              color={0,0,127}));
  connect(HSkyDifTil, stateShading1.HSkyDifTil) annotation (Line(points={{-60,30},
          {-34,30},{-34,-8.66667},{-25.5,-8.66667}},
                                           color={0,0,127}));
  connect(HGroDifTil, stateShading1.HGroDifTil) annotation (Line(points={{-60,10},
          {-36,10},{-36,-10},{-25.5,-10}}, color={0,0,127}));
  connect(stateShading2.HShaGroDifTil, HShaGroDifTil) annotation (Line(points={{3.5,-10},
          {16,-10},{16,10},{40,10}},       color={0,0,127}));
  connect(stateShading2.HShaDirTil, HShaDirTil) annotation (Line(points={{3.5,-7.33333},
          {12,-7.33333},{12,0},{12,52},{12,50},{40,50}},
                                                   color={0,0,127}));
  connect(stateShading2.HShaSkyDifTil, HShaSkyDifTil) annotation (Line(points={{3.5,
          -8.66667},{14,-8.66667},{14,30},{40,30}},
                                           color={0,0,127}));
  connect(stateShading1.HShaDirTil, stateShading2.HDirTil)
    annotation (Line(points={{-20.5,-7.33333},{-11,-7.33333},{-1.5,-7.33333}},
                                                         color={0,0,127}));
  connect(stateShading1.HShaSkyDifTil, stateShading2.HSkyDifTil)
    annotation (Line(points={{-20.5,-8.66667},{-11,-8.66667},{-1.5,-8.66667}},
                                                         color={0,0,127}));
  connect(stateShading1.HShaGroDifTil, stateShading2.HGroDifTil)
    annotation (Line(points={{-20.5,-10},{-12,-10},{-1.5,-10}},
                                                         color={0,0,127}));
  connect(HDirTil, stateShading1.HDirTil) annotation (Line(points={{-60,50},{-32,
          50},{-32,-7.33333},{-25.5,-7.33333}},
                                      color={0,0,127}));
  connect(stateShading1.port_frame, port_frame) annotation (Line(points={{-20.5,
          0.666667},{-20.5,160},{100,160}}, color={191,0,0}));
  connect(stateShading2.port_frame, port_frame) annotation (Line(points={{3.5,0.666667},
          {3.5,160},{100,160}},             color={191,0,0}));
  connect(stateShading1.port_glazing, port_glazing) annotation (Line(points={{-20.5,
          -2},{-20.5,120},{100,120}},       color={191,0,0}));
  connect(stateShading2.port_glazing, port_glazing) annotation (Line(points={{3.5,-2},
          {3.5,120},{100,120}},             color={191,0,0}));
  connect(stateShading2.TDryBul, TDryBul) annotation (
    Line(points={{3.5,-11.3333},{40,-11.3333},{40,-10}},
                                                    color = {0, 0, 127}));
  connect(Te, stateShading2.Te) annotation (Line(points={{-60,130},{-6,130},{-6,
          -2},{-1.5,-2}}, color={0,0,127}));
  connect(hForcedConExt, stateShading2.hForcedConExt) annotation (Line(points={
          {-60,110},{-8,110},{-8,-3.33333},{-1.5,-3.33333}}, color={0,0,127}));
  connect(TEnv, stateShading2.TEnv) annotation (Line(points={{-60,90},{-10,90},
          {-10,-4.66667},{-1.5,-4.66667}}, color={0,0,127}));
  connect(stateShading1.TDryBul, TDryBul) annotation (
    Line(points={{-20.5,-11.3333},{40,-11.3333},{40,-10}},
                                                    color = {0, 0, 127}));
  connect(Te, stateShading1.Te) annotation (Line(points={{-60,130},{-6,130},{-6,
          -2},{-25.5,-2}},color={0,0,127}));
  connect(hForcedConExt, stateShading1.hForcedConExt) annotation (Line(points={{-60,110},
          {-8,110},{-8,-3.33333},{-25.5,-3.33333}},          color={0,0,127}));
  connect(TEnv, stateShading1.TEnv) annotation (Line(points={{-60,90},{-10,90},
          {-10,-4.66667},{-25.5,-4.66667}},color={0,0,127}));  
  connect(stateShading2.m_flow, m_flow) annotation(
    Line(points = {{2, -18}, {40, -18}, {40, -90}}, color = {0, 0, 127}));
  connect(stateShading1.m_flow, m_flow) annotation(
    Line(points = {{-22, -18}, {40, -18}, {40, -90}}, color = {0, 0, 127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 200}})), Documentation(revisions="<html>
<ul>
<li>
October 12, 2022, by Filip Jorissen:<br/>
Revised default connections between shading components when using DoubleShading. See
<a href=\"https://github.com/open-ideas/IDEAS/issues/1299\">#1299</a>.
</li>
<li>
August 9, 2022, by Filip Jorissen:<br/>
Updated example after modified component connectors for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
<li>
December 2014, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model can be extended or used if two shading models need to be combined.</p>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 200}}, preserveAspectRatio = false)));
end DoubleShading;
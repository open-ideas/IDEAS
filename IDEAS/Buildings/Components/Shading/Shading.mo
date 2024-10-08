within IDEAS.Buildings.Components.Shading;
model Shading
  "Model that allows to select any shading option based on record"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(controlled=shaPro.controlled);
  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaPro
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading properties"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
protected
  IDEAS.Buildings.Components.Shading.Box box(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    wLeft=shaPro.wLeft,
    wRight=shaPro.wRight,
    ovDep=shaPro.ovDep,
    ovGap=shaPro.ovGap,
    hFin=shaPro.hFin,
    finDep=shaPro.finDep,
    finGap=shaPro.finGap)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box
    "Box shading model"                                                           annotation (Placement(transformation(extent={{-16,80},{-6,100}})));
  IDEAS.Buildings.Components.Shading.BuildingShade buildingShade(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    L=shaPro.L,
    dh=shaPro.dh,
    hWin=shaPro.hWin,
    azi=azi)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BuildingShade
    "Building shade model"
    annotation (Placement(transformation(extent={{-16,60},{-6,80}})));
  IDEAS.Buildings.Components.Shading.Overhang overhang(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    wLeft=shaPro.wLeft,
    wRight=shaPro.wRight,
    dep=shaPro.ovDep,
    gap=shaPro.ovGap,
    azi=azi)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Overhang
    "Overhang model"
    annotation (Placement(transformation(extent={{-16,40},{-6,60}})));
  IDEAS.Buildings.Components.Shading.OverhangAndScreen overhangAndScreen(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    wLeft=shaPro.wLeft,
    wRight=shaPro.wRight,
    dep=shaPro.ovDep,
    gap=shaPro.ovGap,
    shaCorr=shaPro.shaCorr,
    azi=azi)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen
    "Overhang and screen model"
    annotation (Placement(transformation(extent={{-16,20},{-6,40}})));
  IDEAS.Buildings.Components.Shading.Screen screen(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    refSw_shading=1-epsSw_shading-shaPro.shaCorr,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    shaCorr=shaPro.shaCorr)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Screen
    "Screen model"                                 annotation (Placement(transformation(extent={{-16,0},{-6,20}})));
  IDEAS.Buildings.Components.Shading.SideFins sideFins(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    hFin=shaPro.hFin,
    dep=shaPro.finDep,
    gap=shaPro.finGap)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.SideFins
    "Side fin model"
    annotation (Placement(visible = true, transformation(extent = {{-16, -20}, {-6, 0}}, rotation = 0)));
  IDEAS.Buildings.Components.Shading.None none(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    final hSha=hSha)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.None
    "No shading model"
    annotation (Placement(visible = true, transformation(extent = {{-16, -40}, {-6, -20}}, rotation = 0)));

  IDEAS.Buildings.Components.Shading.BoxAndScreen boxAndScreen(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    wLeft=shaPro.wLeft,
    wRight=shaPro.wRight,
    ovDep=shaPro.ovDep,
    ovGap=shaPro.ovGap,
    hFin=shaPro.hFin,
    finDep=shaPro.finDep,
    finGap=shaPro.finGap,
    shaCorr=shaPro.shaCorr) if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BoxAndScreen "Box and screen model"
        annotation (Placement(transformation(extent={{-16,-62},{-6,-42}})));

  IDEAS.Buildings.Components.Shading.HorizontalFins horizontalFins(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    azi=azi,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    s=shaPro.s,
    w=shaPro.w,
    t=shaPro.t,
    beta = shaPro.beta,
    use_betaInput=shaPro.use_betaInput) if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins "Horizontal fins model"
    annotation (Placement(visible = true, transformation(extent = {{-16, 100}, {-6, 120}}, rotation = 0)));
  IDEAS.Buildings.Components.Shading.OverhangAndHorizontalFins overhangAndHorizontalFins(
    A_glazing=A_glazing,
    A_frame=A_frame,
    inc=inc,
    Tenv_nom=Tenv_nom,
    epsSw_frame=epsSw_frame,
    epsLw_frame=epsLw_frame,
    epsLw_glazing=epsLw_glazing,
    epsSw_shading=epsSw_shading,
    g_glazing=g_glazing,
    linCon=linCon,
    linRad=linRad,
    haveBoundaryPorts=true,
    haveFrame=haveFrame,
    hSha=hSha,
    s=shaPro.s,
    w=shaPro.w,
    t=shaPro.t,
    beta = shaPro.beta,
    use_betaInput=shaPro.use_betaInput,
    hWin=shaPro.hWin,
    wWin=shaPro.wWin,
    wLeft=shaPro.wLeft,
    wRight=shaPro.wRight,
    dep=shaPro.ovDep,
    gap=shaPro.ovGap,
    azi=azi)
 if shaPro.shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins
    "Overhang and horizontal fins model"
    annotation (Placement(transformation(extent={{-16,120},{-6,140}})));
equation
  connect(screen.Ctrl, Ctrl) annotation (Line(
      points={{-11,0},{-10,0},{-10,-110}},
      color={0,0,127},
      visible=false));
  connect(Ctrl, overhangAndScreen.Ctrl) annotation (Line(
      points={{-10,-110},{-10,20},{-11,20}},
      color={0,0,127},
      visible=false));
  connect(box.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,90.6667},{-60,90.6667},{-60,50}},
                                                          color={0,0,127}));
  connect(buildingShade.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,70.6667},{-60,70.6667},{-60,50}},
                                                          color={0,0,127}));
  connect(overhang.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,50.6667},{-60,50.6667},{-60,50}},
                                                          color={0,0,127}));
  connect(overhangAndScreen.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,30.6667},{-60,30.6667},{-60,50}},
                                                          color={0,0,127}));
  connect(screen.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,10.6667},{-60,10.6667},{-60,50}},
                                                          color={0,0,127}));
  connect(sideFins.HDirTil, HDirTil) annotation (
    Line(points={{-13.5,-9.33333},{-60,-9.33333},{-60,50}},
                                                     color = {0, 0, 127}));
  connect(box.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,89.3333},{-60,89.3333},{-60,30}},
                                                          color={0,0,127}));
  connect(buildingShade.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,69.3333},{-60,69.3333},{-60,30}},
                                                          color={0,0,127}));
  connect(overhang.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,49.3333},{-60,49.3333},{-60,30}},
                                                          color={0,0,127}));
  connect(overhangAndScreen.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,29.3333},{-60,29.3333},{-60,30}},
                                                          color={0,0,127}));
  connect(screen.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,9.33333},{-60,9.33333},{-60,30}},
                                                          color={0,0,127}));
  connect(sideFins.HSkyDifTil, HSkyDifTil) annotation (
    Line(points={{-13.5,-10.6667},{-60,-10.6667},{-60,30}},
                                                     color = {0, 0, 127}));
  connect(box.angInc, angInc)
    annotation (Line(points={{-13.5,84},{-60,84},{-60,-50}},
                                                           color={0,0,127}));
  connect(buildingShade.angInc, angInc)
    annotation (Line(points={{-13.5,64},{-60,64},{-60,-50}},
                                                           color={0,0,127}));
  connect(overhang.angInc, angInc)
    annotation (Line(points={{-13.5,44},{-60,44},{-60,-50}},
                                                           color={0,0,127}));
  connect(overhangAndScreen.angInc, angInc)
    annotation (Line(points={{-13.5,24},{-60,24},{-60,-50}},
                                                           color={0,0,127}));
  connect(screen.angInc, angInc)
    annotation (Line(points={{-13.5,4},{-60,4},{-60,-50}},
                                                         color={0,0,127}));
  connect(sideFins.angInc, angInc) annotation (
    Line(points={{-13.5,-16},{-60,-16},{-60,-50}},      color = {0, 0, 127}));
  connect(box.angZen, angZen) annotation (Line(points={{-13.5,82.6667},{-24,
          82.6667},{-60,82.6667},{-60,-70}},
                               color={0,0,127}));
  connect(buildingShade.angZen, angZen) annotation (Line(points={{-13.5,62.6667},
          {-24,62.6667},{-60,62.6667},{-60,-70}},
                                        color={0,0,127}));
  connect(overhang.angZen, angZen) annotation (Line(points={{-13.5,42.6667},{
          -26,42.6667},{-60,42.6667},{-60,-70}},
                                   color={0,0,127}));
  connect(overhangAndScreen.angZen, angZen)
    annotation (Line(points={{-13.5,22.6667},{-60,22.6667},{-60,-70}},
                                                           color={0,0,127}));
  connect(screen.angZen, angAzi) annotation (Line(points={{-13.5,2.66667},{-24,
          2.66667},{-60,2.66667},{-60,-90}},
                              color={0,0,127}));
  connect(sideFins.angZen, angZen) annotation (
    Line(points={{-13.5,-17.3333},{-24,-17.3333},{-60,-17.3333},{-60,-70}},
                                                                    color = {0, 0, 127}));
  connect(box.angAzi, angAzi)
    annotation (Line(points={{-13.5,81.3333},{-60,81.3333},{-60,-90}},
                                                           color={0,0,127}));
  connect(buildingShade.angAzi, angAzi)
    annotation (Line(points={{-13.5,61.3333},{-60,61.3333},{-60,-90}},
                                                           color={0,0,127}));
  connect(overhang.angAzi, angAzi)
    annotation (Line(points={{-13.5,41.3333},{-60,41.3333},{-60,-90}},
                                                           color={0,0,127}));
  connect(overhangAndScreen.angAzi, angAzi)
    annotation (Line(points={{-13.5,21.3333},{-60,21.3333},{-60,-90}},
                                                           color={0,0,127}));
  connect(screen.angAzi, angAzi)
    annotation (Line(points={{-13.5,1.33333},{-60,1.33333},{-60,-90}},
                                                         color={0,0,127}));
  connect(sideFins.angAzi, angAzi) annotation (
    Line(points={{-13.5,-18.6667},{-60,-18.6667},{-60,-90}},
                                                        color = {0, 0, 127}));
  connect(box.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,90.6667},{40,90.6667},{40,50}},
                                                       color={0,0,127}));
  connect(buildingShade.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,70.6667},{40,70.6667},{40,50}},
                                                       color={0,0,127}));
  connect(overhang.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,50.6667},{40,50.6667},{40,50}},
                                                       color={0,0,127}));
  connect(overhangAndScreen.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,30.6667},{40,30.6667},{40,50}},
                                                       color={0,0,127}));
  connect(screen.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,10.6667},{40,10.6667},{40,50}},
                                                       color={0,0,127}));
  connect(sideFins.HShaDirTil, HShaDirTil) annotation (
    Line(points={{-8.5,-9.33333},{40,-9.33333},{40,50}},
                                                  color = {0, 0, 127}));
  connect(box.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,89.3333},{40,89.3333},{40,30}},
                                                       color={0,0,127}));
  connect(buildingShade.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,69.3333},{40,69.3333},{40,30}},
                                                       color={0,0,127}));
  connect(overhang.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,49.3333},{40,49.3333},{40,30}},
                                                       color={0,0,127}));
  connect(overhangAndScreen.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,29.3333},{40,29.3333},{40,30}},
                                                       color={0,0,127}));
  connect(screen.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,9.33333},{40,9.33333},{40,30}},
                                                       color={0,0,127}));
  connect(sideFins.HShaSkyDifTil, HShaSkyDifTil) annotation (
    Line(points={{-8.5,-10.6667},{40,-10.6667},{40,30}},
                                                  color = {0, 0, 127}));
  connect(sideFins.iAngInc, iAngInc) annotation (
    Line(points={{-8.5,-16},{40,-16},{40,-50}},      color = {0, 0, 127}));
  connect(screen.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,4},{40,4},{40,-50}},
                                                      color={0,0,127}));
  connect(overhangAndScreen.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,24},{40,24},{40,-50}},
                                                        color={0,0,127}));
  connect(overhang.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,44},{40,44},{40,-50}},
                                                        color={0,0,127}));
  connect(buildingShade.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,64},{40,64},{40,-50}},
                                                        color={0,0,127}));
  connect(box.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,84},{40,84},{40,-50}},
                                                        color={0,0,127}));
  connect(none.HDirTil, HDirTil)
    annotation (Line(points={{-13.5,-29.3333},{-60,-29.3333},{-60,50}},
                                                            color={0,0,127}));
  connect(none.HSkyDifTil, HSkyDifTil)
    annotation (Line(points={{-13.5,-30.6667},{-60,-30.6667},{-60,30}},
                                                            color={0,0,127}));
  connect(none.angInc, angInc)
    annotation (Line(points={{-13.5,-36},{-60,-36},{-60,-50}},
                                                             color={0,0,127}));
  connect(none.angAzi, angAzi) annotation (Line(points={{-13.5,-38.6667},{-24,
          -38.6667},{-60,-38.6667},{-60,-90}},
                           color={0,0,127}));
  connect(none.angZen, angZen) annotation (Line(points={{-13.5,-37.3333},{-28,
          -37.3333},{-60,-37.3333},{-60,-70}},
                           color={0,0,127}));
  connect(none.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,-36},{40,-36},{40,-50}},
                                                          color={0,0,127}));
  connect(none.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,-30.6667},{40,-30.6667},{40,30}},
                                                         color={0,0,127}));
  connect(none.HShaDirTil, HShaDirTil)
    annotation (Line(points={{-8.5,-29.3333},{40,-29.3333},{40,50}},
                                                         color={0,0,127}));
  connect(boxAndScreen.HDirTil, HDirTil) annotation (Line(points={{-13.5,
          -51.3333},{-36,-51.3333},{-36,50},{-60,50}},
                              color={0,0,127}));
  connect(boxAndScreen.HSkyDifTil, HSkyDifTil) annotation (Line(points={{-13.5,
          -52.6667},{-36,-52.6667},{-36,30},{-60,30}},
                              color={0,0,127}));
  connect(boxAndScreen.angInc, angInc) annotation (Line(points={{-13.5,-58},{
          -36,-58},{-36,-50},{-60,-50}},
                                color={0,0,127}));
  connect(boxAndScreen.angZen, angZen) annotation (Line(points={{-13.5,-59.3333},
          {-32,-59.3333},{-32,-70},{-60,-70}},
                                color={0,0,127}));
  connect(boxAndScreen.angAzi, angAzi) annotation (Line(points={{-13.5,-60.6667},
          {-34,-60.6667},{-34,-90},{-60,-90}},
                                color={0,0,127}));
  connect(boxAndScreen.HShaDirTil, HShaDirTil) annotation (Line(points={{-8.5,
          -51.3333},{40,-51.3333},{40,50}},
                            color={0,0,127}));
  connect(boxAndScreen.HShaSkyDifTil, HShaSkyDifTil) annotation (Line(points={{-8.5,
          -52.6667},{40,-52.6667},{40,30}},
                            color={0,0,127}));
  connect(boxAndScreen.iAngInc, iAngInc) annotation (Line(points={{-8.5,-58},{
          40,-58},{40,-50}},  color={0,0,127}));
  connect(Ctrl, boxAndScreen.Ctrl) annotation (Line(points={{-10,-110},{-10,-62},
          {-11,-62}}, color={0,0,127}));
  connect(box.HGroDifTil, HGroDifTil)
    annotation (Line(points={{-13.5,88},{-60,88},{-60,10}},
                                                          color={0,0,127}));
  connect(buildingShade.HGroDifTil, HGroDifTil)
    annotation (Line(points={{-13.5,68},{-60,68},{-60,10}},
                                                          color={0,0,127}));
  connect(overhang.HGroDifTil, HGroDifTil) annotation (Line(points={{-13.5,48},
          {-22,48},{-60,48},{-60,10}},color={0,0,127}));
  connect(overhangAndScreen.HGroDifTil, HGroDifTil)
    annotation (Line(points={{-13.5,28},{-60,28},{-60,10}},
                                                          color={0,0,127}));
  connect(screen.HGroDifTil, HGroDifTil)
    annotation (Line(points={{-13.5,8},{-60,8},{-60,10}}, color={0,0,127}));
  connect(sideFins.HGroDifTil, HGroDifTil) annotation (
    Line(points={{-13.5,-12},{-30,-12},{-60,-12},{-60,10}},     color = {0, 0, 127}));
  connect(none.HGroDifTil, HGroDifTil) annotation (Line(points={{-13.5,-32},{
          -32,-32},{-60,-32},{-60,10}},
                                    color={0,0,127}));
  connect(boxAndScreen.HGroDifTil, HGroDifTil)
    annotation (Line(points={{-13.5,-54},{-60,-54},{-60,10}},
                                                            color={0,0,127}));
  connect(box.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,88},{40,88},{40,10}},
                                                       color={0,0,127}));
  connect(buildingShade.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,68},{40,68},{40,10}},
                                                       color={0,0,127}));
  connect(overhang.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,48},{40,48},{40,10}},
                                                       color={0,0,127}));
  connect(overhangAndScreen.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,28},{40,28},{40,10}},
                                                       color={0,0,127}));
  connect(screen.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,8},{40,8},{40,10}}, color={0,0,127}));
  connect(sideFins.HShaGroDifTil, HShaGroDifTil) annotation (
    Line(points={{-8.5,-12},{40,-12},{40,10}},    color = {0, 0, 127}));
  connect(none.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,-32},{40,-32},{40,10}},
                                                         color={0,0,127}));
  connect(boxAndScreen.HShaGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-8.5,-54},{40,-54},{40,10}},
                                                         color={0,0,127}));
  connect(horizontalFins.Ctrl, Ctrl) annotation (Line( visible=false,points={{-11,100},{-10,100},
          {-10,-110}}, color={0,0,127}));
  connect(horizontalFins.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,104},{40,104},{40,-50}},
                                                          color={0,0,127}));
  connect(horizontalFins.HShaGroDifTil, HShaGroDifTil) annotation (Line(points={{-8.5,
          108},{14,108},{40,108},{40,10}},     color={0,0,127}));
  connect(horizontalFins.HShaSkyDifTil, HShaSkyDifTil)
    annotation (Line(points={{-8.5,109.333},{40,109.333},{40,30}},
                                                         color={0,0,127}));
  connect(horizontalFins.HShaDirTil, HShaDirTil) annotation (Line(points={{-8.5,
          110.667},{16,110.667},{40,110.667},{40,50}},
                                           color={0,0,127}));
  connect(HDirTil, horizontalFins.HDirTil) annotation (Line(points={{-60,50},{
          -60,50},{-60,116},{-13.5,116},{-13.5,110.667}},
                                              color={0,0,127}));
  connect(HSkyDifTil, horizontalFins.HSkyDifTil) annotation (Line(points={{-60,30},
          {-60,30},{-60,109.333},{-13.5,109.333}},
                                         color={0,0,127}));
  connect(HGroDifTil, horizontalFins.HGroDifTil) annotation (Line(points={{-60,10},
          {-60,10},{-60,108},{-13.5,108}},
                                         color={0,0,127}));
  connect(angInc, horizontalFins.angInc) annotation (Line(points={{-60,-50},{
          -60,-50},{-60,104},{-13.5,104}},
                                     color={0,0,127}));
  connect(horizontalFins.angAzi, angAzi)
    annotation (Line(points={{-13.5,101.333},{-60,101.333},{-60,-90}},
                                                             color={0,0,127}));
  connect(horizontalFins.angZen, angZen)
    annotation (Line(points={{-13.5,102.667},{-60,102.667},{-60,-70}},
                                                             color={0,0,127}));
  connect(overhangAndHorizontalFins.Ctrl, Ctrl) annotation (Line(points={{-11,120},
          {-10,120},{-10,-110}},            color={0,0,127}, visible=false));
  connect(overhangAndHorizontalFins.iAngInc, iAngInc)
    annotation (Line(points={{-8.5,124},{40,124},{40,-50}},
                                                          color={0,0,127}));
  connect(overhangAndHorizontalFins.HShaGroDifTil, HShaGroDifTil) annotation (
      Line(points={{-8.5,128},{16,128},{40,128},{40,10}},
                                                        color={0,0,127}));
  connect(overhangAndHorizontalFins.HShaSkyDifTil, HShaSkyDifTil) annotation (
      Line(points={{-8.5,129.333},{18,129.333},{40,129.333},{40,30}},
                                                        color={0,0,127}));
  connect(overhangAndHorizontalFins.HShaDirTil, HShaDirTil) annotation (Line(
        points={{-8.5,130.667},{40,130.667},{40,136},{40,50}},color={0,0,127}));
  connect(overhangAndHorizontalFins.angAzi, angAzi)
    annotation (Line(points={{-13.5,121.333},{-60,121.333},{-60,-90}},
                                                             color={0,0,127}));
  connect(overhangAndHorizontalFins.angInc, angInc) annotation (Line(points={{-13.5,
          124},{-34,124},{-60,124},{-60,-50}}, color={0,0,127}));
  connect(overhangAndHorizontalFins.HGroDifTil, HGroDifTil) annotation (Line(
        points={{-13.5,128},{-40,128},{-60,128},{-60,10}},
                                                         color={0,0,127}));
  connect(overhangAndHorizontalFins.HSkyDifTil, HSkyDifTil) annotation (Line(
        points={{-13.5,129.333},{-36,129.333},{-60,129.333},{-60,30}},
                                                         color={0,0,127}));
  connect(overhangAndHorizontalFins.HDirTil, HDirTil) annotation (Line(points={{-13.5,
          130.667},{-38,130.667},{-60,130.667},{-60,50}},
                                                  color={0,0,127}));
  connect(overhangAndHorizontalFins.angZen, angZen)
    annotation (Line(points={{-13.5,122.667},{-60,122.667},{-60,-70}},
                                                             color={0,0,127}));
  connect(boxAndScreen.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,-46},{100,-46},{100,120}},      color = {191, 0, 0}));
  connect(port_glazing, none.port_glazing) annotation (
    Line(points={{100,120},{100,-24},{-8.5,-24}},      color = {191, 0, 0}));
  connect(sideFins.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,-4},{100,-4},{100,120}},      color = {191, 0, 0}));
  connect(screen.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,16},{100,16},{100,120}},      color = {191, 0, 0}));
  connect(overhangAndScreen.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,36},{100,36},{100,120}},      color = {191, 0, 0}));
  connect(overhang.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,56},{100,56},{100,120}},      color = {191, 0, 0}));
  connect(buildingShade.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,76},{100,76},{100,120}},      color = {191, 0, 0}));
  connect(box.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,96},{100,96},{100,120}},      color = {191, 0, 0}));
  connect(horizontalFins.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,116},{100,116},{100,120}},      color = {191, 0, 0}));
  connect(overhangAndHorizontalFins.port_glazing, port_glazing) annotation (
    Line(points={{-8.5,136},{100,136},{100,120}},      color = {191, 0, 0}));
  connect(overhangAndHorizontalFins.port_frame, port_frame) annotation (
    Line(points={{-8.5,138.667},{80,138.667},{80,160},{100,160}},color = {191, 0, 0}));
  connect(horizontalFins.port_frame, port_frame) annotation (
    Line(points={{-8.5,118.667},{80,118.667},{80,160},{100,160}},color = {191, 0, 0}));
  connect(box.port_frame, port_frame) annotation (
    Line(points={{-8.5,98.6667},{80,98.6667},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(buildingShade.port_frame, port_frame) annotation (
    Line(points={{-8.5,78.6667},{80,78.6667},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(overhang.port_frame, port_frame) annotation (
    Line(points={{-8.5,58.6667},{80,58.6667},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(screen.port_frame, port_frame) annotation (
    Line(points={{-8.5,18.6667},{80,18.6667},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(overhangAndScreen.port_frame, port_frame) annotation (
    Line(points={{-8.5,38.6667},{80,38.6667},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(none.port_frame, port_frame) annotation (
    Line(points={{-8.5,-21.3333},{80,-21.3333},{80,160},{100,160}},
                                                                 color = {191, 0, 0}));
  connect(sideFins.port_frame, port_frame) annotation (
    Line(points={{-8.5,-1.33333},{80,-1.33333},{80,160},{100,160}},
                                                               color = {191, 0, 0}));
  connect(boxAndScreen.port_frame, port_frame) annotation (
    Line(points={{-8.5,-43.3333},{80,-43.3333},{80,160},{100,160}},
                                                                 color = {191, 0, 0}));

  connect(Te, overhangAndHorizontalFins.Te) annotation (Line(points={{-60,130},{
          -60,132},{-22,132},{-22,136},{-13.5,136}}, color={0,0,127}));
  connect(hForcedConExt, overhangAndHorizontalFins.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,134.667},{-13.5,134.667}},
        color={0,0,127}));
  connect(TEnv, overhangAndHorizontalFins.TEnv) annotation (Line(points={{-60,90},
          {-60,94},{-18,94},{-18,133.333},{-13.5,133.333}}, color={0,0,127}));
  connect(Te, horizontalFins.Te) annotation (Line(points={{-60,130},{-60,132},{
          -22,132},{-22,116},{-13.5,116}},           color={0,0,127}));
  connect(hForcedConExt, horizontalFins.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,114.667},{-13.5,114.667}},
        color={0,0,127}));
  connect(TEnv, horizontalFins.TEnv) annotation (Line(points={{-60,90},{-60,94},
          {-18,94},{-18,113.333},{-13.5,113.333}},          color={0,0,127}));
  connect(Te, box.Te) annotation (Line(points={{-60,130},{-60,132},{-22,132},{
          -22,96},{-13.5,96}},                       color={0,0,127}));
  connect(hForcedConExt, box.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,94.6667},{-13.5,94.6667}},
        color={0,0,127}));
  connect(TEnv, box.TEnv) annotation (Line(points={{-60,90},{-60,94},{-18,94},{
          -18,93.3333},{-13.5,93.3333}},                    color={0,0,127}));
  connect(Te, buildingShade.Te) annotation (Line(points={{-60,130},{-60,132},{
          -22,132},{-22,76},{-13.5,76}},             color={0,0,127}));
  connect(hForcedConExt, buildingShade.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,74.6667},{-13.5,74.6667}},
        color={0,0,127}));
  connect(TEnv, buildingShade.TEnv) annotation (Line(points={{-60,90},{-60,94},
          {-18,94},{-18,73.3333},{-13.5,73.3333}},          color={0,0,127}));
  connect(Te, overhang.Te) annotation (Line(points={{-60,130},{-60,132},{-22,
          132},{-22,56},{-13.5,56}},                 color={0,0,127}));
  connect(hForcedConExt, overhang.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,54.6667},{-13.5,54.6667}},
        color={0,0,127}));
  connect(TEnv, overhang.TEnv) annotation (Line(points={{-60,90},{-60,94},{-18,
          94},{-18,53.3333},{-13.5,53.3333}},               color={0,0,127}));
  connect(Te, screen.Te) annotation (Line(points={{-60,130},{-60,132},{-22,132},
          {-22,16},{-13.5,16}},                      color={0,0,127}));
  connect(hForcedConExt, screen.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,14.6667},{-13.5,14.6667}},
        color={0,0,127}));
  connect(TEnv, screen.TEnv) annotation (Line(points={{-60,90},{-60,94},{-18,94},
          {-18,13.3333},{-13.5,13.3333}},                   color={0,0,127}));
  connect(Te, overhangAndScreen.Te) annotation (Line(points={{-60,130},{-60,132},
          {-22,132},{-22,36},{-13.5,36}},            color={0,0,127}));
  connect(hForcedConExt, overhangAndScreen.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,34.6667},{-13.5,34.6667}},
        color={0,0,127}));
  connect(TEnv, overhangAndScreen.TEnv) annotation (Line(points={{-60,90},{-60,
          94},{-18,94},{-18,33.3333},{-13.5,33.3333}},      color={0,0,127}));
  connect(Te, none.Te) annotation (Line(points={{-60,130},{-60,132},{-22,132},{
          -22,-24},{-13.5,-24}},                     color={0,0,127}));
  connect(hForcedConExt, none.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,-25.3333},{-13.5,-25.3333}},
        color={0,0,127}));
  connect(TEnv, none.TEnv) annotation (Line(points={{-60,90},{-60,94},{-18,94},
          {-18,-26.6667},{-13.5,-26.6667}},                 color={0,0,127}));
  connect(Te, sideFins.Te) annotation (Line(points={{-60,130},{-60,132},{-22,
          132},{-22,-4},{-13.5,-4}},                 color={0,0,127}));
  connect(hForcedConExt, sideFins.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,-5.33333},{-13.5,-5.33333}},
        color={0,0,127}));
  connect(TEnv, sideFins.TEnv) annotation (Line(points={{-60,90},{-60,94},{-18,
          94},{-18,-6.66667},{-13.5,-6.66667}},             color={0,0,127}));
  connect(Te, boxAndScreen.Te) annotation (Line(points={{-60,130},{-60,132},{
          -22,132},{-22,-46},{-13.5,-46}},           color={0,0,127}));
  connect(hForcedConExt, boxAndScreen.hForcedConExt) annotation (
      Line(points={{-60,110},{-60,112},{-20,112},{-20,-47.3333},{-13.5,-47.3333}},
        color={0,0,127}));
  connect(TEnv, boxAndScreen.TEnv) annotation (Line(points={{-60,90},{-60,94},{
          -18,94},{-18,-48.6667},{-13.5,-48.6667}},         color={0,0,127}));

  connect(overhangAndHorizontalFins.TDryBul, TDryBul) annotation (Line(points={{-8.5,
          126.667},{40,126.667},{40,-10}},
                                   color={0,0,127}));
  connect(horizontalFins.TDryBul, TDryBul) annotation (Line(points={{-8.5,
          106.667},{40,106.667},{40,-10}},
                                   color={0,0,127}));
  connect(box.TDryBul, TDryBul) annotation (Line(points={{-8.5,86.6667},{40,
          86.6667},{40,-10}},      color={0,0,127}));
  connect(buildingShade.TDryBul, TDryBul) annotation (Line(points={{-8.5,
          66.6667},{40,66.6667},{40,-10}},
                                   color={0,0,127}));
  connect(overhang.TDryBul, TDryBul) annotation (Line(points={{-8.5,46.6667},{
          40,46.6667},{40,-10}},   color={0,0,127}));
  connect(overhangAndScreen.TDryBul, TDryBul) annotation (Line(points={{-8.5,
          26.6667},{40,26.6667},{40,-10}},
                                   color={0,0,127}));
  connect(screen.TDryBul, TDryBul) annotation (Line(points={{-8.5,6.66667},{40,
          6.66667},{40,-10}},      color={0,0,127}));
  connect(none.TDryBul, TDryBul) annotation (Line(points={{-8.5,-33.3333},{40,
          -33.3333},{40,-10}},     color={0,0,127}));
  connect(sideFins.TDryBul, TDryBul) annotation (Line(points={{-8.5,-13.3333},{
          40,-13.3333},{40,-10}},  color={0,0,127}));
  connect(boxAndScreen.TDryBul, TDryBul) annotation (Line(points={{-8.5,
          -55.3333},{40,-55.3333},{40,-10}},
                                   color={0,0,127}));
  
  
  connect(m_flow, boxAndScreen.m_flow) annotation(
    Line(points = {{40, -90}, {-12, -90}, {-12, -62}, {-10, -62}}, color = {0, 0, 127}));
  connect(m_flow, none.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, -40}}, color = {0, 0, 127}));
  connect(m_flow, sideFins.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, -20}}, color = {0, 0, 127}));
  connect(m_flow, screen.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 0}}, color = {0, 0, 127}));
  connect(m_flow, overhangAndScreen.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 20}}, color = {0, 0, 127}));
  connect(m_flow, overhang.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 40}}, color = {0, 0, 127}));
  connect(m_flow, buildingShade.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 60}}, color = {0, 0, 127}));
  connect(m_flow, box.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 80}}, color = {0, 0, 127}));
  connect(m_flow, horizontalFins.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 100}}, color = {0, 0, 127}));
  connect(m_flow, overhangAndHorizontalFins.m_flow) annotation(
    Line(points = {{40, -90}, {-10, -90}, {-10, 120}}, color = {0, 0, 127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for <a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a> for including thermal effect of screens.
</li>
<li>
Aug 2 2018, by Iago Cupeiro:<br/>
Added missing beta parameter.
</li>
<li>
May 4 2018, by Iago Cupeiro:<br/>
Extended with HorizontalFins and OverhangAndHorizontalFins models.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
</ul>
</html>", info="<html>
<ul>
<li>
August 22, 2018 by Filip Jorissen:<br/>
Fixed bug in implementation due to missing <code>irr</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/pull/818\">
#818</a>.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,200}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,200}})));
end Shading;
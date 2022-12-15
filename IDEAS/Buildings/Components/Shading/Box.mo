within IDEAS.Buildings.Components.Shading;
model Box "Both side fins and overhang"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
    final controlled=false);

  parameter Modelica.Units.SI.Length hWin(min=0) "Window height"
    annotation (Dialog(group="Window properties"));
  parameter Modelica.Units.SI.Length wWin(min=0) "Window width"
    annotation (Dialog(group="Window properties"));

  parameter Modelica.Units.SI.Length wLeft(min=0)
    "Left overhang width measured from the window corner"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length wRight(min=0)
    "Right overhang width measured from the window corner"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length ovDep(min=0)
    "Overhang depth perpendicular to the wall plane"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length ovGap(min=0)
    "Distance between window upper edge and overhang lower edge"
    annotation (Dialog(group="Overhang properties"));

  parameter Modelica.Units.SI.Length hFin(min=0)
    "Height of side fin above window"
    annotation (Dialog(group="Side fin properties"));
  parameter Modelica.Units.SI.Length finDep(min=0)
    "Side fin depth perpendicular to the wall plane"
    annotation (Dialog(group="Side fin properties"));
  parameter Modelica.Units.SI.Length finGap(min=0)
    "Vertical distance between side fin and window"
    annotation (Dialog(group="Side fin properties"));

  Real fraSunDir(
    final min=0,
    final max=1,
    final unit="1")
    "Fraction of window area exposed to the sun";
  Real fraSunDifSky(
    final min=0,
    final max=1,
    final unit="1")
    "Fraction of window area exposed to diffuse sun light";

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
    haveFrame=haveFrame,
    linRad=linRad,
    final azi=azi,
    haveBoundaryPorts=false,
    hSha=hSha,
    final hWin=hWin,
    final wWin=wWin,
    final wLeft=wLeft,
    final wRight=wRight,
    final dep=ovDep,
    final gap=ovGap)
    annotation (Placement(transformation(extent={{-2,60},{8,80}})));
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
    haveFrame=haveFrame,
    linRad=linRad,
    final azi=azi,
    haveBoundaryPorts=haveBoundaryPorts,
    hSha=hSha,
    final hWin=hWin,
    final wWin=wWin,
    final hFin=hFin,
    final dep=finDep,
    final gap=finGap)
    annotation (Placement(transformation(extent={{-4,20},{6,40}})));
protected
  final parameter Modelica.Units.SI.Area aWin=hWin*wWin "Window area";
initial equation

    assert(ovDep > 0, "The depth of the overhang must be larger than zero. If this is not the case, just use Shading.SideFins");
    assert(finDep > 0, "The depth of the side fins must be larger than zero. If this is not the case, just use Shading.Overhang");

equation
  fraSunDir = overhang.fraSunDir*sideFins.fraSunDir;
  fraSunDifSky = overhang.fraSunDifSky*sideFins.fraSunDif;
  HShaDirTil = HDirTil * fraSunDir;
  HShaSkyDifTil = HSkyDifTil * fraSunDifSky;
  HShaGroDifTil = HGroDifTil * sideFins.fraSunDif;

  connect(angInc, iAngInc) annotation (Line(
      points={{-60,-50},{-16,-50},{-16,-50},{40,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(overhang.angZen, angZen) annotation (Line(
      points={{0.5,62.6667},{-30,62.6667},{-30,-70},{-60,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sideFins.angInc, angInc) annotation (Line(
      points={{-1.5,24},{-32,24},{-32,-50},{-60,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sideFins.angZen, angZen) annotation (Line(
      points={{-1.5,22.6667},{-30,22.6667},{-30,-70},{-60,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sideFins.angAzi, angAzi) annotation (Line(
      points={{-1.5,21.3333},{-28,21.3333},{-28,-90},{-60,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(overhang.angAzi, angAzi) annotation (Line(
      points={{0.5,61.3333},{-28,61.3333},{-28,-90},{-60,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(overhang.angInc, angInc) annotation (Line(
      points={{0.5,64},{-32,64},{-32,-50},{-60,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil, overhang.HDirTil) annotation (Line(points={{-60,50},{-40,50},
          {-40,70.6667},{0.5,70.6667}},
                             color={0,0,127}));
  connect(HDirTil, sideFins.HDirTil) annotation (Line(points={{-60,50},{-40,50},
          {-40,30.6667},{-1.5,30.6667}},
                             color={0,0,127}));
  connect(HSkyDifTil, overhang.HSkyDifTil) annotation (Line(points={{-60,30},{
          -38,30},{-38,69.3333},{0.5,69.3333}},
                                 color={0,0,127}));
  connect(HSkyDifTil, sideFins.HSkyDifTil) annotation (Line(points={{-60,30},{
          -38,30},{-38,29.3333},{-1.5,29.3333}},
                                 color={0,0,127}));
  connect(HGroDifTil, overhang.HGroDifTil) annotation (Line(points={{-60,10},{-36,
          10},{-36,68},{0.5,68}},color={0,0,127}));
  connect(HGroDifTil, sideFins.HGroDifTil) annotation (Line(points={{-60,10},{-36,
          10},{-36,28},{-1.5,28}},
                                 color={0,0,127}));
  connect(sideFins.port_frame, port_frame) annotation (Line(points={{3.5,
          38.6667},{12,38.6667},{12,160},{100,160}}, color={191,0,0}));
  connect(sideFins.port_glazing, port_glazing) annotation (Line(points={{3.5,36},
          {14,36},{14,120},{100,120}}, color={191,0,0}));
  connect(Te, sideFins.Te) annotation (Line(points={{-60,130},{-14,130},{-14,36},
          {-1.5,36}}, color={0,0,127}));
  connect(hForcedConExt, sideFins.hForcedConExt) annotation (Line(points={{-60,110},
          {-22,110},{-22,34.6667},{-1.5,34.6667}},      color={0,0,127}));
  connect(TEnv, sideFins.TEnv) annotation (Line(points={{-60,90},{-26,90},{-26,
          33.3333},{-1.5,33.3333}}, color={0,0,127}));
  connect(TDryBul, sideFins.TDryBul) annotation (Line(points={{40,-10},{3.5,-10},
          {3.5,26.6667}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,200}})),  Documentation(info="<html>
<p>
Shading model that simulates a combination of both side fins and a overhang. 
The implementation is a combination of both IDEAS.Buildings.Components.Shading.Overhang 
and IDEAS.Buildings.Components.Shading.SideFins.
</p>
</html>", revisions="<html>
<ul>
<li>
December 15, 2022 by Filip Jorissen:<br/>
Bugfix for #1308.
</li>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for #1270 for including thermal effect of screens.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            200}})));
end Box;

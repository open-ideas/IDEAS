within IDEAS.Utilities.IO;
model Signal2BusForZone
  parameter Integer nWin=2 "number of windows";
  parameter Integer nOutWall=2 "number of outer walls";
  parameter Integer nLay=2;

  Buildings.Components.Interfaces.RadSolBus[nOutWall] radSolBus annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,50})));
  Buildings.Components.Interfaces.winSigBus[nWin] winSigBus(each nLay=nLay)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-50})));
  Modelica.Blocks.Interfaces.RealInput winSolAbs[nWin,nLay]
    annotation (Placement(transformation(extent={{-128,-30},{-88,10}})));
  Modelica.Blocks.Interfaces.RealInput winSolDir[nWin]
    annotation (Placement(transformation(extent={{-128,-70},{-88,-30}})));
  Modelica.Blocks.Interfaces.RealInput winSolDif[nWin]
    annotation (Placement(transformation(extent={{-128,-110},{-88,-70}})));
  Modelica.Blocks.Interfaces.RealInput outWallSolDir[nOutWall]
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Interfaces.RealInput outWallSolDif[nOutWall]
    annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
  Buildings.Components.Interfaces.RadSolBusSub radSolBusSub[nOutWall]
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Buildings.Components.Interfaces.winSigBusSub winSigBusSub[nWin](each nLay=
        nLay)
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
equation
  connect(outWallSolDir[:], radSolBus[:].solDir) annotation (Line(
      points={{-108,80},{40,80},{40,50},{100,50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outWallSolDif[:], radSolBus[:].solDif) annotation (Line(
      points={{-108,40},{40,40},{40,50},{100,50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  for i in 1:nWin loop
    connect(winSolAbs[i, :], winSigBus[i].QISolAbsSig[:]) annotation (Line(
        points={{-108,-10},{70,-10},{70,-50},{100,-50}},
        color={0,0,127},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(winSigBus[i].TISolAbsSig, winSigBusSub[i].TISolAbsSig) annotation (
      Line(
        points={{100,-50},{40,-50},{40,-100}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None),
      Text(
        string="%first",
        index=1,
        extent={{6,3},{6,3}}),
      Text(
        string="%second",
        index=-1,
        extent={{-6,3},{-6,3}}));
  end for;
  connect(winSolDir[:], winSigBus[:].QISolDirSig) annotation (Line(
      points={{-108,-50},{100,-50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(winSolDif[:], winSigBus[:].QISolDifSig) annotation (Line(
      points={{-108,-90},{70,-90},{70,-50},{100,-50}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(radSolBus.inc, radSolBusSub.inc) annotation (
    Line(
      points={{100,50},{-40,50},{-40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(radSolBus.azi, radSolBusSub.azi) annotation (
    Line(
      points={{100,50},{-40,50},{-40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(radSolBus.lat, radSolBusSub.lat) annotation (
    Line(
      points={{100,50},{-40,50},{-40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(radSolBus.A, radSolBusSub.A) annotation (
    Line(
      points={{100,50},{-40,50},{-40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.inc, winSigBusSub.inc) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.azi, winSigBusSub.azi) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.lat, winSigBusSub.lat) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.A, winSigBusSub.A) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.frac, winSigBusSub.frac) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.TISolDirSig, winSigBusSub.TISolDirSig) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.TISolDifSig, winSigBusSub.TISolDifSig) annotation (
    Line(
      points={{100,-50},{40,-50},{40,-100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None),
    Text(
      string="%first",
      index=1,
      extent={{6,3},{6,3}}),
    Text(
      string="%second",
      index=-1,
      extent={{-6,3},{-6,3}}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Signal2BusForZone;

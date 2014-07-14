within IDEAS.Buildings.Components.BaseClasses;
model SwWindowResponseBlock
  parameter Integer nLay=1;
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazing
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type"
    annotation (__Dymola_choicesAllMatching=true, Dialog(group=
          "Construction details"));
  Climate.Meteo.Solar.ShadedRadSol       radSol(
    inc=winSigBusSub.inc,
    azi=winSigBusSub.azi,
    A=winSigBusSub.A*(1 - winSigBusSub.frac))
    "determination of incident solar radiation on wall based on inclination and azimuth"
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));

  replaceable Interfaces.StateShading shaType constrainedby
    Interfaces.StateShading(final azi=winSigBusSub.azi) "Shading type" annotation (
      __Dymola_choicesAllMatching=true, Dialog(group="Construction details"));

  Modelica.Blocks.Interfaces.RealInput Ctrl if shaType.controled
    "Control signal between 0 and 1, i.e. 1 is fully closed" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-46,-50}),  iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-30,-100})));

  SwWindowResponse                                        solWin(
    final SwAbs=glazing.SwAbs,
    final SwTrans=glazing.SwTrans,
    final SwTransDif=glazing.SwTransDif,
    final SwAbsDif=glazing.SwAbsDif,
    final nLay=nLay)
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));

outer SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  HeatPort2SignalSwWindowResponse heatPort2SignalSwWindowResponse(nLay=nLay)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Interfaces.winSigBusSub                      winSigBusSub(nLay=nLay)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput winSolAbs[nLay]
    annotation (Placement(transformation(extent={{92,20},{132,60}})));
  Modelica.Blocks.Interfaces.RealOutput winSolDir
    annotation (Placement(transformation(extent={{92,-20},{132,20}})));
  Modelica.Blocks.Interfaces.RealOutput winSolDif
    annotation (Placement(transformation(extent={{92,-60},{132,-20}})));
  Interfaces.winSigBus winSigBus(nLay=nLay)
                                 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={74,0})));
equation
  connect(radSol.solDir, shaType.solDir) annotation (Line(
      points={{-66,6},{-52,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.solDif, shaType.solDif) annotation (Line(
      points={{-66,2},{-52,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.angInc, shaType.angInc) annotation (Line(
      points={{-66,-4},{-52,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.angZen, shaType.angZen) annotation (Line(
      points={{-66,-6},{-52,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.angAzi, shaType.angAzi) annotation (Line(
      points={{-66,-8},{-52,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaType.Ctrl,Ctrl)  annotation (Line(
      points={{-47,-10},{-46,-10},{-46,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaType.iSolDir,solWin. solDir) annotation (Line(
      points={{-42,6},{-26,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaType.iSolDif,solWin. solDif) annotation (Line(
      points={{-42,2},{-26,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaType.iAngInc,solWin. angInc) annotation (Line(
      points={{-42,-6},{-26,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWin.iSolAbs, heatPort2SignalSwWindowResponse.iSolAbs) annotation (
      Line(
      points={{-16,10},{-18,10},{-18,16},{20,16},{20,6},{30,6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDif, heatPort2SignalSwWindowResponse.iSolDif) annotation (
      Line(
      points={{-14,-10},{-14,-22},{26,-22},{26,-6},{30,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDir, heatPort2SignalSwWindowResponse.iSolDir) annotation (
      Line(
      points={{-18,-10},{-18,-20},{24,-20},{24,0},{30,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPort2SignalSwWindowResponse.winSigBus, winSigBus) annotation (
      Line(
      points={{40,-10},{42,-10},{42,-18},{56,-18},{56,0},{74,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(winSigBus.QISolAbsSig, winSolAbs) annotation (Line(
      points={{74,0},{76,0},{76,40},{112,40}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.QISolDirSig, winSolDir) annotation (Line(
      points={{74,0},{112,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBus.QISolDifSig, winSolDif) annotation (Line(
      points={{74,0},{74,-40},{112,-40}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(winSigBusSub, heatPort2SignalSwWindowResponse.winSigBus) annotation (
      Line(
      points={{0,-100},{40,-100},{40,-10}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SwWindowResponseBlock;

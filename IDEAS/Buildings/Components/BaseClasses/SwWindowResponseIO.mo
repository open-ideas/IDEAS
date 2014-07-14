within IDEAS.Buildings.Components.BaseClasses;
model SwWindowResponseIO
  parameter Integer nLay=1;
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazing
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type"
    annotation (__Dymola_choicesAllMatching=true, Dialog(group=
          "Construction details"));
  Climate.Meteo.Solar.ShadedRadSol       radSol(
    inc=winPar.inc,
    azi=winPar.azi,
    A=winPar.A*(1 - winPar.frac))
    "determination of incident solar radiation on wall based on inclination and azimuth"
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));

  replaceable Interfaces.StateShading shaType constrainedby Interfaces.StateShading(
                            final azi=winPar.azi) "Shading type" annotation (
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

outer SimInfoManager       sim "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  IDEAS.Buildings.Components.BaseClasses.SwWindowResponseHeatPort solWinSig(nLay=nLay)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealOutput winISolAbsQ[nLay]
    annotation (Placement(transformation(extent={{94,70},{134,110}})));
  Modelica.Blocks.Interfaces.RealOutput winISolDirQ
    annotation (Placement(transformation(extent={{94,30},{134,70}})));
  Modelica.Blocks.Interfaces.RealOutput winISolDifQ
    annotation (Placement(transformation(extent={{94,-10},{134,30}})));
  Modelica.Blocks.Interfaces.RealInput winISolAbsT[nLay] annotation (Placement(transformation(
          extent={{128,-50},{88,-10}}), iconTransformation(extent={{130,-56},{90,-16}})));
  Modelica.Blocks.Interfaces.RealInput winISolDirT annotation (Placement(transformation(extent={
            {128,-90},{88,-50}}), iconTransformation(extent={{130,-96},{90,-56}})));
  Modelica.Blocks.Interfaces.RealInput wiISolDifT
    annotation (Placement(transformation(extent={{128,-130},{88,-90}}),
        iconTransformation(extent={{130,-136},{90,-96}})));
  parameter WindowParameters winPar
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
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
  connect(solWin.iSolAbs, solWinSig.iSolAbs) annotation (Line(
      points={{-16,10},{-18,10},{-18,16},{20,16},{20,6},{30,6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDif, solWinSig.iSolDif) annotation (Line(
      points={{-14,-10},{-14,-22},{26,-22},{26,-6},{30,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDir, solWinSig.iSolDir) annotation (Line(
      points={{-18,-10},{-18,-20},{24,-20},{24,0},{30,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWinSig.iSolAbsQ, winISolAbsQ) annotation (Line(
      points={{52,8},{64,8},{64,90},{114,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWinSig.iSolDirQ, winISolDirQ) annotation (Line(
      points={{52,1},{78,1},{78,50},{114,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(winISolAbsT, solWinSig.iSolAbsT) annotation (Line(
      points={{108,-30},{68,-30},{68,4.6},{52,4.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWinSig.iSolDifQ, winISolDifQ) annotation (Line(
      points={{52,-5.2},{70,-5.2},{70,-6},{88,-6},{88,10},{114,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wiISolDifT, solWinSig.iSolDifT) annotation (Line(
      points={{108,-110},{82,-110},{82,-108},{62,-108},{62,-8.1},{51.9,-8.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(winISolDirT, solWinSig.iSolDirT) annotation (Line(
      points={{108,-70},{64,-70},{64,-2},{52,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                               graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-100,100},{100,-100}},lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-94,90},{96,-98}},
          lineColor={0,0,0},
          textString="Solar gains 
windows")}));
end SwWindowResponseIO;

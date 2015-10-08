within IDEAS.Buildings.Linearisation.Components.BaseClasses;
partial model partial_StateSpace "State space model with bus inputs"

  parameter Boolean use_matrix = false;
  parameter Real A[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real B[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real C[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real D[:,:]= zeros(outputs,inputs) annotation(Dialog(enable=use_matrix));

  parameter String fileName = "ssm_mpc.mat";
  parameter Integer nEmb = 2;
  parameter Integer nQConv = 3 "Number of convective heat flow inputs";
  parameter Integer nQRad = 0 "Number of convective heat flow inputs";
  parameter Integer nQConvGai = 3 "Number of convective heat flow gain inputs";
  parameter Integer nQRadGai = 3 "Number of convective heat flow gain inputs";
  parameter Integer[nWin] winNLay = fill(3,nWin) "Number of window layers";
  parameter Integer nWin=2 "Number of windows";
  parameter Integer states = Bsize[1];
  parameter Integer inputs = Bsize[2];
  parameter Integer outputs = Csize[1];
   Modelica.Blocks.Continuous.StateSpace stateSpace(
     A=if use_matrix then A else readMatrix(fileName=fileName, matrixName="A", rows=states, columns=  states),
     B=if use_matrix then B else readMatrix(fileName=fileName, matrixName="B", rows=states, columns=  inputs),
     C=if use_matrix then C else readMatrix(fileName=fileName, matrixName="C", rows=outputs, columns=states),
     D=if use_matrix then D else readMatrix(fileName=fileName, matrixName="D", rows=outputs, columns=inputs),
     x_start=x_start)
     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  parameter Boolean debug=false
    "Set to set to change all heat flow input to zero and all temperature to 293";
protected
  final parameter Integer[2] Bsize = if use_matrix then size(B) else readMatrixSize(fileName=fileName, matrixName="B");
  final parameter Integer[2] Csize = if use_matrix then size(C) else readMatrixSize(fileName=fileName, matrixName="C");

 final parameter Integer[nWin] offWinCon = {sum(winNLay[1:i-1]) + 2*(i-1) for i in 1:nWin}
    "Offset of index for window connections";
  final parameter Integer lastWinCon = if nWin > 0 then offWinCon[end] + winNLay[end] + 2 else 0;
  final parameter Integer[numSolBus] offSolBus = {lastWinCon + (i-1)*3 for i in 1:numSolBus}
    "Total number of input signals in solBus";
  final parameter Integer lastOffSolBus = if numSolBus > 0 then offSolBus[end] + 3 else lastWinCon;
  final parameter Integer lastOfWeaBus = lastOffSolBus + 4;

public
  Modelica.Blocks.Interfaces.RealOutput[stateSpace.nout] y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  parameter Real x_start[states]=zeros(states)
    "Initial or guess values of states";
    input Interfaces.WindowBus[nWin] winBus(nLay=winNLay) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,80})));
  Modelica.Blocks.Interfaces.RealInput Q_flowEmb[nEmb]
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowConv[nQConv]
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowRad[nQRad] annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}),  iconTransformation(
          extent={{-120,-20},{-100,0}})));

  parameter Integer numSolBus=5;

  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  Modelica.Blocks.Interfaces.RealInput Q_flowConvGai[nQConvGai]
    annotation (Placement(transformation(extent={{-140,-72},{-100,-32}}),
        iconTransformation(extent={{-120,-52},{-100,-32}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowRadGai[nQRadGai] annotation (
      Placement(transformation(extent={{-140,-104},{-100,-64}}),
        iconTransformation(extent={{-120,-84},{-100,-64}})));

  Modelica.Blocks.Sources.Constant const3_0[3](k=0)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant const1_0(k=0)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Constant const293(k=293.15)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));

equation
  for i in 1:nWin loop
    if debug then
      connect(const3_0.y, stateSpace.u[offWinCon[i] + 1:(offWinCon[i] + winNLay[
        i])]);
      connect(const1_0.y, stateSpace.u[offWinCon[i]+winNLay[i]+1]);
      connect(const1_0.y, stateSpace.u[offWinCon[i]+winNLay[i]+2]);
    else
      connect(winBus[i].AbsQFlow[1:winNLay[i]], stateSpace.u[offWinCon[i]+1:(offWinCon[i]+winNLay[i])]);
      connect(winBus[i].iSolDir, stateSpace.u[offWinCon[i]+winNLay[i]+1]);
      connect(winBus[i].iSolDif, stateSpace.u[offWinCon[i]+winNLay[i]+2]);
    end if;
  end for;
  for i in 1:numSolBus loop
    if debug then
      connect(const1_0.y, stateSpace.u[offSolBus[i]+1]);
      connect(const1_0.y, stateSpace.u[offSolBus[i]+2]);
      connect(const293.y,   stateSpace.u[offSolBus[i]+3]);
    else
      connect(sim.weaBus.solBus[i].iSolDir, stateSpace.u[offSolBus[i]+1]);
      connect(sim.weaBus.solBus[i].iSolDif, stateSpace.u[offSolBus[i]+2]);
      connect(sim.weaBus.solBus[i].Tenv,   stateSpace.u[offSolBus[i]+3]);
    end if;
  end for;
  if debug then
    connect(const293.y, stateSpace.u[lastOffSolBus+1]);
    connect(sim.weaBus.hConExt, stateSpace.u[lastOffSolBus+2]);
    connect(const1_0.y, stateSpace.u[lastOffSolBus+3]);
    connect(const293.y, stateSpace.u[lastOffSolBus+4]);
  else
    connect(sim.weaBus.Te, stateSpace.u[lastOffSolBus+1]);
    connect(sim.weaBus.hConExt, stateSpace.u[lastOffSolBus+2]);
    connect(sim.weaBus.dummy, stateSpace.u[lastOffSolBus+3]);
    connect(sim.weaBus.TGroundDes, stateSpace.u[lastOffSolBus+4]);
  end if;

  for i in 1:nEmb loop
    if debug then
      connect(const1_0.y,stateSpace.u[lastOfWeaBus+i]);
    else
      connect(Q_flowEmb[i],stateSpace.u[lastOfWeaBus+i]);
    end if;
  end for;
  for i in 1:nQConv loop
    if debug then
      connect(const1_0.y,stateSpace.u[nEmb+lastOfWeaBus+i]);
    else
      connect(Q_flowConv[i],stateSpace.u[nEmb+lastOfWeaBus+i]);
    end if;
  end for;
  for i in 1:nQRad loop
    if debug then
      connect(const1_0.y,stateSpace.u[nEmb+nQConv+lastOfWeaBus+i]);
    else
      connect(Q_flowRad[i],stateSpace.u[nEmb+nQConv+lastOfWeaBus+i]);
    end if;
  end for;
  for i in 1:nQConvGai loop
    if debug then
      connect(const1_0.y,stateSpace.u[nEmb+nQConv+nQRad+lastOfWeaBus+i]);
    else
      connect(Q_flowConvGai[i],stateSpace.u[nEmb+nQConv+nQRad+lastOfWeaBus+i]);
    end if;
  end for;
  for i in 1:nQRadGai loop
    if debug then
      connect(const1_0.y,stateSpace.u[nEmb+nQConv+nQRad+nQConvGai+lastOfWeaBus+i]);
    else
      connect(Q_flowRadGai[i],stateSpace.u[nEmb+nQConv+nQRad+nQConvGai+lastOfWeaBus+i]);
    end if;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Text(
          extent={{-60,40},{60,0}},
          lineColor={0,0,0},
          textString="sx=Ax+Bu"),
        Text(
          extent={{-60,0},{60,-40}},
          lineColor={0,0,0},
          textString=" y=Cx+Du"),
        Line(points={{-100,-10},{-70,-10}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(
          points={{-60,0},{-70,0},{-70,80},{-100,80}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-70,-74},{-100,-74}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,0},{-70,0},{-70,50},{-100,50}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,0},{-70,0},{-70,20},{-100,20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,0},{-70,0},{-70,-42},{-100,-42}},
          color={0,0,255},
          smooth=Smooth.None)}),                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end partial_StateSpace;

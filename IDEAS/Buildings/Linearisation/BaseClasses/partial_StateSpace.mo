within IDEAS.Buildings.Linearisation.BaseClasses;
partial model partial_StateSpace "State space model with bus inputs"

  parameter Boolean use_matrix = false;
  parameter Real A[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real B[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real C[:,:]= zeros(1,1) annotation(Dialog(enable=use_matrix));
  parameter Real D[:,:]= zeros(outputs,inputs) annotation(Dialog(enable=use_matrix));

  parameter String fileName = "linCase900_ssm.mat";
  parameter Integer nEmb = 0;
  parameter Integer nQConv = 0 "Number of convective heat flow inputs";
  parameter Integer nQRad = nQConv "Number of convective heat flow inputs";
  parameter Integer[nWin] winNLay = fill(3,nWin) "Number of window layers";
  parameter Integer nWin=3 "Number of windows";
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

protected
  final parameter Integer[2] Bsize = if use_matrix then size(B) else readMatrixSize(fileName=fileName, matrixName="B");
  final parameter Integer[2] Csize = if use_matrix then size(C) else readMatrixSize(fileName=fileName, matrixName="C");

 final parameter Integer[nWin] offWinCon = {nQConv + nQRad + nEmb + sum(winNLay[1:i-1]) + 2*(i-1) for i in 1:nWin}
    "Offset of index for window connections";
  final parameter Integer lastWinCon = offWinCon[end] + winNLay[end] + 2;
  final parameter Integer[numSolBus] offSolBus = {lastWinCon + (i-1)*3 for i in 1:numSolBus}
    "Total number of input signals in solBus";
  final parameter Integer lastOffSolBus = offSolBus[end] + 3;

public
  Modelica.Blocks.Interfaces.RealOutput[stateSpace.nout] y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  parameter Real x_start[states]=zeros(states)
    "Initial or guess values of states";
  Modelica.Blocks.Interfaces.RealInput Q_flowEmb[nEmb]
    annotation (Placement(transformation(extent={{-130,0},{-90,40}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowConv[nQConv]
    annotation (Placement(transformation(extent={{-128,-48},{-88,-8}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowRad[nQRad] annotation (Placement(
        transformation(extent={{-128,-108},{-88,-68}}),iconTransformation(
          extent={{-128,-108},{-88,-68}})));

  parameter Integer numSolBus=5;

  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  input Interfaces.WindowBus[nWin] winBus(nLay=winNLay) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,60})));
equation
  for i in 1:nEmb loop
     connect(Q_flowEmb[i],stateSpace.u[i]);
  end for;
  for i in 1:nQConv loop
     connect(Q_flowConv[i],stateSpace.u[i+nEmb]);
  end for;
  for i in 1:nQRad loop
     connect(Q_flowRad[i],stateSpace.u[nEmb+nQConv+i]);
  end for;

  for i in 1:nWin loop
    connect(winBus[i].AbsQFlow[1:winNLay[i]], stateSpace.u[offWinCon[i]+1:(offWinCon[i]+winNLay[i])]);
    connect(winBus[i].iSolDir, stateSpace.u[offWinCon[i]+winNLay[i]+1]);
    connect(winBus[i].iSolDif, stateSpace.u[offWinCon[i]+winNLay[i]+2]);
  end for;
  for i in 1:numSolBus loop
    connect(sim.weaBus.solBus[i].iSolDir, stateSpace.u[offSolBus[i]+1]);
    connect(sim.weaBus.solBus[i].iSolDif, stateSpace.u[offSolBus[i]+2]);
    connect(sim.weaBus.solBus[i].Tenv,   stateSpace.u[offSolBus[i]+3]);
  end for;
  connect(sim.weaBus.Te, stateSpace.u[lastOffSolBus+1]);
  connect(sim.weaBus.Tdes, stateSpace.u[lastOffSolBus+2]);
  connect(sim.weaBus.hConExt, stateSpace.u[lastOffSolBus+3]);
  connect(sim.weaBus.dummy, stateSpace.u[lastOffSolBus+4]);
  connect(sim.weaBus.TGroundDes, stateSpace.u[lastOffSolBus+5]);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
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
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(
          points={{-60,0},{-70,0},{-70,60},{-100,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-70,-60},{-98,-60}},
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

within IDEAS.Utilities.IO;
partial model Signal2BusForZone
  parameter Integer nWin=2 "number of windows";
  parameter Integer nOutWall=2 "number of outer walls";
  parameter Integer nLay=2;

  Modelica.Blocks.Interfaces.RealInput winQSolAbs[nWin,nLay]
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput winQSolDir[nWin]
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealInput winQSolDif[nWin]
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput winTSolAbs[nWin,nLay]
    annotation (Placement(transformation(extent={{-100,-160},{-140,-120}}),
        iconTransformation(extent={{-100,-160},{-140,-120}})));
  Modelica.Blocks.Interfaces.RealOutput winTSolDir[nWin]
    annotation (Placement(transformation(extent={{-100,-200},{-140,-160}}),
        iconTransformation(extent={{-100,-200},{-140,-160}})));
  Modelica.Blocks.Interfaces.RealOutput winTSolDif[nWin]
    annotation (Placement(transformation(extent={{-100,-240},{-140,-200}}),
        iconTransformation(extent={{-100,-240},{-140,-200}})));

  Modelica.Blocks.Interfaces.RealInput outWallSolDir[nOutWall]
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput outWallSolDif[nOutWall]
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

equation
  for i in 1:nWin loop
  end for;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -240},{100,100}}), graphics), Icon(coordinateSystem(extent={{-100,
            -240},{100,100}}, preserveAspectRatio=false), graphics));
end Signal2BusForZone;

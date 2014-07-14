within IDEAS.Utilities.IO;
partial model IOZone
  parameter Integer nWin=1 "number of windows";
  parameter Integer nOutWall=1 "number of outer walls";
  parameter Integer nLay=1;
  parameter Integer nEmb=1;
  parameter Integer nZones=1;
  parameter Integer nOut=1 "size of the general vector output of the structure";

  Modelica.Blocks.Interfaces.RealInput winISolAbsQ[nWin,nLay]
    annotation (Placement(transformation(extent={{-142,-170},{-102,-130}})));
  Modelica.Blocks.Interfaces.RealInput winISolDirQ[nWin]
    annotation (Placement(transformation(extent={{-142,-210},{-102,-170}})));
  Modelica.Blocks.Interfaces.RealInput winISolDifQ[nWin]
    annotation (Placement(transformation(extent={{-142,-250},{-102,-210}})));
  Modelica.Blocks.Interfaces.RealOutput winISolAbsT[nWin,nLay] annotation (Placement(
        transformation(extent={{100,-170},{140,-130}}), iconTransformation(extent={{100,-170},{
            140,-130}})));
  Modelica.Blocks.Interfaces.RealOutput winISolDirT[nWin] annotation (Placement(transformation(
          extent={{100,-210},{140,-170}}), iconTransformation(extent={{100,-210},{140,-170}})));
  Modelica.Blocks.Interfaces.RealOutput winISolDifT[nWin] annotation (Placement(transformation(
          extent={{100,-250},{140,-210}}), iconTransformation(extent={{100,-250},{140,-210}})));

  Modelica.Blocks.Interfaces.RealInput outWallSolDir[nOutWall]
    annotation (Placement(transformation(extent={{-142,-70},{-102,-30}})));
  Modelica.Blocks.Interfaces.RealInput outWallSolDif[nOutWall]
    annotation (Placement(transformation(extent={{-142,-110},{-102,-70}})));

  Modelica.Blocks.Interfaces.RealInput TEmb[nEmb]
    annotation (Placement(transformation(extent={{-146,64},{-100,110}}),
        iconTransformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput QConv[nZones]
    annotation (Placement(transformation(extent={{-144,26},{-100,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput QRad[nZones]
    annotation (Placement(transformation(extent={{-142,-12},{-100,30}}),
        iconTransformation(extent={{-140,-10},{-100,30}})));

  Modelica.Blocks.Interfaces.RealOutput TRad[nEmb]
    annotation (Placement(transformation(extent={{100,-10},{140,30}})));
  Modelica.Blocks.Interfaces.RealOutput TConv[nZones]
    annotation (Placement(transformation(extent={{100,30},{140,70}})));
  Modelica.Blocks.Interfaces.RealOutput QEmb[nZones]
    annotation (Placement(transformation(extent={{100,72},{138,110}})));
  Modelica.Blocks.Interfaces.RealOutput genOut[nOut] "general outputs"
    annotation (Placement(transformation(extent={{100,-110},{140,-70}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor[nZones] "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
  heatPortPrescribedTemperature[nEmb] heatEmb
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  heatPortPrescribedHeatFlow[nZones] heatCon
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  heatPortPrescribedHeatFlow[nZones] heatRad
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(TEmb, heatEmb.T) annotation (Line(
      points={{-123,87},{-86,87},{-86,97},{-60.8,97}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QConv, heatCon.Q_flow) annotation (Line(
      points={{-122,48},{-88,48},{-88,57},{-60.8,57}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QRad, heatRad.Q_flow) annotation (Line(
      points={{-121,9},{-86,9},{-86,17},{-60.8,17}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatEmb.Q_flow, QEmb) annotation (Line(
      points={{-61.2,83},{-66,83},{-66,70},{84,70},{84,91},{119,91}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatCon.T, TConv) annotation (Line(
      points={{-61.2,43},{-68,43},{-68,24},{86,24},{86,50},{120,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatRad.T, TRad) annotation (Line(
      points={{-61.2,3},{-68,3},{-68,-12},{86,-12},{86,10},{120,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-240},{100,100}}),
                               graphics), Icon(coordinateSystem(extent={{-100,-240},{100,100}},
                              preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-240}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,50},{-22,38}},
          lineColor={0,0,0},
          textString="Zone heat 
flows"),Rectangle(extent={{-100,100},{0,0}}, lineColor={0,0,0}),
        Rectangle(extent={{-100,-20},{0,-120}}, lineColor={0,0,0}),
        Text(
          extent={{-78,-58},{-26,-78}},
          lineColor={0,0,0},
          textString="Solar gains 
outerwalls"),
        Rectangle(extent={{-100,-140},{0,-240}}, lineColor={0,0,0}),
        Text(
          extent={{-80,-176},{-28,-200}},
          lineColor={0,0,0},
          textString="Solar gains 
windows"),
        Rectangle(extent={{0,100},{100,0}}, lineColor={0,0,0}),
        Text(
          extent={{30,60},{82,34}},
          lineColor={0,0,0},
          textString="Zone heat port 
temperatures"),
        Text(
          extent={{30,-56},{82,-80}},
          lineColor={0,0,0},
          textString="Outputs from
Structure"),
        Rectangle(extent={{0,-20},{100,-120}}, lineColor={0,0,0}),
        Text(
          extent={{30,-174},{80,-200}},
          lineColor={0,0,0},
          textString="Temperatures 
from windows"),
        Rectangle(extent={{0,-140},{100,-240}}, lineColor={0,0,0}),
        Polygon(
          points={{-100,100},{102,100},{0,220},{-100,100}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,148},{-60,202},{-40,202},{-40,158},{-60,148}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end IOZone;

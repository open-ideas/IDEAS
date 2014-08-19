within IDEAS.Buildings.Components.BaseClasses;
model SwWindowResponseHeatPort "Convert the heatPort of IDEAS.Buildings.Components.BaseClasses.SwWindowResponse to signal. The temperature of the heatPorts
  are not important because the heatFlux is set in SwWindowResponse by a prescribed heat flow rate"
  parameter Integer nLay(min=1) "number of layers";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDif
    "transmitted difuse solar riadtion"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir
    "transmitted direct solar riadtion"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nLay] iSolAbs
    "solar absorptance in the panes"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  IDEAS.Utilities.IO.heatPortPrescribedTemperature[nLay] converter1
    annotation (Placement(transformation(extent={{52,50},{72,70}})));
  IDEAS.Utilities.IO.heatPortPrescribedTemperature converter2
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  IDEAS.Utilities.IO.heatPortPrescribedTemperature converter3
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Interfaces.RealOutput[nLay] iSolAbsQ
    annotation (Placement(transformation(extent={{-100,60},{-140,100}}),
        iconTransformation(extent={{-100,60},{-140,100}})));
  Modelica.Blocks.Interfaces.RealOutput iSolDirQ
    annotation (Placement(transformation(extent={{-100,-10},{-140,30}}),
        iconTransformation(extent={{-100,-10},{-140,30}})));
  Modelica.Blocks.Interfaces.RealOutput iSolDifQ
    annotation (Placement(transformation(extent={{-100,-72},{-140,-32}}),
        iconTransformation(extent={{-100,-72},{-140,-32}})));

  Modelica.Blocks.Sources.RealExpression TDum[nLay](y=293.15)
    "dummy temperature"
    annotation (Placement(transformation(extent={{10,58},{30,78}})));
  Modelica.Blocks.Sources.RealExpression TDum1(y=293.15) "Dummy temperature"
    annotation (Placement(transformation(extent={{12,-2},{32,18}})));
  Modelica.Blocks.Sources.RealExpression TDum2(y=293.15) "Dummy temperature"
    annotation (Placement(transformation(extent={{14,-62},{34,-42}})));
equation
  connect(converter1.port1, iSolAbs) annotation (Line(
      points={{72,60},{100,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(converter2.port1, iSolDir) annotation (Line(
      points={{70,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(converter3.port1, iSolDif) annotation (Line(
      points={{70,-60},{100,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(iSolAbsQ,converter1. Q_flow) annotation (Line(
      points={{-120,80},{-34,80},{-34,53},{50.8,53}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDirQ,converter2. Q_flow) annotation (Line(
      points={{-120,10},{-36,10},{-36,-7},{48.8,-7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDifQ,converter3. Q_flow) annotation (Line(
      points={{-120,-52},{-34,-52},{-34,-67},{48.8,-67}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TDum.y, converter1.T) annotation (Line(
      points={{31,68},{42,68},{42,67},{51.2,67}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(converter2.T, TDum1.y) annotation (Line(
      points={{49.2,7},{42,7},{42,8},{33,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TDum2.y, converter3.T) annotation (Line(
      points={{35,-52},{42,-52},{42,-53},{49.2,-53}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end SwWindowResponseHeatPort;

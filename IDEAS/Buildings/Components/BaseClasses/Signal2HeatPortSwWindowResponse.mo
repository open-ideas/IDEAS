within IDEAS.Buildings.Components.BaseClasses;
model Signal2HeatPortSwWindowResponse
//   replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazing
//     constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type"
//     annotation (__Dymola_choicesAllMatching=true, Dialog(group=
//           "Construction details"));
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
  IDEAS.Utilities.IO.heatPortPrescribedTemperature[nLay] iSolAbsSig
    annotation (Placement(transformation(extent={{52,50},{72,70}})));
  IDEAS.Utilities.IO.heatPortPrescribedTemperature iSolDirSig
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  IDEAS.Utilities.IO.heatPortPrescribedTemperature iSolDifSig
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Interfaces.RealOutput[nLay] QISolAbsSig
    annotation (Placement(transformation(extent={{-100,60},{-140,100}}),
        iconTransformation(extent={{-100,60},{-140,100}})));
  Modelica.Blocks.Interfaces.RealOutput QISolDirSig
    annotation (Placement(transformation(extent={{-100,-10},{-140,30}}),
        iconTransformation(extent={{-100,-10},{-140,30}})));
  Modelica.Blocks.Interfaces.RealInput[nLay] TISolAbsSig annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-122,50}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,46})));
  Modelica.Blocks.Interfaces.RealInput TISolDirSig annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-122,-12}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-20})));
  Modelica.Blocks.Interfaces.RealOutput QISolDifSig
    annotation (Placement(transformation(extent={{-100,-72},{-140,-32}}),
        iconTransformation(extent={{-100,-72},{-140,-32}})));
  Modelica.Blocks.Interfaces.RealInput TISolDifSig annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,-72}), iconTransformation(
        extent={{19,-19},{-19,19}},
        rotation=180,
        origin={-119,-81})));
equation
  connect(iSolAbsSig.port1, iSolAbs) annotation (Line(
      points={{72,60},{100,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(iSolDirSig.port1, iSolDir) annotation (Line(
      points={{70,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(iSolDifSig.port1, iSolDif) annotation (Line(
      points={{70,-60},{100,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TISolAbsSig, iSolAbsSig.T) annotation (Line(
      points={{-122,50},{-36,50},{-36,67},{51.2,67}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QISolAbsSig, iSolAbsSig.Q_flow) annotation (Line(
      points={{-120,80},{-34,80},{-34,53},{50.8,53}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QISolDirSig, iSolDirSig.Q_flow) annotation (Line(
      points={{-120,10},{-36,10},{-36,-7},{48.8,-7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TISolDirSig, iSolDirSig.T) annotation (Line(
      points={{-122,-12},{-36,-12},{-36,7},{49.2,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QISolDifSig, iSolDifSig.Q_flow) annotation (Line(
      points={{-120,-52},{-34,-52},{-34,-67},{48.8,-67}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TISolDifSig, iSolDifSig.T) annotation (Line(
      points={{-120,-72},{-38,-72},{-38,-53},{49.2,-53}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QISolDirSig, QISolDirSig) annotation (Line(
      points={{-120,10},{-113,10},{-113,10},{-120,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Signal2HeatPortSwWindowResponse;

within IDEAS.Buildings.Components.BaseClasses;
model HeatPort2SignalSwWindowResponse
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
  Utilities.IO.heatPortPrescribedHeatFlow[nLay] iSolAbsSig
    annotation (Placement(transformation(extent={{52,50},{72,70}})));
  Utilities.IO.heatPortPrescribedHeatFlow iSolDirSig
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Utilities.IO.heatPortPrescribedHeatFlow iSolDifSig
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Interfaces.RealInput[nLay] QISolAbsSig
    annotation (Placement(transformation(extent={{-128,50},{-88,90}})));
  Modelica.Blocks.Interfaces.RealInput QISolDirSig
    annotation (Placement(transformation(extent={{-128,-10},{-88,30}})));
  Modelica.Blocks.Interfaces.RealOutput[nLay] TISolAbsSig annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,50})));
  Modelica.Blocks.Interfaces.RealOutput TISolDirSig annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,-12})));
  Modelica.Blocks.Interfaces.RealInput QISolDifSig
    annotation (Placement(transformation(extent={{-126,-70},{-86,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TISolDifSig annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-108,-72})));
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
  connect(iSolAbsSig.Q_flow, QISolAbsSig) annotation (Line(
      points={{51.2,67},{-24.4,67},{-24.4,70},{-108,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDirSig.Q_flow, QISolDirSig) annotation (Line(
      points={{49.2,7},{-25.4,7},{-25.4,10},{-108,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolAbsSig.T, TISolAbsSig) annotation (Line(
      points={{50.8,53},{-26.6,53},{-26.6,50},{-110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDirSig.T, TISolDirSig) annotation (Line(
      points={{48.8,-7},{-25.6,-7},{-25.6,-12},{-110,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDifSig.Q_flow, QISolDifSig) annotation (Line(
      points={{49.2,-53},{-25.4,-53},{-25.4,-50},{-106,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDifSig.T, TISolDifSig) annotation (Line(
      points={{48.8,-67},{-24,-67},{-24,-72},{-108,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPort2SignalSwWindowResponse;

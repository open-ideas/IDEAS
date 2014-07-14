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
  Interfaces.winSigBus winSigBus(nLay=nLay)
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
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
  connect(iSolDirSig.Q_flow, winSigBus.QISolDirSig) annotation (Line(
      points={{49.2,7},{0,7},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolDirSig.T, winSigBus.TISolDirSig) annotation (Line(
      points={{48.8,-7},{0,-7},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolDifSig.Q_flow, winSigBus.QISolDifSig) annotation (Line(
      points={{49.2,-53},{0,-53},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolDifSig.T, winSigBus.TISolDifSig) annotation (Line(
      points={{48.8,-67},{0,-67},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolAbsSig[:].Q_flow, winSigBus.QISolAbsSig[:]) annotation (Line(
      points={{51.2,67},{0,67},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolAbsSig[:].T, winSigBus.TISolAbsSig[:]) annotation (Line(
      points={{50.8,53},{0,53},{0,-100}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPort2SignalSwWindowResponse;

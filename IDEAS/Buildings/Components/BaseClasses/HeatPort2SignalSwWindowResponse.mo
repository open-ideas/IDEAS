within IDEAS.Buildings.Components.BaseClasses;
model HeatPort2SignalSwWindowResponse

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
  Utilities.IO.heatPortPrescribedHeatFlow iSolDirSig_b
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Utilities.IO.heatPortPrescribedHeatFlow iSolDifSig_b
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Interfaces.heatToSigWindBus heatToSigWindBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
equation
  connect(iSolAbsSig.port1, iSolAbs) annotation (Line(
      points={{72,60},{100,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(iSolDirSig_b.port1, iSolDir) annotation (Line(
      points={{70,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(iSolDifSig_b.port1, iSolDif) annotation (Line(
      points={{70,-60},{100,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPort2SignalSwWindowResponse;

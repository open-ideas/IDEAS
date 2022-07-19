within IDEAS.Buildings.Components.Shading.Interfaces;
partial model PartialShadingDevice
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(TDryBul=Te);
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation skyRadFra(
    A = A_frame,
    Tenv_nom = Tenv_nom,
    epsLw = epsLw_frame,
    linearise = linRad) if haveBoundaryPorts and haveFrame annotation (
    Placement(visible = true, transformation(origin = {0, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection eConFra(
    A = A_frame,
    azi = azi,
    inc = inc,
    linearise = linCon) if haveBoundaryPorts and haveFrame annotation (
    Placement(visible = true, transformation(origin = {0, 176}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorSolarAbsorption solAbs(
  A = A_frame,
  epsSw = epsSw_frame) if haveBoundaryPorts and haveFrame annotation (
    Placement(visible = true, transformation(extent = {{10, 150}, {-10, 170}}, rotation = 0)));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation skyRad(
  A = A_glazing,
  Tenv_nom = Tenv_nom,
  epsLw = epsLw_glazing,
  linearise = linRad) if haveBoundaryPorts annotation (
    Placement(visible = true, transformation(origin = {2, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection eCon(
  A = A_glazing,
  azi = azi,
   inc = inc,
   linearise = linCon) if haveBoundaryPorts annotation (
    Placement(visible = true, transformation(extent = {{12, 104}, {-8, 124}}, rotation = 0)));
  Modelica.Blocks.Math.Add solDif(k1 = 1, k2 = 1) if haveBoundaryPorts and haveFrame annotation (
    Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(skyRadFra.port_a, port_frame) annotation(
    Line(points = {{10, 192}, {55, 192}, {55, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(skyRadFra.Tenv, TEnv) annotation(
    Line(points = {{-10, 192}, {-20, 192}, {-20, 90}, {-60, 90}}, color = {0, 0, 127}));
  connect(eConFra.port_a, port_frame) annotation(
    Line(points = {{10, 176}, {55, 176}, {55, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(eConFra.hForcedConExt, hForcedConExt) annotation(
    Line(points = {{-12, 172}, {-36, 172}, {-36, 110}, {-60, 110}}, color = {0, 0, 127}));
  connect(solAbs.port_a, port_frame) annotation(
    Line(points = {{10, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(eConFra.Te, Te) annotation(
    Line(points = {{-12, 176.4}, {-60, 176.4}, {-60, 130}}, color = {0, 0, 127}));
  connect(solDif.u2, HShaGroDifTil) annotation(
    Line(points = {{78, 24}, {40, 24}, {40, 10}}, color = {0, 0, 127}));
  connect(solDif.u1, HShaSkyDifTil) annotation(
    Line(points = {{78, 36}, {40, 36}, {40, 30}}, color = {0, 0, 127}));
  connect(solDif.y, solAbs.solDif) annotation(
    Line(points = {{101, 30}, {108, 30}, {108, 142}, {-10, 142}, {-10, 162}}, color = {0, 0, 127}));
  connect(solAbs.solDir, HShaDirTil) annotation(
    Line(points = {{-10, 166}, {-14, 166}, {-14, 90}, {40, 90}, {40, 50}}, color = {0, 0, 127}));
  connect(eCon.hForcedConExt, hForcedConExt) annotation(
    Line(points = {{-10, 110}, {-60, 110}}, color = {0, 0, 127}));
  connect(eCon.Te, Te) annotation(
    Line(points = {{-10, 114.4}, {-60, 114.4}, {-60, 130}}, color = {0, 0, 127}));
  connect(skyRad.Tenv, TEnv) annotation(
    Line(points = {{-8, 130}, {-20, 130}, {-20, 90}, {-60, 90}}, color = {0, 0, 127}));
  connect(eCon.port_a, port_glazing) annotation(
    Line(points = {{12, 114}, {60, 114}, {60, 120}, {100, 120}}, color = {191, 0, 0}));
  connect(skyRad.port_a, port_glazing) annotation(
    Line(points = {{12, 130}, {60, 130}, {60, 120}, {100, 120}}, color = {191, 0, 0}));
  annotation (
    Documentation(revisions="<html>
<ul>
<li>
July 18, 2022, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>Shading connections and default thermal boundary conditions.</p>
</html>"));
end PartialShadingDevice;
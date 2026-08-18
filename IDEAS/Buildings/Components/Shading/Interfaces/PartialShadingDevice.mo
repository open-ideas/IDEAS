within IDEAS.Buildings.Components.Shading.Interfaces;
partial model PartialShadingDevice
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading;
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
    Placement(visible = true, transformation(origin={50,90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression TeExpr(y=Te_internal)
    "Expression for Te"
    annotation (Placement(transformation(extent={{-68,178},{-48,198}})));
  Modelica.Blocks.Sources.RealExpression TEnvExpr(y=TEnv_internal)
    "Expression for TEnv"
    annotation (Placement(transformation(extent={{-68,160},{-48,180}})));
  Modelica.Blocks.Sources.RealExpression TDryBulExp(y=TDryBul_internal)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Routing.RealPassThrough HShaDir
    annotation (Placement(transformation(extent={{0,44},{12,56}})));
  Modelica.Blocks.Routing.RealPassThrough HShaSkyDif
    annotation (Placement(transformation(extent={{0,24},{12,36}})));
  Modelica.Blocks.Routing.RealPassThrough HShaSkyGro
    annotation (Placement(transformation(extent={{0,4},{12,16}})));
protected
  Modelica.Blocks.Interfaces.RealInput TDryBul_internal = Te_internal
    "Internal variable to avoid assigning a value to a non-input in the model extends statement";
  Modelica.Blocks.Interfaces.RealInput TEnv_internal
    "Internal variable to avoid assigning a value to a non-input in the model extends statement";
equation
  connect(TEnv_internal,TEnv);
  if not haveBoundaryPorts then
    TEnv_internal = 273.15;
  end if;

  connect(skyRadFra.port_a, port_frame) annotation (
    Line(points = {{10, 192}, {55, 192}, {55, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(eConFra.port_a, port_frame) annotation (
    Line(points = {{10, 176}, {55, 176}, {55, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(eConFra.hForcedConExt, hForcedConExt) annotation (
    Line(points = {{-12, 172}, {-36, 172}, {-36, 110}, {-60, 110}}, color = {0, 0, 127}));
  connect(solAbs.port_a, port_frame) annotation (
    Line(points = {{10, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(solDif.y, solAbs.solDif) annotation (
    Line(points={{61,90},{64,90},{64,106},{16,106},{16,100},{-18,100},{-18,142},
          {-20,142},{-20,162},{-10,162}},                                     color = {0, 0, 127}));
  connect(eCon.hForcedConExt, hForcedConExt) annotation (
    Line(points = {{-10, 110}, {-60, 110}}, color = {0, 0, 127}));
  connect(eCon.port_a, port_glazing) annotation (
    Line(points = {{12, 114}, {60, 114}, {60, 120}, {100, 120}}, color = {191, 0, 0}));
  connect(skyRad.port_a, port_glazing) annotation (
    Line(points = {{12, 130}, {60, 130}, {60, 120}, {100, 120}}, color = {191, 0, 0}));
  connect(eConFra.Te, TeExpr.y) annotation (Line(points={{-12,176.4},{-36,176.4},
          {-36,188},{-47,188}}, color={0,0,127}));
  connect(eCon.Te, TeExpr.y) annotation (Line(points={{-10,114.4},{-20,114.4},{
          -20,116},{-32,116},{-32,188},{-47,188}}, color={0,0,127}));
  connect(skyRad.Tenv, TEnvExpr.y) annotation (Line(points={{-8,130},{-24,130},
          {-24,170},{-47,170}}, color={0,0,127}));
  connect(skyRadFra.Tenv, TEnvExpr.y) annotation (Line(points={{-10,192},{-24,
          192},{-24,170},{-47,170}}, color={0,0,127}));
  connect(TDryBulExp.y, TDryBul)
    annotation (Line(points={{1,-10},{40,-10}}, color={0,0,127}));
  connect(HShaDir.y, HShaDirTil)
    annotation (Line(points={{12.6,50},{40,50}}, color={0,0,127}));
  connect(HShaDir.y, solAbs.solDir) annotation (Line(points={{12.6,50},{16,50},
          {16,98},{-20,98},{-20,112},{-22,112},{-22,166},{-10,166}}, color={0,0,
          127}));
  connect(HShaSkyDif.y, HShaSkyDifTil)
    annotation (Line(points={{12.6,30},{40,30}}, color={0,0,127}));
  connect(HShaSkyGro.y, HShaGroDifTil)
    annotation (Line(points={{12.6,10},{40,10}}, color={0,0,127}));
  connect(HShaSkyDif.y, solDif.u1) annotation (Line(points={{12.6,30},{16,30},{
          16,96},{38,96}}, color={0,0,127}));
  connect(HShaSkyGro.y, solDif.u2) annotation (Line(points={{12.6,10},{16,10},{
          16,84},{38,84}}, color={0,0,127}));
  annotation (
    Documentation(revisions="<html>
<ul>
<li>
July 03, 2026, by Klaas De Jonge:<br/>
Refactored model to avoid illegal way of connections to avoid warnings.
</li>
<li>
July 18, 2022, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>Shading connections and default thermal boundary conditions.</p>
</html>"));
end PartialShadingDevice;

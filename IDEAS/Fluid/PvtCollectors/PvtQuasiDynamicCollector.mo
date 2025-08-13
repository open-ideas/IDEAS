within IDEAS.Fluid.PVTCollectors;
model PVTQuasiDynamicCollector
  "Model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
    redeclare IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic per);

  // ===== Parameters =====
  parameter Modelica.Units.SI.Efficiency eleLosFac(min=0, max=1) = 0.10
    "Loss factor of the PV panel(s)" annotation(Dialog(group="Electrical parameters"));
  parameter IDEAS.Fluid.PVTCollectors.Types.CollectorType collectorType = IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered
    "Type of collector (used to select (tau*alpha)_eff)";
  parameter Modelica.Units.SI.DimensionlessRatio tauAlpEff(min=0, max=1) =
    (if collectorType == IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered then 0.901 else 0.84)
    "Effective transmittance–absorptance product";

  // ===== Output Connectors =====
  Modelica.Blocks.Interfaces.RealOutput pEl
    "Total electrical power output [W/m2]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput qTh "Total thermal power output [W/m2]"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput winSpeTil "Effective wind speed normal to collector plane";
  Modelica.Blocks.Interfaces.RealInput qThSeg[nSeg] "Thermal power per segment";
  Modelica.Blocks.Interfaces.RealInput HGloTil;


  // ===== Subcomponents =====
  final IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain solGaiStc(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final incAngDat=per.incAngDat,
    final incAngModDat=per.incAngModDat,
    final iamDiff=per.IAMDiff,
    final eta0=per.eta0,
    final use_shaCoe_in=use_shaCoe_in,
    final shaCoe=shaCoe,
    final A_c=ATot_internal)
    "Identifies heat gained from the sun using the ISO 9806:2013 quasi-dynamic standard calculations"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));

  final IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss heaLosStc(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final c1=per.c1,
    final c2=per.c2,
    final c3=per.c3,
    final c4=per.c4,
    final c6=per.c6,
    final A_c=ATot_internal)
    "Calculates the heat lost to the surroundings using the ISO 9806:2013 quasi-dynamic standard calculations"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));

  final IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT eleGen(
    final nSeg = nSeg,
    final A_c = ATot_internal,
    final eleLosFac = eleLosFac,
    final gamma = per.gamma,
    final P_nominal = per.P_nominal,
    final A = per.A,
    final eta0 = per.eta0,
    final tauAlpEff = tauAlpEff,
    final c1 = per.c1,
    final etaEl = per.etaEl)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

equation
  // Compute effective wind speed on tilted plane
  winSpeTil = weaBus.winSpe * sqrt(1 - (
    cos(weaBus.winDir - (azi + Modelica.Constants.pi)) * cos(til)
    + sin(weaBus.winDir - (azi + Modelica.Constants.pi)) * sin(til))^2);

  // Compute global irradiance on tilted surface
  HGloTil = HDifTilIso.H + HDirTil.H;

  // Compute per-segment thermal power
  for i in 1:nSeg loop
    qThSeg[i] = (QGai[i].Q_flow + QLos[i].Q_flow) / (ATot_internal / nSeg);
  end for;

  // Assign electrical and thermal outputs
  pEl = eleGen.pEl;
  qTh = sum(QGai.Q_flow + QLos.Q_flow);

  // Validity check
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));

  // ===== Connectors =====
  connect(shaCoe_internal, solGaiStc.shaCoe_in);
  connect(HDirTil.inc, solGaiStc.incAng) annotation (Line(
      points={{-59,46},{-50,46},{-50,48},{-22,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTilIso.H, solGaiStc.HSkyDifTil) annotation (Line(
      points={{-59,80},{-30,80},{-30,58},{-22,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil.H, solGaiStc.HDirTil) annotation (Line(
      points={{-59,50},{-50,50},{-50,52},{-22,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaCoe_in, solGaiStc.shaCoe_in) annotation (Line(
      points={{-120,40},{-40,40},{-40,45},{-22,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solGaiStc.QSol_flow, QGai.Q_flow) annotation (Line(
      points={{1,50},{50,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temSen.T, solGaiStc.TFlu) annotation (Line(
      points={{-11,-20},{-30,-20},{-30,42},{-22,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLosStc.QLos_flow, QLos.Q_flow)
    annotation (Line(points={{1,20},{50,20}}, color={0,0,127}));
  connect(heaLosStc.TFlu, temSen.T) annotation (Line(points={{-22,14},{-30,14},{
          -30,-20},{-11,-20}}, color={0,0,127}));
  connect(weaBus.TDryBul, heaLosStc.TEnv) annotation (Line(
      points={{-99.95,80.05},{-100,80.05},{-100,80},{-90,80},{-90,26},{-22,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HHorIR, heaLosStc.HHorIR) annotation (Line(
      points={{-99.95,80.05},{-90,80.05},{-90,20},{-22,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(temSen.T, eleGen.Tm) annotation (Line(points={{-11,-20},{-30,-20}, {-30,-64},{-22,-64}}, color={0,0,127}));
  connect(qThSeg, eleGen.qth);
  connect(HGloTil, eleGen.HGloTil);
  connect(HGloTil, heaLosStc.HGloTil);
  connect(winSpeTil, heaLosStc.winSpePla);

    annotation (
  defaultComponentName = "PvtCol",

Documentation(info = "<html>
<p>
This component models a photovoltaic–thermal (PVT) collector by coupling the ISO 9806 quasi-dynamic thermal method with an internal electrical model. The model uses only datasheet parameters (no measured calibration data) and has been validated experimentally for unglazed PVT collectors (with and without rear insulation) under a wide range of weather conditions.
</p>
<p>
The main equations used in this model can be found in the following submodels, as described in the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.UsersGuide\">
IDEAS.Fluid.PVTCollectors.UsersGuide.
</a>
</p>
<ul>
<li>
Electrical generation: see 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT\">
IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT
</a>
</li>
<li>
Quasi-dynamic thermal losses: see 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss\">
IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss
</a>
</li>
<li>
Solar (thermal) heat gain: see 
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain
</a>
</li>
</ul>
<h4>Implementation Notes</h4>
<p>
This model supports PVT collectors, discretized into segments to capture temperature gradients. It is compatible with dynamic simulations where irradiance and fluid temperatures vary over time.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model; tracked in 
<a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
IDEAS #1436
</a>.
</li>
</ul>
</html>"),

      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-84,100},{84,-100}}, lineColor={27,0,55}, fillColor={26,0,55}, fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-76,0},{-76,-90},{66,-90},{66,-60},{-64,-60},{-64,-30},{66,-30},{66,0},{-64,0},{-64,28},{66,28},{66,60},{-64,60},{-64,86},{78,86},{78,0},{98,0},{100,0}}, color={0,128,255}, thickness=1),
        Ellipse(extent={{-24,26},{28,-26}}, lineColor={255,255,0}, fillColor={255,255,0}, fillPattern=FillPattern.Solid),
        Line(points={{-6,-6},{8,8}}, color={255,255,0}, origin={-24,30}, rotation=90),
        Line(points={{-50,0},{-30,0}}, color={255,255,0}),
        Line(points={{-36,-40},{-20,-24}}, color={255,255,0}),
        Line(points={{-10,0},{10,0}}, color={255,255,0}, origin={2,-40}, rotation=90),
        Line(points={{-8,-8},{6,6}}, color={255,255,0}, origin={30,-30}, rotation=90),
        Line(points={{32,0},{52,0}}, color={255,255,0}),
        Line(points={{-8,-8},{6,6}}, color={255,255,0}, origin={28,32}, rotation=180),
        Line(points={{-10,0},{10,0}}, color={255,255,0}, origin={0,40}, rotation=90),
        Polygon(points={{72,96},{36,26},{60,34},{48,-24},{88,58},{64,48},{72,96}}, lineColor={0,0,0}, fillColor={0,255,0}, fillPattern=FillPattern.Solid)}));
end PVTQuasiDynamicCollector;

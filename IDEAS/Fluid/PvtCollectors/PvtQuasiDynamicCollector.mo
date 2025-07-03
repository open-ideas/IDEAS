within IDEAS.Fluid.PVTCollectors;
model PVTQuasiDynamicCollector
  "Model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.PVTCollectors.BaseClasses.PartialPVTCollector
    (redeclare IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic per);

  final Modelica.Units.SI.Velocity windSpeTil "Effective wind speed normal to collector plane";

  final IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain solGai(
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
  final IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss heaLos(
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

equation
   // Compute plane wind speed (using inherited azi/til and connected weaBus):
  winSpeTil = weaBus.winSpe
    * sqrt(1 - (
      cos(weaBus.winDir - (azi + Modelica.Constants.pi)) * cos(til)
    + sin(weaBus.winDir - (azi + Modelica.Constants.pi)) * sin(til))
   ^2);
  heaLos.winSpePla = winSpeTil;
  heaLos.HGloTil = HGloTil;

  // Make sure the model is only used with the ISO 9806:2013 quasi-dynamic ratings data, and hence c1 > 0
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));

  connect(shaCoe_internal, solGai.shaCoe_in);
  connect(HDirTil.inc, solGai.incAng)    annotation (Line(
      points={{-59,46},{-50,46},{-50,48},{-22,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTilIso.H, solGai.HSkyDifTil) annotation (Line(
      points={{-59,80},{-30,80},{-30,58},{-22,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil.H, solGai.HDirTil) annotation (Line(
      points={{-59,50},{-50,50},{-50,52},{-22,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaCoe_in, solGai.shaCoe_in) annotation (Line(
      points={{-120,40},{-40,40},{-40,45},{-22,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solGai.QSol_flow, QGai.Q_flow) annotation (Line(
      points={{1,50},{50,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temSen.T, solGai.TFlu) annotation (Line(
      points={{-11,-20},{-30,-20},{-30,42},{-22,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLos.QLos_flow, QLos.Q_flow) annotation (Line(points={{1,20},{50,20}}, color={0,0,127}));
  connect(heaLos.TFlu, temSen.T) annotation (Line(points={{-22,14},{-30,14},{-30,
          -20},{-11,-20}}, color={0,0,127}));
  connect(weaBus.TDryBul, heaLos.TEnv) annotation (Line(
      points={{-99.95,80.05},{-100,80.05},{-100,80},{-90,80},{-90,26},{-22,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HHorIR, heaLos.HHorIR) annotation (Line(
      points={{-99.95,80.05},{-90,80.05},{-90,20},{-22,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  annotation (
  defaultComponentName="PvtCol",
  Documentation(info = "<html>
  <p>
    This component models a photovoltaic–thermal (PVT) collector by
    coupling the ISO 9806 quasi-dynamic thermal method
    with an internal electrical model. The model uses only
    datasheet parameters (no measured calibration data). The
    electrical output is calculated via a two-node PV–fluid coupling.
    The model has been validated experimentally on unglazed (with and without 
    rear insulation) PVT collectors under a wide range of weather conditions.
  </p>
  <h4>References</h4>
  <ul>
    <li>
      Meertens, L., Jansen, J., Helsen, L. (2025). “Development and
      Experimental Validation of an Unglazed Photovoltaic-Thermal
      Collector Modelica Model that only needs Datasheet Parameters.”
      <em>Proceedings of the Modelica Conference 2025</em>.
    </li>
    <li>
      ISO 9806:2017. “Solar thermal collectors—Test methods.” CEN,
      European Committee for Standardization.
    </li>
    <li>
      IDEAS issue:
      <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
      Implement validated dynamic PVT collector model (based on EN12975 + electrical coupling) #1436</a>
    </li>
  </ul>
  </html>"),
  revisions = "<html>
  <ul>
    <li>
      June 12, 2025, by Lone Meertens:<br/>
      Added validated quasi-dynamic PVT collector model that couples the
      ISO 9806:2013 quasi-dynamic thermal calculations with electrical generation
      submodel using only manufacturer datasheet parameters.
      This work is tracked in
      <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
      IDEAS, #1436</a>.
    </li>
  </ul>
  </html>",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
      graphics={
        Rectangle(
          extent={{-84,100},{84,-100}},
          lineColor={27,0,55},
          fillColor={26,0,55},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,0},{-76,0},{-76,-90},{66,-90},{66,-60},{-64,-60},{-64,
              -30},{66,-30},{66,0},{-64,0},{-64,28},{66,28},{66,60},{-64,60},{
              -64,86},{78,86},{78,0},{98,0},{100,0}},
          color={0,128,255},
          thickness=1,
          smooth=Smooth.None),
        Ellipse(
          extent={{-24,26},{28,-26}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-6,-6},{8,8}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1,
          origin={-24,30},
          rotation=90),
        Line(
          points={{-50,0},{-30,0}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-36,-40},{-20,-24}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-10,0},{10,0}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1,
          origin={2,-40},
          rotation=90),
        Line(
          points={{-8,-8},{6,6}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1,
          origin={30,-30},
          rotation=90),
        Line(
          points={{32,0},{52,0}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-8,-8},{6,6}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1,
          origin={28,32},
          rotation=180),
        Line(
          points={{-10,0},{10,0}},
          color={255,255,0},
          smooth=Smooth.None,
          thickness=1,
          origin={0,40},
          rotation=90),
        Polygon(
          points={{72,96},{36,26},{60,34},{48,-24},{88,58},{64,48},{72,96}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid)}));
end PVTQuasiDynamicCollector;

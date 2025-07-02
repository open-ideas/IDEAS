within IDEAS.Fluid.PvtCollectors.Validation.PVT2;
model QDPvtCollectorValidationPVT2
  "Model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.PvtCollectors.Validation.PVT2.BaseClasses.PartialPvtCollectorValidation
    (redeclare IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per);

  IDEAS.Fluid.PvtCollectors.Validation.BaseClasses.EN12975QuasiDynamicHeatLossValidation
    heaLos(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final c1=per.c1,
    final c2=per.c2,
    final c3=per.c3,
    final c4=per.c4,
    final c6=per.c6,
    final A_c=ATot_internal)
    "Calculates the heat lost to the surroundings using the EN12975 standard calculations"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));

  Modelica.Blocks.Sources.RealExpression globIrrTil(y=(meaDat.y[4])) "[W/m2]"
    annotation (Placement(transformation(extent={{-67.5,6},{-48.5,22}})));
  Modelica.Blocks.Sources.RealExpression winSpe(y=(meaDat.y[10])) "[W/m2]"
    annotation (Placement(transformation(extent={{-67.5,16},{-48.5,32}})));
  BaseClasses.EN12975SolarGainHGlob solGai(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final eta0=per.eta0,
    final use_shaCoe_in=use_shaCoe_in,
    final shaCoe=shaCoe,
    final A_c=ATot_internal)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.RealExpression Gglob(y=meaDat.y[4]) "[W/m2]"
    annotation (Placement(transformation(extent={{-51.5,66},{-32.5,82}})));
equation


  // Make sure the model is only used with the EN ratings data, and hence c1 > 0
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));

  connect(heaLos.TFlu, temSen.T) annotation (Line(
      points={{-22,14},{-30,14},{-30,-20},{-11,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLos.QLos_flow, QLos.Q_flow) annotation (Line(
      points={{1,20},{26,20},{26,20},{50,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, heaLos.TEnv) annotation (Line(
      points={{-99.95,80.05},{-100,80.05},{-100,80},{-90,80},{-90,26},{-22,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HHorIR, heaLos.E_L) annotation (Line(
      points={{-99.95,80.05},{-94,80.05},{-94,80},{-90,80},{-90,10},{-32,10},{
          -32,10.1},{-22.1,10.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(globIrrTil.y, heaLos.G) annotation (Line(points={{-47.55,14},{-32,14},
          {-32,17.9},{-21.9,17.9}}, color={0,0,127}));
  connect(winSpe.y, heaLos.u) annotation (Line(points={{-47.55,24},{-32,24},{
          -32,22.1},{-22.1,22.1}}, color={0,0,127}));
  connect(solGai.QSol_flow, QGai.Q_flow)
    annotation (Line(points={{1,50},{50,50}}, color={0,0,127}));
  connect(temSen.T, solGai.TFlu) annotation (Line(points={{-11,-20},{-30,-20},{-30,
          42},{-22,42}}, color={0,0,127}));
  connect(Gglob.y, solGai.HGlob) annotation (Line(points={{-31.55,74},{-30,74},{
          -30,58},{-22,58}}, color={0,0,127}));
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
end QDPvtCollectorValidationPVT2;

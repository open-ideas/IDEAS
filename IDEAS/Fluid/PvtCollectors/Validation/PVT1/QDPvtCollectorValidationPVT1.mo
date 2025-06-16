within IDEAS.Fluid.PvtCollectors.Validation.PVT1;
model QDPvtCollectorValidationPVT1
  "Model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.PvtCollectors.Validation.PVT1.BaseClasses.PartialPvtCollectorValidationPVT1
    (redeclare IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per);

  Real windSpeTil "Effective wind speed normal to collector plane";
  output Real pel = pelOut   "Total electrical power output (W)";
  output Real qTh = qThOut   "Total thermal power output (W)";
  output Real temMod = temModOut   "Average cell (module) temperature (K)";
  output Real temMea = temMeaOut   "Average fluid temperature (K)";

  IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain solGai(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final incAngDat=per.incAngDat,
    final incAngModDat=per.incAngModDat,
    final iamDiff=per.IAMDiff,
    final eta0=per.eta0,
    final use_shaCoe_in=use_shaCoe_in,
    final shaCoe=shaCoe,
    final A_c=ATot_internal)
    "Identifies heat gained from the sun using the EN12975 standard calculations"
     annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  IDEAS.Fluid.PvtCollectors.Validation.PVT1.BaseClasses.EN12975HeatLossValidationPVT1 heaLos(
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

  Modelica.Blocks.Sources.RealExpression Qdir(y=meaDat.y[2] - meaDat.y[3])
    "[W/m2]"                                                                        annotation (Placement(transformation(extent={{-49.5,
            82},{-30.5,98}})));
  Modelica.Blocks.Math.Gain degToRad(k=Modelica.Constants.pi/180) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-40,60})));
  Modelica.Blocks.Sources.RealExpression winSpe(y=(meaDat.y[10])) "[W/m2]"
    annotation (Placement(transformation(extent={{-55.5,12},{-36.5,28}})));
  Modelica.Blocks.Sources.RealExpression I_tot(y=(meaDat.y[2])) "[W/m2]"
    annotation (Placement(transformation(extent={{-55.5,2},{-36.5,18}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin TAmbKel annotation (Placement(transformation(extent={{-45,23},
            {-35,33}})));
  Modelica.Blocks.Sources.RealExpression rH(y=(meaDat.y[8]))
    "Relative humidity [%]"
    annotation (Placement(transformation(extent={{-93.5,-82},{-74.5,-66}})));
  PvtMod.Components.Stc.Verification.BaseClasses.LongWaveRadiationISO
                                                    longWaveRadiationModel
    annotation (Placement(transformation(extent={{-58,-66},{-38,-46}})));
  Modelica.Blocks.Sources.RealExpression Tamb(y=(meaDat.y[12] + 273.15)) "[K]"
    annotation (Placement(transformation(extent={{-93.5,-94},{-74.5,-78}})));
  Modelica.Blocks.Sources.RealExpression Patm(y=(meaDat.y[9])) "[bar]"
    annotation (Placement(transformation(extent={{-93.5,-70},{-74.5,-54}})));
  Modelica.Blocks.Sources.RealExpression Ediff(y=(meaDat.y[3])) "[W/m2]"
    annotation (Placement(transformation(extent={{-93.5,-58},{-74.5,-42}})));
  Modelica.Blocks.Sources.RealExpression Eglob(y=(meaDat.y[2])) "[W/m2]"
    annotation (Placement(transformation(extent={{-93.5,-46},{-74.5,-30}})));
equation
   // Compute plane wind speed (using inherited azi/til and connected weaBus):
  windSpeTil = winSpe.y;

  // Make sure the model is only used with the EN ratings data, and hence c1 > 0
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));
  connect(shaCoe_internal, solGai.shaCoe_in);

  connect(shaCoe_in, solGai.shaCoe_in) annotation (Line(
      points={{-120,40},{-40,40},{-40,45},{-22,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLos.TFlu, temSen.T) annotation (Line(
      points={{-22,14},{-30,14},{-30,-20},{-11,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLos.QLos_flow, QLos.Q_flow) annotation (Line(
      points={{1,20},{26,20},{26,20},{50,20}},
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
  connect(solGai.HDirTil, Qdir.y) annotation (Line(points={{-22,52},{-26,52},{
          -26,90},{-29.55,90}}, color={0,0,127}));
  connect(solGai.incAng, degToRad.y)
    annotation (Line(points={{-22,48},{-40,48},{-40,54.5}}, color={0,0,127}));
  connect(heaLos.TEnv, TAmbKel.Kelvin)
    annotation (Line(points={{-22,26},{-22,28},{-34.5,28}}, color={0,0,127}));
  connect(winSpe.y, heaLos.u) annotation (Line(points={{-35.55,20},{-36,22.1},{
          -22.1,22.1}}, color={0,0,127}));
  connect(longWaveRadiationModel.rH,rH. y) annotation (Line(points={{-60,-60.4},
          {-70,-60.4},{-70,-74},{-73.55,-74}},                     color={0,0,127}));
  connect(Tamb.y,longWaveRadiationModel. Tamb) annotation (Line(points={{-73.55,
          -86},{-68,-86},{-68,-64.8},{-60,-64.8}}, color={0,0,127}));
  connect(Patm.y,longWaveRadiationModel. patm) annotation (Line(points={{-73.55,
          -62},{-72,-62},{-72,-56},{-60,-56}},                     color={0,0,127}));
  connect(Ediff.y,longWaveRadiationModel.Edif_h)  annotation (Line(points={{-73.55,
          -50},{-73.55,-51.6},{-60,-51.6}},
                                         color={0,0,127}));
  connect(Eglob.y,longWaveRadiationModel.Eglobh_h)  annotation (Line(points={{-73.55,
          -38},{-68,-38},{-68,-47.2},{-60,-47.2}}, color={0,0,127}));
  connect(heaLos.G, I_tot.y) annotation (Line(points={{-21.9,17.9},{-32,17.9},{
          -32,10},{-35.55,10}}, color={0,0,127}));
  connect(heaLos.E_L, longWaveRadiationModel.lonRad) annotation (Line(points={{
          -22.1,10.1},{-26,10.1},{-26,-55.9},{-36.3,-55.9}}, color={0,0,127}));
  connect(meaDat.y[5], degToRad.u)
    annotation (Line(points={{5,78},{-40,78},{-40,66}}, color={0,0,127}));
  connect(TAmbKel.Celsius, meaDat.y[12]) annotation (Line(points={{-46,28},{-68,
          28},{-68,78},{5,78}}, color={0,0,127}));
  connect(solGai.HSkyDifTil, meaDat.y[3]) annotation (Line(points={{-22,58},{-24,
          58},{-24,78},{5,78}}, color={0,0,127}));
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
end QDPvtCollectorValidationPVT1;

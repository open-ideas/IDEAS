within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI;
model PVTQuasiDynamicCollectorValidation
  "Validation model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
      redeclare IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic per,
    break weaBus,
    break HDifTilIso,
    break HDirTil);

      // ===== Parameters =====
  parameter Modelica.Units.SI.Efficiency   eleLosFac(min=0, max=1) = 0.09
    "Loss factor of the PV panel(s)" annotation(Dialog(group="Electrical parameters"));
  parameter IDEAS.Fluid.PVTCollectors.Types.CollectorType collectorType=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered
    "Type of collector used to select a proper default value for the effective transmittance-absorptance product (tauAlpEff)";

  parameter Real tauAlpEff(min=0, max=1) =
    if collectorType ==IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered  then 0.901 else 0.84
    "Effective transmittance–absorptance product";

protected
  Real winSpeTil "Effective wind speed normal to collector plane";
  Real qThSeg[nSeg] "Thermal power per segment";

  // Ouput connectors
  // ===== Real Output Connectors =====
  outer Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://PvtMod/Resources/Validation/MeasurementData/Typ1_modelica.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{26,68},
            {6,88}})));
  Modelica.Blocks.Interfaces.RealOutput pEl
    "Total electrical power output per unit area[W/m2]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput qTh "Total thermal power output per unit area[W/m2]"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain solGaiStc(
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
  IDEAS.Fluid.PVTCollectors.Validation.BaseClasses.ISO9806QuasiDynamicHeatLossValidation
    heaLosStc(
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
  IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT eleGen(
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
  IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.BaseClasses.LongWaveRadiation longWaveRad
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
  winSpeTil = winSpe.y;

  // Assign electrical and thermal outputs
  pEl = eleGen.pEl;
  qTh = sum(QGai.Q_flow + QLos.Q_flow);

  // Compute per-segment thermal power
  for i in 1:nSeg loop
    qThSeg[i] = (QGai[i].Q_flow + QLos[i].Q_flow) / (ATot_internal / nSeg);
  end for;

  heaLosStc.winSpePla = winSpeTil;
  eleGen.qth = qThSeg;


  // Make sure the model is only used with the EN ratings data, and hence c1 > 0
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));
  connect(shaCoe_internal, solGaiStc.shaCoe_in);

  connect(shaCoe_in, solGaiStc.shaCoe_in) annotation (Line(
      points={{-120,40},{-40,40},{-40,45},{-22,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLosStc.TFlu, temSen.T) annotation (Line(
      points={{-22,14},{-30,14},{-30,-20},{-11,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLosStc.QLos_flow, QLos.Q_flow) annotation (Line(
      points={{1,20},{26,20},{26,20},{50,20}},
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
  connect(solGaiStc.HDirTil, Qdir.y) annotation (Line(points={{-22,52},{-26,52},
          {-26,90},{-29.55,90}}, color={0,0,127}));
  connect(solGaiStc.incAng, degToRad.y)
    annotation (Line(points={{-22,48},{-40,48},{-40,54.5}}, color={0,0,127}));
  connect(heaLosStc.TEnv, TAmbKel.Kelvin)
    annotation (Line(points={{-22,26},{-34,26},{-34,28},{-34.5,28}},
                                                            color={0,0,127}));
  connect(longWaveRad.rH, rH.y) annotation (Line(points={{-60,-60.4},{-70,-60.4},
          {-70,-74},{-73.55,-74}}, color={0,0,127}));
  connect(Tamb.y, longWaveRad.Tamb) annotation (Line(points={{-73.55,-86},{-68,
          -86},{-68,-64.8},{-60,-64.8}}, color={0,0,127}));
  connect(Patm.y, longWaveRad.patm) annotation (Line(points={{-73.55,-62},{-72,
          -62},{-72,-56},{-60,-56}}, color={0,0,127}));
  connect(Ediff.y, longWaveRad.Edif_h) annotation (Line(points={{-73.55,-50},{
          -73.55,-51.6},{-60,-51.6}}, color={0,0,127}));
  connect(Eglob.y, longWaveRad.Eglobh_h) annotation (Line(points={{-73.55,-38},
          {-68,-38},{-68,-47.2},{-60,-47.2}}, color={0,0,127}));
  connect(heaLosStc.HGloTil, I_tot.y) annotation (Line(points={{-22,18},{-32,18},
          {-32,10},{-35.55,10}}, color={0,0,127}));
  connect(heaLosStc.HHorIR, longWaveRad.lonRad) annotation (Line(points={{-22,
          20},{-26,20},{-26,-55.9},{-36.3,-55.9}}, color={0,0,127}));
  connect(meaDat.y[5], degToRad.u)
    annotation (Line(points={{5,78},{-40,78},{-40,66}}, color={0,0,127}));
  connect(TAmbKel.Celsius, meaDat.y[12]) annotation (Line(points={{-46,28},{-68,
          28},{-68,78},{5,78}}, color={0,0,127}));
  connect(solGaiStc.HSkyDifTil, meaDat.y[3]) annotation (Line(points={{-22,58},{
          -24,58},{-24,78},{5,78}}, color={0,0,127}));
  connect(temSen.T, eleGen.Tm) annotation (Line(points={{-11,-20},{-30,-20},{-30,
          -64},{-22,-64}}, color={0,0,127}));
  connect(Eglob.y, eleGen.HGloTil) annotation (Line(points={{-73.55,-38},{-32,-38},
          {-32,-76},{-22,-76}}, color={0,0,127}));

  annotation (
  defaultComponentName="PvtCol",
  Documentation(info="<html>
  <p>
    Validation model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling.  
    Discretizes the collector into segments, computes heat loss and gain per ISO 9806, and calculates electrical output via the PVWatts-based submodel, relying solely on datasheet parameters.
  </p>

  <h4>Extends</h4>
  <ul>
    <li>
      <a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector\">
        IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector
      </a>
    </li>
  </ul>

  <h4>Submodel References</h4>
  <ul>
    <li>
      Electrical generation: 
      <a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT\">
        IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT
      </a>
    </li>
    <li>
      Quasi-dynamic thermal losses: 
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
    <li>
      Long-wave radiation (derived due to faulty measurements): 
      <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.BaseClasses.LongWaveRadiation\">
        IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.BaseClasses.LongWaveRadiation
      </a>
    </li>
  </ul>

  <h4>Implementation Notes</h4>
  <p>
  This model is designed for (unglazed) PVT collectors and discretizes the flow path into <code>nSeg</code> segments to capture temperature gradients. 
  It is compatible with dynamic simulations in which irradiance, ambient and fluid temperatures, and wind speed vary over time. 
  Because direct measurements of long-wave sky irradiance were found to be faulty, the model instead computes long-wave radiation using the dedicated <code>LongWaveRadiation</code> component.
  </p>


  <h4>References</h4>
  <ul>
    <li>
      Dobos, A.P., <i>PVWatts Version 5 Manual</i>, NREL, 2014
    </li>
    <li>
      Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
    </li>
    <li>
      ISO 9806:2013, Solar energy — Solar thermal collectors — Test methods
    </li>
  </ul>
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
end PVTQuasiDynamicCollectorValidation;

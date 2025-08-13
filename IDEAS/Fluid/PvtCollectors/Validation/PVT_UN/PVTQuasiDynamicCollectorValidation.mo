within IDEAS.Fluid.PVTCollectors.Validation.PVT_UN;
model PVTQuasiDynamicCollectorValidation
  "Validation model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi-dynamic thermal method with integrated electrical coupling"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
      redeclare IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic per);

  // =====  Parameters =====
  parameter Modelica.Units.SI.Efficiency   eleLosFac = 0.07
    "Loss factor of the PV panel(s)" annotation(Dialog(group="Electrical parameters"));
  parameter IDEAS.Fluid.PVTCollectors.Types.CollectorType collectorType=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered
    "Type of collector (used to select (tau*alpha)_eff)";
  parameter Real tauAlpEff =
    if collectorType ==IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered  then 0.901 else 0.84
    "Effective transmittance–absorptance product";

  // Ouput connectors
  // ===== Real Output Connectors =====
  outer Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT_UN/PVT_UN_measurements.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{78,70},
            {58,90}})));
  Modelica.Blocks.Interfaces.RealOutput pEl
    "Total electrical power output [W/m2]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput qTh "Total thermal power output [W/m2]"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  // Input connectors
   Modelica.Blocks.Interfaces.RealInput qThSeg[nSeg] "Thermal power per segment";

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

  IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.BaseClasses.ISO9806SolarGainHGloTil
    solGaiStc(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final eta0=per.eta0,
    final use_shaCoe_in=use_shaCoe_in,
    final shaCoe=shaCoe,
    final A_c=ATot_internal)
    "Identifies heat gained from the sun using the ISO 9806:2013 quasi-dynamic standard calculations"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
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

  Modelica.Blocks.Sources.RealExpression Gglob(y=meaDat.y[4]) "[W/m2]"
    annotation (Placement(transformation(extent={{-51.5,66},{-32.5,82}})));
  Modelica.Blocks.Sources.RealExpression globIrrTil(y=(meaDat.y[4])) "[W/m2]"
    annotation (Placement(transformation(extent={{-67.5,6},{-48.5,22}})));
  Modelica.Blocks.Sources.RealExpression winSpe(y=(meaDat.y[10])) "[W/m2]"
    annotation (Placement(transformation(extent={{-67.5,16},{-48.5,32}})));
equation
   // Assign electrical and thermal outputs
  pEl = eleGen.pEl;
  qTh = sum(QGai.Q_flow + QLos.Q_flow);

  // Compute per-segment thermal power
  for i in 1:nSeg loop
    qThSeg[i] = (QGai[i].Q_flow + QLos[i].Q_flow) / (ATot_internal / nSeg);
  end for;

  // Make sure the model is only used with the EN ratings data, and hence c1 > 0
  assert(per.c1 > 0,
    "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained c1 = " + String(per.c1));

  connect(heaLosStc.TFlu, temSen.T) annotation (Line(
      points={{-22,14},{-30,14},{-30,-20},{-11,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLosStc.QLos_flow, QLos.Q_flow) annotation (Line(
      points={{1,20},{26,20},{26,20},{50,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, heaLosStc.TEnv) annotation (Line(
      points={{-99.95,80.05},{-100,80.05},{-100,80},{-90,80},{-90,26},{-22,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HHorIR, heaLosStc.HHorIR) annotation (Line(
      points={{-99.95,80.05},{-94,80.05},{-94,80},{-90,80},{-90,10},{-32,10},{-32,
          20},{-22,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(globIrrTil.y, heaLosStc.HGloTil) annotation (Line(points={{-47.55,14},
          {-32,14},{-32,18},{-22,18}}, color={0,0,127}));
  connect(winSpe.y, heaLosStc.winSpePla) annotation (Line(points={{-47.55,24},{-32,
          24},{-32,22},{-22,22}}, color={0,0,127}));
  connect(solGaiStc.QSol_flow, QGai.Q_flow)
    annotation (Line(points={{1,50},{50,50}}, color={0,0,127}));
  connect(temSen.T, solGaiStc.TFlu) annotation (Line(points={{-11,-20},{-30,-20},
          {-30,42},{-22,42}}, color={0,0,127}));
  connect(Gglob.y, solGaiStc.HGlob) annotation (Line(points={{-31.55,74},{-30,74},
          {-30,58},{-22,58}}, color={0,0,127}));
  connect(eleGen.HGloTil, Gglob.y) annotation (Line(points={{-22,-76},{-30,-76},
          {-30,74},{-31.55,74}}, color={0,0,127}));
  connect(eleGen.Tm, temSen.T) annotation (Line(points={{-22,-64},{-26,-64},{
          -26,-20},{-11,-20}}, color={0,0,127}));
  connect(qThSeg, eleGen.qth);
  annotation (
  defaultComponentName="PvtCol",
  Documentation(info="<html>
  <p>
    Validation model of a photovoltaic–thermal (PVT) collector using the ISO 9806:2013 quasi‑dynamic thermal method with integrated electrical coupling.  
    Discretizes the collector into segments, computes heat loss and gain per ISO 9806, and calculates electrical output via the PVWatts‑based submodel, relying solely on datasheet parameters.
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
      Quasi‑dynamic thermal losses: 
      <a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss\">
        IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss
      </a>
      </li>
    <li>
      Solar (thermal) heat gain: see 
      <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.BaseClasses.ISO9806SolarGainHGloTil\">
        IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.BaseClasses.ISO9806SolarGainHGloTil
      </a>
    </li>
  </ul>

  <h4>Implementation Notes</h4>
  <p>
  This model is designed for (unglazed) PVT collectors and discretizes the flow path into <code>nSeg</code> segments to capture temperature gradients. 
  It is compatible with dynamic simulations in which irradiance, ambient and fluid temperatures, and wind speed vary over time. 
  </p>


  <h4>References</h4>
  <ul>
    <li>
      Dobos, A.P., <i>PVWatts Version 5 Manual</i>, NREL, 2014
    </li>
    <li>
      Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic‑Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
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

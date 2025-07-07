within IDEAS.Fluid.PVTCollectors.Validation.PVT1.BaseClasses;
model PartialPVTCollectorValidation
  "Adapted partial solar (thermal) collector"
  extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
      redeclare IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic per,
    break weaBus,
    break HDifTilIso,
    break HDirTil);

  // ===== Photovoltaic Parameters =====
  parameter Modelica.Units.SI.Efficiency   pLossFactor = 0.10
    "Loss factor of the PV panel(s)" annotation(Dialog(group="Electrical parameters"));
  parameter IDEAS.Fluid.PVTCollectors.Types.CollectorType collectorType=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered
    "Type of collector (used to select (tau*alpha)_eff)";

  parameter Real tauAlphaEff =
    if collectorType ==IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered  then 0.901 else 0.84
    "Effective transmittance–absorptance product";
  output Modelica.Units.SI.CoefficientOfHeatTransfer UAbsFluid =
  ((tauAlphaEff - per.etaEl) * (per.c1 + abs(per.gamma)*HGloHorNom))
  / ((tauAlphaEff - per.etaEl) - per.eta0)
  "Heat transfer coefficient calculated from EN12975 parameters";

  // ===== Measurement Data =====
  // (Assumes that an outer measurement is available providing measurement data)

  // ===== Internal Variables =====
  Real HGloHorNom;

  // ===== Real Output Connectors =====
  outer Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource("modelica://PvtMod/Resources/Validation/MeasurementData/Typ1_modelica.txt"),
    columns=1:25) annotation (Placement(transformation(extent={{26,68},
            {6,88}})));
  Modelica.Blocks.Interfaces.RealInput qThSeg[nSeg] "Thermal power per segment";

  IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT eleGen(
    final nSeg = nSeg,
    final A_c = ATot_internal,
    final pLossFactor = pLossFactor,
    final gamma = per.gamma,
    final P_nominal = per.P_nominal,
    final A = per.A,
    final eta0 = per.eta0,
    final tauAlphaEff = tauAlphaEff,
    final c1 = per.c1,
    final etaEl = per.etaEl)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  // Compute per-segment thermal power
  for i in 1:nSeg loop
    qThSeg[i] = (QGai[i].Q_flow + QLos[i].Q_flow) / (ATot_internal / nSeg);
  end for;

  eleGen.HGloHorNom = HGloHorNom;

  // inputs to submodels
  connect(qThSeg, eleGen.qth);


end PartialPVTCollectorValidation;

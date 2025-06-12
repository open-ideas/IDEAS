within IDEAS.Fluid.PvtCollectors.Validation;
model Collector
  extends IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector(
  redeclare final package Medium = IDEAS.Media.Water,
  final show_T = true,
  final per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel(),
  final shaCoe=0,
  final azi=0,
  final uPvt  = 32.76,
  final CTot = per.C,
  final totalArea = 1.66,
  final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
  final rho=0.2,
  final nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
  nPanels=1,
  final til=0.78539816339745,
  final use_shaCoe_in=false,
  final gamma = -0.0041,
  final P_STC = 280,
  final G_STC = 1000,
  final module_efficiency = 0.1687,
  final pLossFactor = 0.07,
  sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series);

end Collector;

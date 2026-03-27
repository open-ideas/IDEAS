within IDEAS.Fluid.PVTCollectors.Validation.BaseClasses;
partial model PartialPVTCollectorValidation
  "Common base for UI and UN PVT collector validation models"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
    redeclare IDEAS.Fluid.PVTCollectors.Data.Generic per);

  parameter Modelica.Units.SI.Efficiency eleLosFac(min=0, max=1) = 0.07
    "Loss factor of the PV panel(s)"
    annotation(Dialog(group="Electrical parameters"));

  parameter IDEAS.Fluid.PVTCollectors.Types.CollectorType collectorType = per.colTyp
    "Collector type used to select a default tauAlpEff";

  parameter Real tauAlpEff(min=0, max=1) =
    if collectorType == IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered then 0.901 else 0.84
    "Effective transmittance-absorptance product";

  Modelica.Units.SI.HeatFlux qThSeg[nSeg]
    "Thermal power per segment";

  Modelica.Blocks.Interfaces.RealOutput Pel
    "Total electrical power output [W]";

  Modelica.Blocks.Interfaces.RealOutput Qth
    "Total thermal power output [W]";

end PartialPVTCollectorValidation;

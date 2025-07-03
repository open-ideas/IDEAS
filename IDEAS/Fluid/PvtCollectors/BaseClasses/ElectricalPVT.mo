within IDEAS.Fluid.PVTCollectors.BaseClasses;
model ElectricalPVT "Visible block to compute electrical power output using PVWatts v5 approach"
  extends Modelica.Blocks.Icons.Block;
  // Parameters
  parameter Integer nSeg = 1 "Number of segments";
  parameter Modelica.Units.SI.Area ATot_internal "Total collector area";
  parameter Modelica.Units.SI.Irradiance HGloHorNom = 1000 "Nominal global irradiance";
  parameter Modelica.Units.SI.Efficiency pLossFactor = 0.10 "PV loss factor";
  parameter Modelica.Units.SI.Temperature TpvtRef = 298.15 "Reference cell temperature [K]";
  parameter Real gamma "Temperature coefficient [1/K]";
  parameter Real P_nominal "Nominal PV power [W]";
  parameter Real A "PV area [m2]";
  parameter Real eta0 "Zero-loss efficiency";
  parameter Real tauAlphaEff "Effective transmittance–absorptance product";
  parameter Real c1 "First-order heat loss coefficient";

  // Inputs
  Modelica.Blocks.Interfaces.RealInput Tm[nSeg]
    "Fluid temperatures per segment [K]"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput qth[nSeg]
    "Thermal power density per segment [W/m2]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput HGloTil
    "Global tilted irradiance [W/m2]"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput pEl
    "Total electrical power output [W/m2]"
    annotation (Placement(transformation(extent={{100,40},{140,80}}),
        iconTransformation(extent={{100,40},{140,80}})));
  Modelica.Blocks.Interfaces.RealOutput temMod
    "Average cell temperature [K]"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput temMea
    "Average fluid temperature [K]"
    annotation (Placement(transformation(extent={{100,-80},{140,-40}}),
        iconTransformation(extent={{100,-80},{140,-40}})));

protected
  Real temCell[nSeg];
  Real temDiff[nSeg];
  Real solarPowerInternal[nSeg];

  final parameter Real UAbsFluidCalc = ((tauAlphaEff - (P_nominal/A)) * (c1 + abs(gamma)*HGloHorNom)) /
                                       ((tauAlphaEff - (P_nominal/A)) - eta0);

equation
  for i in 1:nSeg loop
    temCell[i] = Tm[i] + qth[i] / UAbsFluidCalc;
    temDiff[i] = temCell[i] - TpvtRef;
    solarPowerInternal[i] = (ATot_internal/nSeg) * (P_nominal/A) * (HGloTil/HGloHorNom) *
                            (1 + gamma * temDiff[i]) * (1 - pLossFactor);
  end for;

  pEl = sum(solarPowerInternal);
  temMod = sum(temCell)/nSeg;
  temMea = sum(Tm)/nSeg;

end ElectricalPVT;

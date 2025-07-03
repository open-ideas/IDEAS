within IDEAS.Fluid.PVTCollectors.BaseClasses;
model ElectricalPVT
  "Visible block to compute electrical power output using PVWatts v5 approach"

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
  input Real Tm[nSeg] "Fluid temperatures per segment [K]";
  input Real qth[nSeg] "Thermal power density per segment [W/m2]";
  input Real HGloTil "Global tilted irradiance [W/m2]";

  // Outputs
  output Real pEl "Total electrical power output [W/m2]";
  output Real temMod "Average cell temperature [K]";
  output Real temMea "Average fluid temperature [K]";

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

annotation (
  Diagram(graphics={
    Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
    Text(extent={{-90,60},{90,-60}}, textString="Electrical PVT Block", fontSize=12)}), Icon(
        graphics={              Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end ElectricalPVT;

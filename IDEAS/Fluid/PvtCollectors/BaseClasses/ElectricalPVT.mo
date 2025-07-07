within IDEAS.Fluid.PVTCollectors.BaseClasses;
model ElectricalPVT "Visible block to compute electrical power output using PVWatts v5 approach"
  extends Modelica.Blocks.Icons.Block;
  extends SolarCollectors.BaseClasses.PartialParameters;
  // Parameters
  parameter Integer nSeg = 1 "Number of segments";
  parameter Modelica.Units.SI.Irradiance HGloHorNom = 1000 "Nominal global irradiance";
  parameter Modelica.Units.SI.Efficiency pLossFactor = 0.10 "PV loss factor";
  parameter Modelica.Units.SI.Temperature TpvtRef = 298.15 "Reference cell temperature [K]";
  parameter Real gamma "Temperature coefficient [1/K]";
  parameter Real P_nominal "Nominal PV power [W]";
  parameter Real A "PV area [m2]";
  parameter Real eta0 "Zero-loss efficiency";
  parameter Real tauAlphaEff "Effective transmittance–absorptance product";
  parameter Real c1 "First-order heat loss coefficient";
  parameter Real etaEl "Electrical efficiency";

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

 final parameter Modelica.Units.SI.CoefficientOfHeatTransfer UAbsFluidCalc =
  ((tauAlphaEff - etaEl) * (c1 + abs(gamma)*HGloHorNom))
  / ((tauAlphaEff - etaEl) - eta0)
  "Heat transfer coefficient between the fluid and the PV cells, calculated from datasheet parameters";

equation
  for i in 1:nSeg loop
    temCell[i] = Tm[i] + qth[i] / UAbsFluidCalc;
    temDiff[i] = temCell[i] - TpvtRef;
    solarPowerInternal[i] = (A_c/nSeg) * (P_nominal/A) * (HGloTil/HGloHorNom) *
                            (1 + gamma * temDiff[i]) * (1 - pLossFactor);
  end for;

  pEl = sum(solarPowerInternal);
  temMod = sum(temCell)/nSeg;
  temMea = sum(Tm)/nSeg;

annotation (
  defaultComponentName="eleGen",
  Documentation(info="<html>
<p>
This component computes the electrical power output of a photovoltaic-thermal (PVT) collector using the <b>PVWatts v5</b> methodology (Dobos, 2014), adapted for PVT systems. It is part of a validated, open-source Modelica implementation that relies solely on manufacturer datasheet parameters, as described in Meertens et al. (2025).
</p>

<p>
The model calculates the electrical output for each segment <i>i ∈ {1, ..., n<sub>seg</sub>}</i> as:
</p>

<p align=\"center\" style=\"font-style:italic;\">
P<sub>el,i</sub> = (A<sub>c</sub> / n<sub>seg</sub>) · (P<sub>nom</sub> / A) · (G<sub>tilt</sub> / G<sub>nom</sub>) · (1 + γ · ΔT<sub>i</sub>) · (1 - p<sub>loss</sub>)
</p>

<p>
where:
<ul>
  <li><i>ΔT<sub>i</sub></i> = T<sub>cell,i</sub> - T<sub>ref</sub>: temperature difference between PV cell and reference temperature</li>
  <li><i>P<sub>nom</sub></i>: nominal PV power under STC [W]</li>
  <li><i>A</i>: gross collector area [m²]</li>
  <li><i>A<sub>c</sub></i>: effective collector area (equal to A if not otherwise specified)</li>
  <li><i>G<sub>tilt</sub></i>: global irradiance on the tilted collector plane [W/m²]</li>
  <li><i>G<sub>nom</sub></i>: nominal irradiance (typically 1000 W/m²)</li>
  <li><i>γ</i>: temperature coefficient of power [%/K]</li>
  <li><i>p<sub>loss</sub></i>: lumped system loss factor</li>
</ul>
</p>

<p>
The PV cell temperature is estimated from the fluid temperature and thermal power density using:
</p>

<p align=\"center\" style=\"font-style:italic;\">
T<sub>cell,i</sub> = T<sub>m,i</sub> + q<sub>th,i</sub> / U<sub>AbsFluid</sub>
</p>

<p>
  The internal heat transfer coefficient <i>UAbsFluid</i> is approximately calculated from datasheet parameters:
</p>

<div style=\"display:flex; align-items:center; justify-content:center;\">
  <div style=\"padding-right:8px;\"><i>UAbsFluid</i></div>
  <table style=\"border-collapse:collapse; text-align:center;\">
    <tr>
      <td style=\"padding:4px;\">
        <em>(τ·α)<sub>eff</sub> – η<sub>0,el</sub></em> · (c<sub>1</sub> + c<sub>3</sub>·u + b<sub>1,el</sub>)
      </td>
    </tr>
    <tr>
      <td style=\"border-top:1px solid black; padding:4px;\">
        <em>(τ·α)<sub>eff</sub> – η<sub>0,el</sub></em>
        – (1 – <em>c<sub>6</sub>/η<sub>0,th</sub></em>·u) · η<sub>0,th</sub>
      </td>
    </tr>
  </table>
</div>

<ul>
  <li>
    τ·α<sub>eff</sub> = 0.901 for uncovered PVT; 0.84 for covered PVT.
  </li>
  <li>
    b<sub>1,el</sub> = |γ|·G<sub>STC</sub> (electrical datasheet parameters).
  </li>
  <li>
    u = in‑plane wind speed. <i>UAbsFluid</i> is only weakly dependent on external wind speed
    when the thermal datasheet parameters are accurate (Stegmann 2011). Therefore, for simplicity, <code>u = 0</code> is used to derive <i>UAbsFluid</i>.
  </li>
</ul>

<h5>Electrical performance and losses</h5>
<p>
The electrical submodel includes an overall system loss factor <code>pLossFactor</code>. NREL’s PVWatts reports a total electrical power loss of 14%, resulting from the following mechanisms:
</p>

<table border=\"1\" cellpadding=\"4\">
  <tr>
    <th style=\"text-align:left;\">Electrical power loss mechanism</th>
    <th style=\"text-align:center;\">Default value</th>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Soiling</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Shading</td>
    <td style=\"text-align:center;\">3 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Mismatch</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Wiring</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Connections</td>
    <td style=\"text-align:center;\">0.5 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Light‑induced degradation</td>
    <td style=\"text-align:center;\">1.5 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Nameplate rating</td>
    <td style=\"text-align:center;\">1 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Availability</td>
    <td style=\"text-align:center;\">3 %</td>
  </tr>
  <tr>
    <th style=\"text-align:left;\">Total</th>
    <th style=\"text-align:center;\">14 %</th>
  </tr>
</table>


<p>
  For the validation cases presented in Meertens et al. (2025), where the PVT modules were unshaded and well‑maintained, values of 
  <code>pLossFactor = 10%</code> and <code>pLossFactor = 7%</code> were used for 
  <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT1\">IDEAS.Fluid.PVTCollectors.Validation.PVT1</a> and 
  <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT2\">IDEAS.Fluid.PVTCollectors.Validation.PVT2</a>, respectively, and yielded good agreement with measured electrical output. 
  Users are encouraged to adjust this value based on site‑specific conditions such as soiling, shading, mismatch, and inverter efficiency.
</p>


<h4>Implementation Notes</h4>
<p>
This model is designed for (unglazed) PVT collectors and supports discretization into multiple segments to capture temperature gradients along the flow path. It is compatible with the thermal 
model based on ISO 9806:2013 and is suitable for dynamic simulations where irradiance and fluid temperatures vary over time.
</p>

<h4>References</h4>
<p>
Dobos, A.P., <i>PVWatts Version 5 Manual</i>, NREL, 2014<br/>
Meertens, L. et al., <i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, IMOC 2025<br/>
ISO 9806:2013, Solar energy — Solar thermal collectors — Test methods
</p>
</html>"));




end ElectricalPVT;

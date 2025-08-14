within IDEAS.Fluid.PVTCollectors.BaseClasses;
model ISO9806QuasiDynamicHeatLoss
  "Calculate the heat loss of a PVT/solar collector using ISO9806:2013"

  extends IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss(
    // Override the internal heat-loss expression to include c3, c4 and c6 terms
    final QLos_internal=A_c/nSeg*{dT[i]*(c1 - c2*dT[i] + c3*winSpePla) + c4*(HHorIR
         - Modelica.Constants.sigma*TEnv^4) - c6*winSpePla*HGloTil for i in 1:nSeg},
        a1=c1,
        a2=c2);


  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0)
    "Linear heat loss coefficient (a1)";
  parameter Real c2(final unit="W/(m2.K2)", final min=0)
    "Quadratic heat loss coefficient (a2)";

  // —— Additional quasi-dynamic coefficients ——
  parameter Modelica.Units.SI.SpecificHeatCapacity c3(final min=0)
    "Wind speed dependence of heat loss";
  parameter Modelica.Units.SI.DimensionlessRatio c4(final min=0)
    "Sky long-wave irradiance dependence";
  parameter Real c6(final unit="s/m", final min=0)
    "Wind speed dependence of thermal zero-loss efficiency";

  // Quasi-dynamic inputs
  Modelica.Blocks.Interfaces.RealInput winSpePla(
    quantity="Windspeed",
    unit="m/s",
    displayUnit="m/s")
    "Wind speed normal to collector plane";
  Modelica.Blocks.Interfaces.RealInput HGloTil(
    quantity="Global solar irradiance",
    unit="W/m2")
    "Global irradiance on the tilted plane";
  Modelica.Blocks.Interfaces.RealInput HHorIR(
    quantity="Long-wave solar irradiance",
    unit="W/m2")
    "Long-wave (sky) irradiance [W/m2]" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}),   iconTransformation(extent={{-140,-20},{-100,20}})));

annotation (
defaultComponentName="heaLosStc",
Documentation(info="<html>
<p>
This component computes the quasi-dynamic heat loss from a solar thermal or PVT collector
to the environment, following the methodology described in the international standard
<b>ISO 9806:2013</b>. It extends the original <code>EN12975HeatLoss</code> model for code reuse,
but implements the more comprehensive quasi-dynamic formulation.
</p>

<p>
The heat loss is calculated for each segment <i>i ∈ {1, ..., n<sub>seg</sub>}</i> as:
</p>

<p align=\"center\" style=\"font-style:italic;\">
Q<sub>los,i</sub> = A<sub>c</sub> / n<sub>seg</sub> &#183; [&Delta;T<sub>i</sub> &#183; (c<sub>1</sub> - c<sub>2</sub> &#183; &Delta;T<sub>i</sub> + c<sub>3</sub> &#183; u) + c<sub>4</sub> &#183; (E<sub>L</sub> - &sigma; &#183; T<sub>env</sub><sup>4</sup>) - c<sub>6</sub> &#183; u &#183; G]
</p>

<p>
where:
<ul>
<li>
<i>&Delta;T<sub>i</sub> = T<sub>env</sub> - T<sub>flu,i</sub></i>: temperature difference between environment and fluid in segment <i>i</i>
</li>
<li>
<i>c<sub>1</sub></i>: linear heat loss coefficient (alias for <code>a1</code>)
</li>
<li>
<i>c<sub>2</sub></i>: quadratic heat loss coefficient (alias for <code>a2</code>)
</li>
<li>
<i>c<sub>3</sub></i>: wind speed dependence of heat loss
</li>
<li>
<i>c<sub>4</sub></i>: sky long-wave irradiance dependence
</li>
<li>
<i>c<sub>6</sub></i>: wind speed dependence of thermal zero-loss efficiency
</li>
<li>
<i>u</i>: wind speed normal to the collector plane
</li>
<li>
<i>E<sub>L</sub></i>: long-wave irradiance from the sky
</li>
<li>
<i>G</i>: global solar irradiance on the tilted collector plane
</li>
<li>
<i>&sigma;</i>: Stefan–Boltzmann constant (<i>5.67×10⁻⁸</i> W/m²·K⁴)
</li>
</ul>
</p>

<p>
This model provides a more accurate representation of collector heat loss under dynamic environmental conditions,
as required by ISO 9806:2013. It is suitable for use in simulations where wind speed, sky radiation, and irradiance
vary over time.
</p>

<h4>Implementation Notes</h4>
<p>
The model inherits from <code>IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss</code> for structural consistency and reuse of base functionality,
but the naming and equations have been overwritten to reflect the ISO 9806 standard. Parameters <code>a1</code> and <code>a2</code>
are overwritten to <code>c1</code> and <code>c2</code> for clarity.
</p>

<h4>References</h4>
<p>
<li>
ISO 9806:2013, Solar energy — Solar thermal collectors — Test methods<br/>
</li>
</p>
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
</html>"));
end ISO9806QuasiDynamicHeatLoss;

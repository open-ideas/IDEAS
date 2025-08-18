within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI;
package Thermal "Thermal Behavior of Unglazed Rear-Insulated PVT Collector"

  annotation (preferredView="info", Documentation(info=
"<html>
<p>
This subpackage contains four validation models for the thermal performance of the PVT_UI collector, an uncovered PVT collector with rear insulation. The models correspond to the four ISO 9806:2013 day types:
</p>
<ul>
<li><b>Day Type 1:</b> Clear sky, low temperature difference (η₀ conditions)</li>
<li><b>Day Type 2:</b> Partly cloudy, low temperature difference</li>
<li><b>Day Type 3:</b> Clear sky, medium temperature difference</li>
<li><b>Day Type 4:</b> Clear sky, high temperature difference</li>
</ul>

<p>
Each model compares the simulated thermal output with measured data and provides a detailed breakdown of thermal losses using the quasi-dynamic ISO 9806 formulation. The following loss mechanisms are included:
</p>
<ul>
<li>Linear and quadratic heat loss (<code>c₁</code>, <code>c₂</code>)</li>
<li>Convective heat loss (wind-dependent, <code>c₃</code>, <code>c₆</code>)</li>
<li>Radiative heat loss (sky temperature dependent, <code>c₄</code>)</li>
<li>Thermal inertia effects (<code>c₅</code>)</li>
</ul>

<p>
The model is discretized into <code>nSeg</code> segments to capture temperature gradients along the flow path. All parameters are derived from manufacturer datasheets, without calibration.
</p>

<p>
Validation results show strong agreement for day types 1–3, with thermal energy deviations below 4.2 % and normalized MAE values ranging from 3.3 % to 20.0 %. For day type 4, 
larger deviations (∆E = 36.7 %) are observed due to high temperature differences and wind speeds, highlighting limitations in the datasheet-based coefficients under extreme conditions. As the absolute
thermal output is low in this case, model limitations have a stronger effect, leading to disproportionately large relative deviations (Meertens et al., 2025).
</p>
<h4>References</h4>
<ul>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic‑Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
</li>
<li>
ISO 9806:2013. <i><a href='https://www.iso.org/standard/59879.html'>Solar thermal collectors — Test methods</a></i>. ISO.
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
</html>"));
end Thermal;

within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI;
package Thermal "Thermal behavior of an unglazed rear‑insulated PVT collector"

  annotation (preferredView="info", Documentation(info=
"<html>
<p>
This subpackage contains four validation models for the thermal performance of the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">PVT_UI</a> collector, 
an uncovered PVT collector with rear insulation. The models correspond to the four ISO 9806:2017 day types:
</p>
<ul>
<li>
<b>Day Type 1:</b> Clear sky, low temperature difference (<i>&eta;<sub>0</sub></i> conditions)
</li>
<li>
<b>Day Type 2:</b> Partly cloudy, low temperature difference
</li>
<li>
<b>Day Type 3:</b> Clear sky, medium temperature difference
</li>
<li>
<b>Day Type 4:</b> Clear sky, high temperature difference
</li>
</ul>
<p>
Each model compares the simulated thermal output with measured data and provides 
a detailed breakdown of thermal losses using the quasi-dynamic ISO 9806 formulation. 
The following loss mechanisms are included:
</p>
<ul>
<li>
Linear and quadratic heat loss (<i>a<sub>1</sub></i>, <i>a<sub>2</sub></i>)
</li>
<li>
Wind‑dependent convective heat loss (<i>a<sub>3</sub></i>)
</li>
<li>
Sky‑temperature‑dependent radiative loss (<i>a<sub>4</sub></i>)
</li>
<li>
Effective thermal capacity (<i>a<sub>5</sub></i>)
</li>
<li>
Wind dependence of the zero‑loss efficiency (<i>a<sub>6</sub></i>)
</li>
<li>
Wind dependence of long‑wave radiative exchange (<i>a<sub>7</sub></i>)
</li>
<li>
Higher‑order temperature‑dependent radiation losses (<i>a<sub>8</sub></i>)
</li>
</ul>
<p>
The model is discretized into <code>nSeg</code> segments to capture temperature gradients along the flow path.
All parameters are derived from manufacturer datasheets, without calibration.
</p>
<p>
Validation results show strong agreement for day types 1–3, with thermal energy deviations below <i>4.2 %</i>
 and normalized MAE values ranging from <i>3.3 %</i> to <i>20.0 %</i>. 
For day type 4, larger deviations (<i>&Delta;E = 36.7 %</i>) are observed due to high temperature differences and wind speeds, 
highlighting limitations in the datasheet-based coefficients under extreme conditions. 
As the absolute thermal output is low in this case, model limitations have a stronger effect, 
leading to disproportionately large relative deviations (Meertens et al., 2026).
</p>
<h4>References</h4>
<ul>
<li>
Meertens, L.; Jansen, J.; Helsen, L. (2026).
<i>Development and Experimental Validation of an Open-Source 
Photovoltaic‑Thermal Collector Modelica Model that Only Needs
Datasheet Parameters</i>. Submitted to 
Mathematical and Computer Modelling of Dynamical Systems,
Special Issue on Modelica, FMI, and Open Standards.
</li>
<li>
ISO 9806:2017. <i><a href='https://www.iso.org/standard/67978.html'>Solar thermal collectors — Test methods</a></i>. ISO.
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
March 11, 2026, by Lone Meertens:<br/>
Updated thermal formulation from ISO 9806:2013 to ISO 9806:2017 and added
conversion support.This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1473\">#1473</a>.
</li>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model. 
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>"));
end Thermal;

within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI;
package Thermal "Thermal Behavior of Unglazed Rear-Insulated PVT Collector"

  annotation (preferredView="info", Documentation(info=
"<html>
<p>
This subpackage contains four validation models for the thermal performance of the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">PVT_UI</a> collector, 
an uncovered PVT collector with rear insulation. The models correspond to the four ISO 9806:2013 day types:
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
Linear and quadratic heat loss (c<sub>1</sub>, c<sub>2</sub>)
</li>
<li>
Convective heat loss (wind-dependent, c<sub>3</sub>, c<sub>6</sub>)
</li>
<li>
Radiative heat loss (sky temperature dependent, <code>c<sub>4</sub></code>)
</li>
<li>
Thermal inertia effects (<code>c<sub>5</sub></code>)
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
leading to disproportionately large relative deviations (Meertens et al., 2025).
</p>
<h4>References</h4>
<ul>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). 
<i>Development and Experimental Validation of an Unglazed Photovoltaic‑Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, 
submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
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
First implementation PVT model. 
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>"));
end Thermal;

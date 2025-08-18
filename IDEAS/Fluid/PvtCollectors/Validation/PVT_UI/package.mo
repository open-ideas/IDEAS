within IDEAS.Fluid.PVTCollectors.Validation;
package PVT_UI
  annotation (preferredView="info", Documentation(info=
"<html>
<p>
This package contains validation models for the <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">PVT_UI</a> collector 
(referred to as <code>PVT1</code> in Meertens et al., 2025), 
an <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Data.Uncovered.UI_Validation\">uncovered PVT collector with rear insulation</a>, 
based on experimental data from HTW Saar (Jonas et al., 2019).
</p>

<p>
The validation is structured according to the ISO 9806:2013 standard and includes four representative day types:
</p>
<ul>
<li><b>Day Type 1:</b> Clear sky, low temperature difference (η₀ conditions)</li>
<li><b>Day Type 2:</b> Partly cloudy, low temperature difference</li>
<li><b>Day Type 3:</b> Clear sky, medium temperature difference</li>
<li><b>Day Type 4:</b> Clear sky, high temperature difference</li>
</ul>

<p>
The package is divided into two main subpackages:
</p>

<h5>Subpackage: <code>Thermal</code></h5>
<p>
Contains four models corresponding to the four day types. Each model compares the simulated thermal output with measured data and provides a detailed breakdown of thermal losses, including:
</p>
<ul>
<li>Linear and quadratic heat loss (<i>c<sub>1</sub></i>, <i>c<sub>2</sub></i>)</li>
<li>Convective heat loss (wind-dependent, <i>c<sub>3</sub></i>, <i>c<sub>6</sub></i>)</li>
<li>Radiative heat loss (sky temperature dependent, <i>c<sub>4</sub></i>)</li>
<li>Thermal inertia effects (<i>c<sub>5</sub></i>)</li>
</ul>
<p>
The thermal model is based on the quasi-dynamic ISO 9806 formulation and uses only datasheet parameters. The model is discretized into <code>nSeg</code> segments to capture temperature gradients along the flow path.
</p>

<h5>Subpackage: <code>Electrical</code></h5>
<p>
Also includes four models for the same day types. These models validate the electrical output by comparing simulated and measured power, and compute the absorber-to-fluid heat transfer coefficient <i>U<sub>AbsFluid</sub></i> using a datasheet-based method (Meertens et al., 2025).
</p>
<p>
The electrical model uses the PVWatts V5 formulation and includes temperature-dependent efficiency losses. The PV cell temperature is derived from the thermal model using a two-node coupling heat transfer coefficient <i>U<sub>AbsFluid</sub></i>.
</p>

<h4>Model limitations</h4>
<p>
Overall, the PVT_UI validation demonstrates strong agreement between the model and measurements for both thermal and electrical outputs under a range of operating conditions. While electrical outputs are accurate and consistent across all day types, 
limitations in thermal output are observed under high wind speeds and rapid irradiance changes, primarily due to datasheet parameter constraints. This is particularly evident in Day Type 4, where a large temperature difference between the fluid and ambient air amplifies these limitations. 
The wind speed over the collector plane during most of the test periods is generated using an artificial blower, producing wind speeds around 3.5&nbsp;m/s. This lies near the upper boundary of the test range for the datasheet thermal parameters, potentially leading to additional discrepancies 
between the modeled and measured results.
</p>

<h4>References</h4>
<ul>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
</li>
<li>
Jonas, D., Theis, D., Frey, G. (2019). <i>Performance modeling of PVT collectors: Implementation, validation and parameter identification approach using TRNSYS</i>. Solar Energy 193, pp. 51–64.
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
end PVT_UI;

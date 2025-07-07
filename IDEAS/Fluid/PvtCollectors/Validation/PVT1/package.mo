within IDEAS.Fluid.PVTCollectors.Validation;
package PVT1
  annotation (preferredView="info", Documentation(info=
"<html>
  <p>
  This package contains validation models for the PVT1 collector (Meertens et al, 2025), an uncovered PVT collector with rear insulation, based on experimental data from HTW Saar (Jonas et al., 2019).
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

  <h4>Subpackage: <code>Thermal</code></h4>
  <p>
  Contains four models corresponding to the four day types. Each model compares the simulated thermal output with measured data and provides a detailed breakdown of thermal losses, including:
  </p>
  <ul>
  <li>Linear and quadratic heat losses (<code>c₁</code>, <code>c₂</code>)</li>
  <li>Convective heat losses (wind-dependent, <code>c₃</code>, <code>c₆</code>)</li>
    <li>Radiative heat losses (sky temperature dependent, <code>c₄</code>)</li>
    <li>Thermal inertia effects (<code>c₅</code>)</li>
  </ul>
  <p>
  The thermal model is based on the quasi-dynamic ISO 9806 formulation and uses only datasheet parameters. The model is discretized into <code>nSeg</code> segments to capture temperature gradients along the flow path.
  </p>

  <h4>Subpackage: <code>Electrical</code></h4>
  <p>
  Also includes four models for the same day types. These models validate the electrical output by comparing simulated and measured power, and compute the absorber-to-fluid heat transfer coefficient <code>U<sub>AbsFluid</sub></code> using a datasheet-based method (Meertens et al., 2025).
  </p>
  <p>
  The electrical model uses the PVWatts V5 formulation and includes temperature-dependent efficiency losses. The PV cell temperature is derived from the thermal model using a two-node coupling heat transfer coefficient <code>U<sub>AbsFluid</sub></code>.
  </p>
  
  <h4>Model limitations</h4>
  <p>
  Overall, the PVT1 validation demonstrates strong agreement between the model and measurements for both thermal and electrical outputs under a range of operating conditions. While electrical outputs are accurate and consistent across all day types, 
  limitations in thermal output are observed under high wind speeds and rapid irradiance changes, primarily due to datasheet parameter constraints. This is particularly evident in Day Type 4, where a large temperature difference between the fluid and ambient air amplifies these limitations. 
  The wind speed over the collector plane during most of the test periods is generated using an artificial blower, producing wind speeds around 3.5&nbsp;m/s. This lies near the upper boundary of the test range for the datasheet thermal parameters, potentially leading to additional discrepancies 
  between the modeled and measured results.
  </p>

  <h4>References</h4>
  <ul>
    <li>Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.</li>
    <li>Jonas, D. et al. (2019). “Performance modeling of PVT collectors: Implementation, validation and parameter identification approach using TRNSYS.” Solar Energy 193, pp. 51–64.</li>
    <li>Dobos, A. P. (2014). “PVWatts Version 5 Manual.” Tech. rep. NREL/TP-6A20-62641, Contract No. DE-AC36-08GO28308, Prepared under Task No. SS13.5030. National Renewable Energy Laboratory (NREL), Golden, CO, USA. URL: https://www.nrel.gov/docs/fy14osti/62641.pdf.</li>
      <li>ISO 9806:2013. “Solar thermal collectors—Test methods.” CEN.</li>
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
end PVT1;

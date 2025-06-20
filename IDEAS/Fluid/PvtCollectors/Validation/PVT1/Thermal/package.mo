within IDEAS.Fluid.PvtCollectors.Validation.PVT1;
package Thermal "Thermal Behavior of Unglazed Rear-Insulated PVT Collector"
  annotation (preferredView="info", Documentation(info=
"<html>
  <p>
  This subpackage contains four validation models for the thermal performance of the PVT1 collector, an uncovered PVT collector with rear insulation. The models correspond to the four ISO 9806:2013 day types:
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
    <li>Linear and quadratic heat losses (<code>c₁</code>, <code>c₂</code>)</li>
    <li>Convective heat losses (wind-dependent, <code>c₃</code>, <code>c₆</code>)</li>
    <li>Radiative heat losses (sky temperature dependent, <code>c₄</code>)</li>
    <li>Thermal inertia effects (<code>c₅</code>)</li>
  </ul>

  <p>
  The model is discretized into <code>nSeg</code> segments to capture temperature gradients along the flow path. All parameters are derived from manufacturer datasheets, without calibration.
  </p>

  <p>
  Validation results show strong agreement for day types 1–3, with thermal energy deviations below 5% and normalized MAE values ranging from 3.3% to 20.0%. For day type 4, 
  larger deviations (∆E = 36.7%) are observed due to high temperature differences and wind speeds, highlighting limitations in the datasheet-based coefficients under extreme conditions.
  </p>
  <h4>References</h4>
  <ul>
  <li>Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.</li>
    <li>ISO 9806:2013. “Solar thermal collectors—Test methods.” CEN.</li>
  </ul>
  </html>"));
end Thermal;

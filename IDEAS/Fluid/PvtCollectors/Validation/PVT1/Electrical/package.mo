within IDEAS.Fluid.PvtCollectors.Validation.PVT1;
package Electrical "Electrical Behavior of Unglazed Rear-Insulated PVT Collector"
  annotation (preferredView="info", Documentation(info=
"<html>
  <p>
  This subpackage contains four validation models for the electrical performance of the PVT1 collector, aligned with the same four ISO 9806:2013 day types used in the <code>Thermal</code> subpackage.
  </p>

  <p>
  Each model compares simulated and measured electrical output and computes the absorber-to-fluid heat transfer coefficient <code>U<sub>AbsFluid</sub></code> using a datasheet-based method (Meertens et al., 2025).
  </p>

  <p>
  The electrical model is based on the PVWatts V5 formulation and includes:
  </p>
  <ul>
    <li>Temperature-dependent efficiency losses</li>
    <li>Constant system loss factor (7%)</li>
  </ul>

  <p>
  The PV cell temperature is derived from the thermal model using a two-node coupling via <code>U<sub>AbsFluid</sub></code>. This coupling ensures accurate representation of the thermal-electrical interaction.
  </p>

  <p>
  Validation results show excellent agreement across all day types, with normalized MAE and RMSE values below 3.1%. The model is robust to variations in <code>U<sub>AbsFluid</sub></code>, confirming the reliability of the datasheet-based estimation.
  </p>
  <h4>References</h4>
  <ul>
    <li>Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.</li>
    <li>Dobos, A. P. (2014). “PVWatts Version 5 Manual.” Tech. rep. NREL/TP-6A20-62641, Contract No. DE-AC36-08GO28308, Prepared under Task No. SS13.5030. National Renewable Energy Laboratory (NREL), Golden, CO, USA. URL: https://www.nrel.gov/docs/fy14osti/62641.pdf.</li>
  </ul>
  </html>"));
end Electrical;

within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI;
package Electrical "Electrical Behavior of Unglazed Rear-Insulated PVT Collector"

  annotation (preferredView="info", Documentation(info=
"<html>
<p>
This subpackage contains four validation models for the electrical performance of the <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">PVT_UI</a> collector, 
aligned with the same four ISO 9806:2013 day types used in the <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Thermal\">Thermal</a> subpackage.
</p>

<p>
Each model compares simulated and measured electrical output and computes the absorber-to-fluid heat transfer coefficient <i>UAbsFluid</i> using a datasheet-based method (Meertens et al., 2025).
</p>

<p>
The electrical model is based on the PVWatts V5 formulation and includes:
</p>
<ul>
<li>Temperature-dependent efficiency losses</li>
<li>Constant system loss factor (9 %)</li>
</ul>

<p>
The PV cell temperature is derived from the thermal model using a two-node coupling via <i>UAbsFluid</i>. This coupling ensures accurate representation of the thermal-electrical interaction.
</p>

<p>
Validation results show excellent agreement across all day types, with normalized MAE and RMSE values below 3.1% (Meertens et al., 2025). The model is robust to variations in <i>UAbsFluid</i>, confirming the reliability of the datasheet-based estimation.
</p>
<h4>References</h4>
<ul>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic‑Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
</li>
<li>
Dobos, A. P. (2014). <i><a href='https://docs.nrel.gov/docs/fy14osti/62641.pdf'>PVWatts Version 5 Manual</a></i>. NREL/TP-6A20-62641
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
end Electrical;

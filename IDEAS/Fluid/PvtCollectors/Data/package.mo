within IDEAS.Fluid.PvtCollectors;
package Data "Data for photovoltaic–thermal (PVT) collectors"
extends Modelica.Icons.MaterialPropertiesPackage;

annotation (Documentation(info = "<html>
<p>
This package contains performance data records for photovoltaic–thermal (PVT) collectors.
Data is structured according to the ISO 9806:2013 quasi‑dynamic test method.
</p>
<p>
PVT collector types are categorized as follows:
</p>
<ul>
  <li><b>U:</b> Uncovered PVT collectors, subdivided into:
    <ul>
      <li><b>UI:</b> Uncovered PVT collectors <i>with</i> rear insulation</li>
      <li><b>UN:</b> Uncovered PVT collectors <i>without</i> rear insulation</li>
    </ul>
  </li>
  <li><b>C:</b> Covered (glazed or polymer) PVT collectors</li>
  <li><b>X:</b> Concentrating PVT collectors</li>
</ul>
<p>
All record names should begin with one of the above abbreviations to indicate the
collector classification (e.g., <code>UI_MyInsulatedPVT</code>, <code>UN_MyBarePVT</code>, <code>C_MyGlazedPVT</code>, <code>X_MyConcentratorPVT</code>).
</p>
<h4>References</h4>
<ul>
<li>
IEA SHC (2018). Task 60. PVT Systems: Application of PVT Collectors and New Solutions in HVAC Systems.
<a href=\"https://www.iea-shc.org/task60\">https://www.iea-shc.org/task60</a>. International Energy Agency Solar Heating and Cooling Programme.
</li>
</ul>
</html>"));
end Data;

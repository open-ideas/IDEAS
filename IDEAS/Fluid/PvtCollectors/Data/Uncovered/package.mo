within IDEAS.Fluid.PVTCollectors.Data;
package Uncovered
  "Performance data for uncovered (WISC) PVT collectors"
extends Modelica.Icons.MaterialPropertiesPackage;

  annotation (
Documentation(info = "<html>
<p>
This package contains thermal and electrical performance data for uncovered photovoltaic–thermal collectors, also known as WISC (Wind and Infrared Sensitive Collectors).
All records conform to ISO 9806:2013 quasi-dynamic thermal testing, with parameters sourced from 
Solar Keymark Certificates. The thermal parameters apply to the PV module operating in maximum power point (MPP) mode, 
and the electrical performance parameters can be retrieved from manufacturer datasheets.
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

end Uncovered;

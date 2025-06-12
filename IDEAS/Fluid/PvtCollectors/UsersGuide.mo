within IDEAS.Fluid.PvtCollectors;
package UsersGuide "User’s Guide"
  extends Modelica.Icons.Information;
  annotation(preferredView="info",
    Documentation(info="<html>
<p>
This package contains a model for photovoltaic–thermal (PVT) collectors
based on the ISO 9806:2013 quasi-dynamic thermal procedure (EN 12975)
coupled with an internal electrical submodel. Only the quasi-dynamic
approach is directly supported.
</p>

<h4>Using unglazed test data</h4>
<p>
Thermal parameters obtained from an ISO 9806:2013 unglazed test (or
ISO 9806:2017 quasi-dynamic) can be converted into the
thermal parameter set required by the quasi-dynamic model
using the procedure described in
<a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">
SKN-N0474R0: Thermal Performance Parameter Conversion to ISO 9806-2017</a>.
</p>

<h4>Model description</h4>
<ul>
  <li>
    <code>QuasiDynamicPvtCollector</code>: EN 12975 quasi-dynamic
    thermal method with two-node PV-fluid electrical coupling;
    requires only manufacturer datasheet inputs.
  </li>
</ul>

<h4>References</h4>
<ul>
  <li>
    Meertens, L., Jansen, J., Helsen, L. (2025). “Development and
    Experimental Validation of a Quasi-Dynamic Photovoltaic-Thermal
    Collector Modelica Model using Datasheet Parameters.”
    <em>Proceedings of the Modelica Conference 2025</em>.
  </li>
  <li>
    ISO 9806:2013. “Solar thermal collectors—Test methods.”
    CEN.
  </li>
  <li>
    SKN-N0474R0. “Thermal Performance Parameter Conversion to
    ISO 9806-2017.” Solar Heat Europe, October 2019.
  </li>
  <li>
    IDEAS issue:
    <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
    Implement validated dynamic PVT collector model #1436</a>.
  </li>
</ul>
</html>"));
end UsersGuide;

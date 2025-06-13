within IDEAS.Fluid.PvtCollectors;
package UsersGuide "User’s Guide"
  extends Modelica.Icons.Information;
  annotation(preferredView="info",
    Documentation(info="<html>
<p>
This package contains a model for photovoltaic–thermal (PVT) collectors
based on the ISO 9806:2013 quasi-dynamic thermal procedure (EN 12975)
coupled with an internal electrical submodel. Only the quasi-dynamic
approach is directly supported to model the thermal performance.
</p>

<h4>Model description</h4>
<ul>
  <li>
    <code>QuasiDynamicPvtCollector</code>: EN 12975 quasi-dynamic
    thermal method with two-node PV–fluid electrical coupling;
    requires only manufacturer datasheet inputs.
  </li>
</ul>

<h4>1. Conversion of other ISO 9806 standards (thermal)</h4>
<p>
Thermal parameters obtained from other ISO 9806 test procedures, such as
the ISO 9806:2013 unglazed test or the ISO 9806:2017 quasi-dynamic method, can be
converted into the <code>c<sub>1</sub>…c<sub>6</sub>, η<sub>0</sub>, K<sub>d</sub></code>
thermal parameter set required by this model using the procedure detailed in
<a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">
SKN-N0474R0: Thermal Performance Parameter Conversion to ISO 9806-2017</a>.
</p>
<p>
Because <code>QuasiDynamicPvtCollector</code> extends
<code>IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector</code> and uses
similar solar gain and heat loss blocks as the EN 12975 solar collector model
(<code>IDEAS.Fluid.SolarCollectors.EN12975</code>), it is also advisable to consult
the SolarCollectors User’s Guide
(<a href=\"modelica://IDEAS.Fluid.SolarCollectors.UsersGuide\">
IDEAS.Fluid.SolarCollectors.UsersGuide</a>) for deeper insights into thermal performance data
and parameter usage.
</p>

<h4>2. Electrical performance and losses</h4>
<p>
The electrical submodel follows the PVWatts v5 approach (Dobos, 2014),
with module parameters from the datasheet plus an overall system loss factor
<code>pLossFactor</code>. NREL’s PVWatts reports a typical total loss of
14 %, distributed as:
</p>
<table border=\"1\" cellpadding=\"4\">
  <tr><th>Loss mechanism</th><th>Default value</th></tr>
  <tr><td>Soiling</td><td>2 %</td></tr>
  <tr><td>Shading</td><td>3 %</td></tr>
  <tr><td>Mismatch</td><td>2 %</td></tr>
  <tr><td>Wiring</td><td>2 %</td></tr>
  <tr><td>Connections</td><td>0.5 %</td></tr>
  <tr><td>Light-induced degradation</td><td>1.5 %</td></tr>
  <tr><td>Nameplate rating</td><td>1 %</td></tr>
  <tr><td>Availability</td><td>3 %</td></tr>
  <tr><th>Total</th><th>14 %</th></tr>
</table>
<p>
For well-maintained, unshaded modules, experimental validation (Meertens et al., 2025)
found that using <code>pLossFactor = 7 %</code> gives excellent agreement with
measured electrical output. Users may adjust <code>pLossFactor</code> to account for
site-specific soiling or shading effects.
</p>

<h4>3. Electrical–thermal coupling</h4>
<p>
The internal heat transfer coefficient <code>UAbsFluid</code> is calculated from datasheet parameters:
</p>
<div style=\"display:flex; align-items:center; justify-content:center;\">
  <div style=\"padding-right:8px; font-weight:bold;\">UAbsFluid =</div>
  <table style=\"border-collapse:collapse; text-align:center;\">
    <tr>
      <td style=\"padding:4px;\">
        <em>(τ·α)<sub>eff</sub> – η<sub>0,el</sub></em> · (c<sub>1</sub> + c<sub>3</sub>·u + b<sub>1,el</sub>)
      </td>
    </tr>
    <tr>
      <td style=\"border-top:1px solid black; padding:4px;\">
        <em>(τ·α)<sub>eff</sub> – η<sub>0,el</sub></em>
        – (1 – <em>c<sub>6</sub>/η<sub>0,th</sub></em>·u) · η<sub>0,th</sub>
      </td>
    </tr>
  </table>
</div>
<ul>
  <li>
    <b>τ·α<sub>eff</sub></b> = 0.901 for uncovered PVT; 0.84 for covered PVT.
  </li>
  <li>
    <b>b<sub>1,el</sub></b> = |γ|·G<sub>STC</sub> (electrical datasheet parameters).
  </li>
  <li>
    <b>u</b> = in-plane wind speed. <code>UAbsFluid</code> is only weakly dependent on external wind speed
    when the thermal datasheet parameters are accurate (Stegmann 2011). Therefore, for simplicity, <code>u = 0</code> is used to derive <code>UAbsFluid</code>.
  </li>
</ul>


<p>
This approach removes the need for a hidden fit parameter: both thermal
and electrical coupling coefficients derive solely from publicly available
datasheet values.
</p>

<h4>References</h4>
<ul>
  <li>ISO 9806:2013. “Solar thermal collectors—Test methods.” CEN.</li>
  <li>SKN-N0474R0. “Thermal Performance Parameter Conversion to ISO 9806-2017.” Solar Heat Europe, 2019.</li>
  <li>Stegmann, M. et al. (2011). “Model of an unglazed PVT collector based on standard test procedures.” SWC 2011.</li>
  <li>Lämmle, M. (2018). “Thermal management of PVT collectors…” PhD thesis, University Freiburg.</li>
  <li>Dobos, A. P. (2014). <i>PVWatts Version 5 Manual</i>. NREL/TP-6A20-62641.</li>
  <li>Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.</li>
</ul>
</html>"));
end UsersGuide;

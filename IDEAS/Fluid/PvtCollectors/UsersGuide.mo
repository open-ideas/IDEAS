within IDEAS.Fluid.PVTCollectors;
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

<h5>Conversion of other ISO 9806 standards (thermal)</h5>
<p>
Thermal parameters obtained from other ISO 9806 test procedures, such as
the ISO 9806:2013 unglazed test or the ISO 9806:2017 quasi-dynamic method, can be
converted into the <code>c<sub>1</sub>…c<sub>6</sub>, η<sub>0</sub>, K<sub>d</sub></code>
thermal parameter set required by this model using the procedure detailed in
<a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">
SKN-N0474R0: Thermal Performance Parameter Conversion to ISO 9806-2017</a>.
</p>
<p>
Because <code>QuasiDynamicPvtCollector</code> extends from <a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector\">
IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector</a> and uses
similar solar gain and heat loss blocks as <a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>, it is also advisable to consult
the SolarCollectors User’s Guide
(<a href=\"modelica://IDEAS.Fluid.SolarCollectors.UsersGuide\">IDEAS.Fluid.SolarCollectors.UsersGuide</a>) for deeper insights into thermal performance data
and parameter usage.
</p>

<h5>Electrical performance and losses</h5>
<p>
The electrical submodel follows the PVWatts v5 approach (Dobos, 2014),
with module parameters from the datasheet plus an overall system loss factor
<code>pLossFactor</code>. NREL’s PVWatts reports a total electrical power loss of
14%, which are a result of the following loss mechanism:
</p>
<table border=\"1\" cellpadding=\"4\">
  <tr>
    <th style=\"text-align:left;\">Electrical power loss mechanism</th>
    <th style=\"text-align:center;\">Default value</th>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Soiling</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Shading</td>
    <td style=\"text-align:center;\">3 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Mismatch</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Wiring</td>
    <td style=\"text-align:center;\">2 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Connections</td>
    <td style=\"text-align:center;\">0.5 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Light‑induced degradation</td>
    <td style=\"text-align:center;\">1.5 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Nameplate rating</td>
    <td style=\"text-align:center;\">1 %</td>
  </tr>
  <tr>
    <td style=\"text-align:left;\">Availability</td>
    <td style=\"text-align:center;\">3 %</td>
  </tr>
  <tr>
    <th style=\"text-align:left;\">Total</th>
    <th style=\"text-align:center;\">14 %</th>
  </tr>
</table>

<p>
For well-maintained, unshaded modules, experimental validation (Meertens et al., 2025)
found that using <code>pLossFactor = 7-10 %</code> gives excellent agreement with
measured electrical output. Users may adjust <code>pLossFactor</code> to account for
site-specific soiling or shading effects.
</p>

<h5>Electrical–thermal coupling</h5>
<p>
  The internal heat transfer coefficient <i>UAbsFluid</i> is approximately calculated from datasheet parameters:
</p>

<div style=\"display:flex; align-items:center; justify-content:center;\">
  <div style=\"padding-right:8px;\"><i>UAbsFluid</i></div>
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
    Here, <i>(τ·α)</i><sub>eff</sub> = 0.901 for unglazed PVT collectors as reported in Lämmle (2018), and = 0.84 for covered collectors.
  </li>
  <li>
    The electrical temperature‑dependence term is <i>b</i><sub>1,el</sub> = |<i>β</i>| · G<sub>nom</sub>, where <i>β</i> is the temperature coefficient of power (in % K<sup>−1</sup>) and G<sub>nom</sub> = 1000 W m<sup>−2</sup>.
  </li>
  <li>
    <i>u</i> is the in‑plane wind speed. In this approximation, <code>u = 0</code> is used to derive <i>UAbsFluid</i>—the internal heat transfer coefficient is only weakly dependent on external wind speed when the datasheet thermal parameters are accurate (Stegmann 2011).
  </li>
</ul>

<p>
This approach removes the need for a hidden fit parameter: both thermal
and electrical coupling coefficients derive solely from publicly available
datasheet values.
</p>
<h4>References</h4>
<ul>
<li>
ISO 9806:2013. “Solar thermal collectors—Test methods.” CEN.
</li>
<li>
SKN-N0474R0. “Thermal Performance Parameter Conversion to ISO 9806-2017.” Solar Heat Europe, 2019.
</li>
<li>
Stegmann, M. et al. (2011). “Model of an unglazed PVT collector based on standard test procedures.” SWC 2011.
</li>
<li>
Lämmle, M. (2018). “Thermal management of PVT collectors…” PhD thesis, University Freiburg.
</li>
<li>
Dobos, A. P. (2014). <i>PVWatts Version 5 Manual</i>. NREL/TP-6A20-62641.
</li>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.
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
end UsersGuide;

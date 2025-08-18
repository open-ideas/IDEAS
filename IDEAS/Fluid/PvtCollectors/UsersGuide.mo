within IDEAS.Fluid.PVTCollectors;
package UsersGuide "User’s Guide"
  extends Modelica.Icons.Information;
  annotation(preferredView="info",
    Documentation(info="<html>
<p>
This package contains a model for photovoltaic–thermal (PVT) collectors
based on the ISO 9806:2013 quasi-dynamic thermal procedure
coupled with an internal electrical submodel. 
</p>

<h4>Model description</h4>

<h5>Thermal part</h5>
<p>
The equations related to the heat losses and heat gains can be found in the following models:
</p>
<ul>
<li>
Quasi‑dynamic thermal losses: see 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss\">
IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss
</a>
</li>
<li>
Solar (thermal) heat gain: see 
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain
</a>
</li>
</ul>
</p>


<p> 
Thermal parameters used in the Quasi-dynamic thermal losses model follow the ISO 9806:2013 quasi-dynamic thermal procedure.
Parameters obtained from other ISO 9806 test procedures, such as the ISO 9806:2013 unglazed test or the ISO 9806:2017 quasi-dynamic method, 
can be converted into the thermal parameter set required by this model (<code>c1</code> to <code>c6</code>, <code>η0</code>, and <code>Kd</code>)
using the procedure detailed in <a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">
SKN-N0474R0: Thermal Performance Parameter Conversion to ISO 9806-2017</a>. 
</p>


<h5>Electrical part</h5>

<p>
The equations and assumptions related to electrical part can be found in the following model:
</p>

<ul>
<li>
Electrical generation: see 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT\">
IDEAS.Fluid.PVTCollectors.BaseClasses.ElectricalPVT
</a>
</li>
</ul>


<h5>Electrical–thermal coupling</h5>
<p>
The internal heat transfer coefficient <i>UAbsFluid</i> (visualised in Figure 1) is approximately calculated from datasheet parameters:
</p>
<div style=\"display:flex; align-items:center; justify-content:center;\">
<div style=\"padding-right:8px;\"><i>UAbsFluid = </i></div>
<table style=\"border-collapse:collapse; text-align:center;\">
<tr>
<td style=\"padding:4px;\">
<em>(&tau;&#183;&alpha;)<sub>eff</sub> – &eta;<sub>0,el</sub></em> &#183; (c<sub>1</sub> + c<sub>3</sub>&#183;u + b<sub>1,el</sub>)
</td>
</tr>
<tr>
<td style=\"border-top:1px solid black; padding:4px;\">
<em>(&tau;&#183;&alpha;)<sub>eff</sub> – &eta;<sub>0,el</sub></em>
– (1 – <em>c<sub>6</sub>/&eta;<sub>0,th</sub></em>·u) &#183; &eta;<sub>0,th</sub>
</td>
</tr>
</table>
</div>
<ul>
<li>
Here, <i>(&tau;&#183;&alpha;)<sub>eff</sub> = 0.901</i> for unglazed PVT collectors as reported in Lämmle (2018), and <i> 0.84 </i>for covered collectors.
</li>
<li>
The electrical temperature‑dependence term is <i>b<sub>1,el</sub> = |&gamma;| &#183; G<sub>nom</sub></i>, where <i>&gamma;</i> is the temperature coefficient of power (in % K<sup>−1</sup>) and <i>G<sub>nom</sub> = 1000</i> W m<sup>−2</sup>.
</li>
<li>
<i>u</i> is the in-plane wind speed. In this approximation, <i>u = 0</i> is used to derive <i>UAbsFluid</i>. The internal heat transfer coefficient is only weakly dependent on external wind speed when the datasheet thermal parameters are accurate (Stegmann 2011).
</li>
</ul>

<p>
This approach removes the need for a hidden fit parameter: both thermal
and electrical coupling coefficients derive solely from publicly available
datasheet values.
</p>

<p align=\"center\">
<img alt=\"Two-node, one-capacitance thermal network for PVT collectors (ISO 9806: dashed lines; extension: solid lines).\" 
 src=\"modelica://IDEAS/Resources/Images/Fluid/PVTCollectors/RCnetwork_dotted.png\" width=\"500\"/>
</p>
<p style=\"text-align:center; font-style:italic; font-size:90%;\">
Figure 1: Two-node, one-capacitance thermal network for PVT collectors (ISO 9806: dashed lines; extension: solid lines) (Meertens et al., 2025).<br/>
</p>

<h4>References</h4>
<ul>
<li>
ISO 9806:2013. <i><a href='https://www.iso.org/standard/59879.html'>Solar thermal collectors — Test methods</a></i>. ISO.
</li>

<li>
SKN-N0474R0. <i><a href='https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf'>Thermal Performance Parameter Conversion to ISO 9806-2017</a></i>. Solar Heat Europe, 2019.
</li>

<li>
Stegmann, M.; Bertram, E.; Rockendorf, G.; Janßen, S. (2011). <i><a href='https://proceedings.ises.org/conference/swc2011/papers/swc2011-0221-Stegmann.pdf'>Model of an Unglazed Photovoltaic Thermal Collector Based on Standard Test Procedures</a></i>. ISES Solar World Congress proceedings. DOI: 10.18086/swc.2011.19.30
</li>

<li>
Lämmle, M. (2018). <i><a href='https://freidok.uni-freiburg.de/files/16446/_kjSuAarLmHmjl3z/diss_laemmle.pdf'>Thermal management of PVT collectors: development and modelling of highly efficient glazed, flat plate PVT collectors with low emissivity coatings and overheating protection</a></i>. PhD thesis, University of Freiburg. DOI: 10.6094/UNIFR/16446
</li>

<li>
Dobos, A. P. (2014). <i><a href='https://docs.nrel.gov/docs/fy14osti/62641.pdf'>PVWatts Version 5 Manual</a></i>. NREL/TP-6A20-62641
</li>

<li>
Meertens, L.; Jansen, J.; Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>. Submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
</li>
</ul>


</html>",
revisions="<html>
<ul>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model.
see <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436
</a>.
</li>
</ul>
</html>"));
end UsersGuide;

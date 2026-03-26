within IDEAS.Fluid.PVTCollectors.Validation;
package PVT_UN
    annotation (preferredView="info", Documentation(info=
    "<html>
<p>
This package contains validation models for the <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">PVT_UN</a> collector 
(referred to as <code>PVT2</code> in Meertens et al., 2026), 
an uncovered and uninsulated PVT collector, 
based on experimental data from a long-term outdoor test campaign in Austria (Veynandt et al., 2023).
</p>
<p>
The full dataset spans 58 consecutive summer days with 5-second resolution, capturing a wide range of operating conditions.
Notably, the test period includes days with several hours of very high wind speeds, reaching up to <i>10–12&nbsp;m/s</i>, 
which significantly affect convective heat losses.
</p>
<p>
The full dataset was split into 8 weeks to limit the file size per dataset.
The validation models allow to change the week via the parameter <code>week</code>.
The user can also merge the files together into one dataset and 
change the <code>fileName</code> parameter in the <code>meaDat</code> block
to simulate the all 58 summer days in one run.
</p>
<p>
The package includes two models:
</p>
<ul>
<li>
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.Thermal\">Thermal</a>: 
Validates thermal output using the quasi-dynamic ISO 9806:2017 formulation.
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.Electrical\">Electrical</a>: 
Validates electrical output using the PVWatts V5 formulation.
</li>
</ul>
<p>
Due to the absence of rear insulation and the continuous operation of the circulation pump, 
also during periods of negative thermal output, the raw energy deviation of +54.9 % 
is not representative of real-world operation. In practice, the pump would only be activated when thermal gains exceed losses. 
When filtered to periods with positive thermal output, 
the deviation improves to +8.09%. This filtered metric provides a more meaningful assessment of the model performance.
</p>
<p>
Due to the absence of rear insulation, the continuous operation of the circulation
pump—even during periods of negative thermal output—and the exceptionally high
HTF–ambient temperature differences imposed by the experimental setup
(an operating regime not representative for unglazed PVT collectors, which
normally run at much lower temperatures), the raw energy deviation of +54.9% is
not representative of real-world operation. In practice, the pump would only be
activated when thermal gains exceed losses. When filtered to periods with
positive thermal output, the deviation improves to +8.09%. This filtered metric 
therefore provides a more meaningful assessment of the model performance under 
such extreme conditions.
</p>
<p>
The electrical model shows excellent agreement with measurements, with a nMAE of 5.3% and nRMSE of 10.1%. 
The model is robust to variations in <code>U<sub>AbsFluid</sub></code>, confirming the reliability of the datasheet-based estimation method.
</p>

<h4>References</h4>
<ul>
<li>
Meertens, L.; Jansen, J.; Helsen, L. (2026).
<i>Development and Experimental Validation of an Open-Source 
Photovoltaic‑Thermal Collector Modelica Model that Only Needs
Datasheet Parameters</i>. Submitted to 
Mathematical and Computer Modelling of Dynamical Systems,
Special Issue on Modelica, FMI, and Open Standards.
</li>
<li>
Veynandt, François, Franz Inschlag, et al. <i><a href='https://doi.org/10.1016/j.dib.2023.109417'>
Measurement data from real operation of a hybrid photovoltaic‑thermal solar collectors, used for the development of a data‑driven model</a></i>. 
Data in Brief 49 (2023): 109417. DOI: 10.1016/j.dib.2023.109417
</li>
<li>
Veynandt, François, Peter Klanatsky, et al. <i><a href='https://doi.org/10.1016/j.enbuild.2023.113277'>
Hybrid photovoltaic‑thermal solar collector modelling with parameter identification using operation data</a></i>. 
Energy and Buildings. 295 (2023): 113277. DOI: 10.1016/j.enbuild.2023.113277
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
March 11, 2026, by Lone Meertens:<br/>
Updated thermal formulation from ISO 9806:2013 to ISO 9806:2017 and added
conversion support.This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1473\">#1473</a>.
</li>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model. 
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>"));
end PVT_UN;

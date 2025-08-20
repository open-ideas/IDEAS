within IDEAS.Fluid.PVTCollectors.Data.Uncovered;
record UN_Validation =
  IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic(
    final A=1.64,
    final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C=22100*1.64,
    final V=1.54/1000,
    final mDry=30,
    final mperA_flow_nominal=0.02,
    final dp_nominal=300000,
    final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
    final incAngModDat={1,1,1,1,0.99,0.97,0.92,0.80,0.55,0.00},
    final colTyp=IDEAS.Fluid.PVTCollectors.Types.CollectorType.Uncovered,
    final IAMDiff=0.93,
    final eta0=0.535,
    final c1=10.74,
    final c2=0.0,
    final c3=1.0997,
    final c4=0.535*0.85*(1-3*0.067),
    final c6=0.067*0.535,
    final P_nominal=300,
    final gamma=-0.00375,
    final etaEl=0.183)
  "Parameters for an uncovered flat-plate PVT collector without rear cover or back-side insulation"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datPVTCol",
  Documentation(info = "<html>
<p>
This record contains performance parameters for a flat‑plate, <b>uncovered</b> and <b>uninsulated</b> PVT collector, 
derived from manufacturer datasheets and thermal rating documentation. 
Thermal parameters follow the ISO 9806:2013 quasi‑dynamic format and correspond to operation at the PV module’s maximum power point (MPP).
</p>
<p>
The thermal coefficients were originally obtained using the ISO 9806:2013 unglazed 
steady-state method, and converted to quasi‑dynamic form according to the procedure detailed 
in <a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">
SKN-N0474R0: Thermal Performance Parameter Conversion to ISO 9806-2017</a>. 
</p>
<p>
For this PVT collector, additional real-life measurement data is publicly available (Veynandt, 2023) and has been used in the validation of 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.PVTQuasiDynamicCollector\">IDEAS.Fluid.PVTCollectors.PVTQuasiDynamicCollector</a>, 
which can be found in the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">IDEAS.Fluid.PVTCollectors.Validation.PVT_UN</a> package. 
</p>

<h4>Certificate</h4>
<ul>
<li> <a href=\"https://www.dincertco.de/logos/011-7S2354%20P.pdf\">
Solar Keymark Licence No. 11‑7S2354 P</a>. </li>
</ul>

<h4>References</h4>
<ul>
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
<li>
Solar Keymark Network (2019). 
<i><a href='https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf'>
Thermal performance parameter conversion to the ISO 9806‑2017 quasi‑dynamic method</a></i>. SKN‑N0474R0
</li>
<li>
ISO 9806:2013. <i><a href='https://www.iso.org/standard/59879.html'>Solar thermal collectors — Test methods</a></i>
</li>
<li>
Meertens, L., Jansen, J., Helsen, L. (2025). 
<i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, 
submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025
</li>
</ul>
</html>"),
revisions="<html>
<ul>
<li>
July 7, 2025, by Lone Meertens:<br/>
First implementation PVT model.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
</li>
</ul>
</html>");

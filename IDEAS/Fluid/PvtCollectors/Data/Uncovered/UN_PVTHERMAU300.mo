within IDEAS.Fluid.PvtCollectors.Data.Uncovered;
record UN_PVTHERMAU300 =
  IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic(
    final A = 1.66,
    final CTyp = IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C = 42200 * 1.66,
    final V = 5 / 1000,
    final mDry = 28,
    final mperA_flow_nominal = 0.03,
    final dp_nominal = 60000,
    final incAngDat = Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,90}),
    final incAngModDat = {1,1,1,0.99,0.99,0.98,0.96,0.92,0.00},
    final IAMDiff = 1,
    final eta0   = 0.475,
    final c1     = 7.411,
    final c2     = 0.0,
    final c3     = 1.7,
    final c4     = 0.437,
    final c6     = 0.003,
    final Pstc = 300,
    final gamma = -0.00375,
    final eta0El = 0.183)
  "Parameters for a flat‑plate, uncovered & uninsulated PVT collector"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datPVTHERMAU300",
  Documentation(info = "<html>
<p>
This record contains performance parameters for a flat‑plate, <b>uncovered</b> and <b>uninsulated</b> PVT collector, derived from <i>PVT 2</i>—the real‑operation dataset on a test bench in Austria (1.66 m² gross).</p>

<h4>Dataset description</h4>
<ul>
  <li>Measurement period: 58 summer days (July 11 – September 6, 5 s sampling interval).</li>
  <li>Publicly available; used for data‑driven and grey‑box PVT modelling.</li>
</ul>
<p>See Veynandt, Inschlag, et al. (2023) for the raw measurement data and Veynandt, Klanatsky, et al. (2023) for a grey‑box model built on this dataset.</p>

<h4>Certificate</h4>
<ul>
  <li>Solar Keymark Licence No. 11‑7S2354 P</li>
</ul>

<h4>Data conversion</h4>
<p>
Thermal coefficients were originally obtained via the unglazed steady‑state method and then converted to quasi‑dynamic form following Solar Keymark Network’s approach (2019).
</p>

<h4>References</h4>
<ul>
  <li>
    Veynandt, François, Franz Inschlag, et al. “Measurement data from real operation of a hybrid photovoltaic‑thermal solar collectors, used for the development of a data‑driven model.” <i>Data in Brief</i> 49 (2023): 109417. DOI: 10.1016/j.dib.2023.109417.
  </li>
  <li>
    Veynandt, François, Peter Klanatsky, et al. “Hybrid photovoltaic‑thermal solar collector modelling with parameter identification using operation data.” <i>Energy and Buildings</i> 295 (2023): 113277. DOI: 10.1016/j.enbuild.2023.113277.
  </li>
  <li>
    Solar Keymark Network (2019). <i>Thermal performance parameter conversion to the ISO 9806‑2017 quasi‑dynamic method</i>. <a href=\"https://solarheateurope.eu/wp-content/uploads/2019/10/SKN-N0474R0_Thermal-performance-parameter-conversion-to-the-ISO9806-2017.pdf\">SKN‑N0474R0</a>.
  </li>
  <li>
    ISO 9806:2013. <i>Solar thermal collectors — Test methods</i>.
  </li>
</ul>
</html>"),
  revisions = "<html>
<ul>
  <li>
    June 13, 2025, by Lone Meertens<br/>
  </li>
</ul>
</html>");

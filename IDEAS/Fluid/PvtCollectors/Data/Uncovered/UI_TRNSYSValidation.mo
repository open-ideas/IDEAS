within IDEAS.Fluid.PvtCollectors.Data.Uncovered;
record UI_TRNSYSValidation=
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
    final c6     = 0.003) "Parameters for an uncovered flat-plate PVT collector that
features a rear cover and thermal insulation on the back
of the absorber"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datWiscPvt",
  Documentation(info = "<html>
<p>
This record contains performance parameters for an uncovered (WISC) flat-plate PVT collector,
tested under ISO 9806:2013 quasi-dynamic conditions (Solar Keymark Certificate No. 011-7S2782P). Thermal performance parameters are given for the PV module operating
at maximum power point (MPP mode). Data retrieved from the Solar Keymark database on certified PVT products.
</p>
<h4>Certificate</h4>
<ul>
  <li>Solar Keymark Certificate No. 011-7S2782P</li>
</ul>
<h4>References</h4>
<ul>
  <li>
    Solar Keymark Certificate 011-7S2782P, SRCC database.
  </li>
  <li>
    ISO 9806:2013. Solar thermal collectors — Test methods.
  </li>
  <li>
    IEA SHC Task 60 (2018). <i>PVT Systems: Application of PVT Collectors and New Solutions in HVAC Systems</i>.
    <a href=\"https://www.iea-shc.org/task60\">iea-shc.org/task60</a>.
  </li>
</ul>
</html>",
  revisions = "<html>
<ul>
  <li>
    June 12, 2025, by Lone Meertens:<br/>
    Added SRCC-validated data record for uncovered (WISC) flat-plate PVT collector.<br/>
    Solar Keymark Certificate No. 011-7S2782P.<br/>
    Thermal parameters correspond to MPP operation mode.
  </li>
</ul>
</html>"));

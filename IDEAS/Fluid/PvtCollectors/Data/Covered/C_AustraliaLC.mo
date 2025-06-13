within IDEAS.Fluid.PvtCollectors.Data.Covered;
record C_AustraliaLC =
  IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic(
    final A = 1.98,
    final CTyp = IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C = 16370 * 1.98,
    final V = 5 / 1000,
    final mDry = 28,
    final mperA_flow_nominal = 0.02,
    final dp_nominal = 60000,
    final incAngDat = Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,90}),
    final incAngModDat = {1,1,0.99,0.97,0.93,0.88,0.78,0.58,0.00},
    final IAMDiff = 0.946,
    final eta0   = 0.683,
    final c1     = 5.127,
    final c2     = 0.03,
    final c3     = 0,
    final c4     = 0,
    final c6     = 0) "SRCC-validated performance parameters for an uncovered (unglazed) flat-plate PVT collector, Solar Keymark Certificate 011-7S2782P"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datWiscPvt",
  Documentation(info = "<html>
<p>
This record contains parameters for an <b>covered</b> flat-plate PVT collector.

</p>
<h4>Certificate</h4>
<ul>
  <li>Solar Keymark Certificate No. 011-7S1790F</li>
</ul>
<h4>References</h4>
<ul>
  <li>
    Solar Keymark Certificate 011-7S1790F, SRCC database.
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
    Added SRCC-tested data record for covered flat-plate PVT collector.<br/>
    Solar Keymark Certificate No. 011-7S1790F.<br/>
  </li>
</ul>
</html>"));

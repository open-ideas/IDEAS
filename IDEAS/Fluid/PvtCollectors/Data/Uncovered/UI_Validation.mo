within IDEAS.Fluid.PVTCollectors.Data.Uncovered;
record UI_Validation =
  IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic(
    final A=1.66,
    final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C=42200*1.66,
    final V=5/1000,
    final mDry=28,
    final mperA_flow_nominal=0.03,
    final dp_nominal=60000,
    final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,
        90}),
    final incAngModDat={1,1,1,0.99,0.99,0.98,0.96,0.92,0.00},
    final IAMDiff=1,
    final eta0=0.475,
    final c1=7.411,
    final c2=0.0,
    final c3=1.7,
    final c4=0.437,
    final c6=0.003,
    final P_nominal=280,
    final gamma=-0.0041,
    final etaEl=0.1687)
  "Parameters for an uncovered flat-plate PVT collector with rear cover and back-side thermal insulation"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datPVTCol",
  Documentation(info = "<html>
<p>
This record contains anonymized thermal and electrical performance parameters for an <b>uncovered</b> photovoltaic–thermal (PVT) collector <b>with rear insulation</b>, 
tested under ISO 9806:2013 quasi-dynamic conditions. Thermal performance parameters correspond to operation
of the PVT collector at maximum power point (MPP mode).
</p>

<p>
This datasheet is used in the validation of 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.PVTQuasiDynamicCollector\">IDEAS.Fluid.PVTCollectors.PVTQuasiDynamicCollector</a>, 
which can be found in the 
<a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT1\">IDEAS.Fluid.PVTCollectors.Validation.PVT1</a> package. 
</p>


<h4>References</h4>
<ul>
  <li>
    ISO 9806:2013. Solar thermal collectors — Test methods.
  </li>
  <li>
    IEA SHC Task 60 (2018). <i>PVT Systems: Application of PVT Collectors and New Solutions in HVAC Systems</i>.
    <a href=\"https://www.iea-shc.org/task60\">iea-shc.org/task60</a>.
  </li>
  <li>
    Meertens, L., Jansen, J., Helsen, L. (2025). <i>Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters</i>, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
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

within IDEAS.Fluid.PVTCollectors.Data.Uncovered;
record UN_Jonas2018 =
  IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic(
    final A=1.66,
    final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C=35800*1.66,
    final V=5/1000,
    final mDry=20,
    final mperA_flow_nominal=0.03,
    final dp_nominal=60000,
    final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,90}),
    final incAngModDat={1,1,0.99,0.98,0.97,0.95,0.92,0.88,0.00},
    final IAMDiff=0.91,
    final eta0=0.436,
    final c1=7.750,
    final c2=0.026,
    final c3=1.640,
    final c4=0.000,
    final c6=0.008,
    final P_nominal=280,
    final gamma=-0.00467,
    final etaEl=0.1688)
  "Parameter set for a uncovered, non-insulated PVT collector (WISC type) based on Jonas et al. (2018)"
annotation(
  defaultComponentPrefixes = "parameter",
  defaultComponentName     = "datPVTCol",
  Documentation(info = "<html>
<p>
This record contains thermal and electrical parameters for an <b>uncovered</b> and <b>non-insulated</b> PVT collector (WISC type), based on experimental identification results from Jonas et al. (2018). 
These parameters were used in the validation of a TRNSYS PVT collector model under ISO 9806:2013 quasi-dynamic conditions.
</p>
<p>
This record can be used as a generic representation of a WISC-type collector. However, if you know the brand and model of the PVT collector you plan to simulate or install, it is recommended to use the actual datasheet parameters in a custom <code>IDEAS.Fluid.PVTCollectors.Data.GenericQuasiDynamic</code> record.
</p>
<h4>Reference</h4>
<ul>
<li>
Jonas, D., Theis, D., Frey, G. (2018). <i>Implementation and Experimental Validation of a Photovoltaic-Thermal (PVT) Collector Model in TRNSYS</i>. EuroSun 2018. DOI: 10.18086/eurosun2018.02.16
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

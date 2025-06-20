within IDEAS.Fluid.PvtCollectors.Data.WISC;
record WISC_TRNSYSValidation =
  IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic (
    final A=1.66,
    final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
    final C=42200*1.66,
    final V=5/1000,
    final mDry=28,
    final mperA_flow_nominal=0.03,
    final dp_nominal=60000,
    final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,90}),
    final incAngModDat={1,1,1,0.99,0.99,0.98,0.96,0.92,0.00},
    final IAMDiff=1,
    final eta0=0.475,
    final c1=7.411,
    final c2=0.0,
    final c3=1.7,
    final c4=0.437,
    final c6=0.003)
    annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="datPvtCol",
Documentation(info = "<html>
    
    <h4>References</h4>
      <p>
        Ratings data taken from the <a href=\"http://www.solar-rating.org\">
        Solar Rating and Certification Corporation website</a>. 
      </p>
    </html>"));

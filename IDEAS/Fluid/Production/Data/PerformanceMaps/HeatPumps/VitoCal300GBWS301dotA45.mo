within IDEAS.Fluid.Production.Data.PerformanceMaps.HeatPumps;
record VitoCal300GBWS301dotA45
  "Viessmann Vitocal 300-G, type BW 301.A45 heat pump data"
  extends IDEAS.Fluid.Production.BaseClasses.PartialNonModulatingRecord(
    m1=12.7,
    m2=12.7,
    m1_flow_nominal=1.8,
    m2_flow_nominal=1,
    dp1_nominal=20000,
    dp2_nominal=6000,
    QNomRef=45000,
    TMin=273.15 - 5,
    TMax=273.15 + 60,
    copData=true,
    heat={
      {0,      268.15, 273.15, 275.15, 283.15, 288.15, 293.15, 298.15},
      {308.15, 3.9,    4.6,    4.78,   5.5,    6.49,   6.98,   7.40},
      {318.15, 3.09,   3.52,   3.7,    4.44,   5.02,   5.65,   6.33},
      {328.15, 2.76,   2.76,   2.81,   3.4,    3.86,   4.36,   4.81},
      {333.15, 2.46,   2.46,   2.46,   2.94,   3.36,   3.81,   4.26}},
    power={
      {0,      268.15, 273.15, 275.15, 283.15, 288.15, 298.15},
      {308.15, 9670,   9280,   9560,   10700,  10170,  10190},
      {318.15, 11640,  11800,  11810,  11850,  11850,  12000},
      {328.15, 14380,  14380,  14310,  14330,  14230,  14194},
      {333.15, 15790,  15790,  15790,  15750,  15690,  15484}});
  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA45;

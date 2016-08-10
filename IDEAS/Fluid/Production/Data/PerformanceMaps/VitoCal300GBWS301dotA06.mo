within IDEAS.Fluid.Production.Data.PerformanceMaps;
record VitoCal300GBWS301dotA06
  "Viessmann Vitocal 300-G, type BW/BWS/BWC 301.A06 heat pump data"
   extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=820/3600,
    m2_flow_nominal=520/3600,
    dp1_nominal=64000,
    dp2_nominal=63000,
    TEvaMin=273.15-5,
    TEvaMax=273.15+25,
    TConMax=273.15+60,
    indicesDim1={308.15, 318.15, 328.15, 333.15},
    indicesDim2={268.15,273.15,275.15,283.15,288.15,298.15},
    indicesDim3={0},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.P,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_outCon,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType3=IDEAS.Fluid.Production.BaseClasses.InputType.None,
    table1_a={{3.69, 4.3, 4.56, 5.59, 6.39},
              {2.79, 3.27, 3.47, 4.28, 4.84},
              {0, 2.48, 2.63, 3.26, 3.66},
              {0,0,2.28, 2.82, 3.19}},
    table1_b={{1350, 1340, 1330, 1300, 1300},
              {1720, 1680, 1680, 1660, 1650},
              {0, 2130, 2120, 2080, 2070},
              {0,0, 2370, 2310, 2290}});
  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA06;

within IDEAS.Fluid.Production.Data.PerformanceMaps;
record VitoCal300GBWS301dotA29
  "Viessmann Vitocal 300-G, type BW 301.A29 heat pump data"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=4200/3600,
    m2_flow_nominal=2550/3600,
    dp1_nominal=12000,
    dp2_nominal=4800,
    TEvaMin=273.15-5,
    TConMax=273.15+60,
    indicesDim1={308.15, 318.15, 328.15, 333.15},
    indicesDim2={263.15, 268.15,273.15,275.15,283.15,288.15,298.15},
    indicesDim3={0},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.P,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_outCon,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType3=IDEAS.Fluid.Production.BaseClasses.InputType.None,
    table1_a={{3.57,3.7,4.83,5.06,6,7.01,7.42,7.76},
              {2.67,3.13,3.6,3.82,4.69,5.36,5.97,6.62},
              {0,0,2.68,2.86,3.59,4.06,4.50,4.94},
              {0,0,0,2.34,3.11,3.54,3.89,4.26}},
    table1_b={{6460,6970,5960,6010,6200,6310,6864},
              {7965,7850,7790,7780,7730,7690,7627},
              {0,0,9750,9700,9500,9380,9237},
              {0,0,0,8600,10300,10390,10169}});

  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA29;

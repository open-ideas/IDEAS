within IDEAS.Fluid.Production.Data.PerformanceMaps;
record VitoCal300GBWS301dotA45_3D
  "Viessmann Vitocal 300-G, type BW 301.A45 heat pump data"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=1.8,
    m2_flow_nominal=1,
    dp1_nominal=20000,
    dp2_nominal=6000,
    nDim1=4,
    nDim2=6,
    nDim3=1,
    indicesDim1={308.15, 318.15, 328.15, 333.15},
    indicesDim2={268.15,273.15,275.15,283.15,288.15,298.15},
    indicesDim3={0},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.P,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_outCon,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType3=IDEAS.Fluid.Production.BaseClasses.InputType.None,
    table1_a={{3.9,4.6,4.78,5.5,6.49,7.40},
              {3.09,3.52,3.7,4.44,5.02,6.33},
              {0,2.76,2.81,3.4,3.86,4.81},
              {0,0,2.46,2.94,3.36,4.26}},
    table1_b={{9670,9280, 9560,10700,10170,10190},
               {11640,11800,11810,11850,11850,12000},
               {0,14380,14310,14330,14230,14194},
               {0,0,15790,15750,15690,15484}});
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 2016 by Filip Jorissen:
<br/> 
First implementation.
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA45_3D;

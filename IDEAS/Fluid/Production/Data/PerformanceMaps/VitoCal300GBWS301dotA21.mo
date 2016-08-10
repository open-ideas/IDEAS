within IDEAS.Fluid.Production.Data.PerformanceMaps;
record VitoCal300GBWS301dotA21
  "Viessmann Vitocal 300-G, type BW 301.A21 heat pump data"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=3300/3600,
    m2_flow_nominal=1900/3600,
    dp1_nominal=7000,
    dp2_nominal=3800,
    TEvaMin=273.15-5,
    TConMax=273.15+60,
    indicesDim1={308.15, 318.15, 328.15, 333.15},
    indicesDim2={268.15,273.15,275.15,283.15,288.15},
    indicesDim3={0},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.P,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_outCon,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType3=IDEAS.Fluid.Production.BaseClasses.InputType.None,
    table1_a={{4.15,4.73, 4.97, 5.94, 7.05},
              {3.19, 3.65, 3.88, 4.77, 5.44},
              {1, 2.83, 2.99, 3.66, 4.15},
              {0, 0, 2.61, 3.21, 3.64}},
    table1_b={{4520, 4480, 4530, 4730, 4570},
              {5550, 5580, 5580, 5580, 5550},
              {0, 6820, 6820, 6800, 6830},
              {0,0,7520, 7500, 7520}});

  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA21;

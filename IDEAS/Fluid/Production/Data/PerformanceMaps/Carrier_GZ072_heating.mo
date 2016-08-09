within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Carrier_GZ072_heating
  "Carrier GZ072 geothermal water-air heat pump in heating mode"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=1.13,
    m2_flow_nominal=1.1,
    dp1_nominal=22000,
    dp2_nominal=100,
    indicesDim1 = {272.04, 277.59, 283.15, 288.71, 294.26, 299.82},
    indicesDim2 = {288.71, 294.26, 299.82},
    indicesDim3 = {0.57, 0.76, 1.13},
    table1_a = { {3.20, 3.50, 3.90, 4.20, 4.50, 4.80},  {2.90, 3.20, 3.60, 3.80, 4.20, 4.40},  {2.60, 2.90, 3.20, 3.50, 3.70, 4.10}},
    table1_b = { {14800.09, 16792.97, 19489.23, 21921.72, 24295.59, 26933.23},  {14800.09, 16558.52, 19430.61, 21540.72, 24588.66, 27138.38},  {14536.33, 16411.98, 19342.69, 21452.80, 24061.13, 26816.00}},
    table2_a = { {3.30, 3.60, 4.00, 4.30, 4.70, 5.00},  {2.90, 3.20, 3.60, 4.00, 4.30, 4.50},  {2.70, 3.00, 3.30, 3.60, 3.90, 4.10}},
    table2_b = { {15415.54, 17467.04, 20163.29, 22654.39, 26024.71, 28662.35},  {15063.85, 17173.96, 20046.06, 22654.39, 25409.26, 28134.82},  {15034.55, 17232.58, 19430.61, 22185.48, 24940.35, 27695.22}},
    table3_a = { {3.40, 3.70, 3.90, 4.40, 4.60, 5.10},  {3.00, 3.30, 3.70, 4.00, 4.30, 4.60},  {2.80, 3.00, 3.40, 3.60, 3.90, 4.20}},
    table3_b = { {15913.76, 18170.41, 19401.30, 23621.53, 24676.58, 29805.33},  {15767.22, 17789.41, 20544.28, 22976.77, 26083.33, 29014.04},  {15679.30, 17496.34, 20309.83, 22713.01, 25321.34, 28222.74}},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.QCon,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inCon,
    inputType3=IDEAS.Fluid.Production.BaseClasses.InputType.m_flowEva);

  annotation (Documentation(revisions="<html>
<ul>
<li>
August 2016 by Filip Jorissen:
<br/> 
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Data source: http://www.utcccs-cdn.com/hvac/docs/1009/Public/00/GZ-02PD.pdf
</p>
</html>"));
end Carrier_GZ072_heating;

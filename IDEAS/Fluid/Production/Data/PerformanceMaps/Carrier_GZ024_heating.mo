within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Carrier_GZ024_heating
  "Carrier GZ024 geothermal water-air heat pump in heating mode"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=0.38,
    m2_flow_nominal=0.48,
    dp1_nominal=17900,
    dp2_nominal=100,
    indicesDim1 = {272.04, 277.59, 283.15, 288.71, 294.26, 299.82},
    indicesDim2 = {288.71, 294.26, 299.82},
    indicesDim3 = {0.19, 0.25, 0.38},
    table1_a = { {3.70, 4.10, 4.50, 4.90, 5.30, 5.70},  {3.30, 3.60, 4.10, 4.40, 4.80, 5.10},  {3.00, 3.20, 3.70, 4.00, 4.30, 4.60}},
    table1_b = { {5216.67, 5832.11, 6799.25, 7649.15, 8528.37, 9436.89},  {5070.13, 5744.19, 6652.71, 7502.62, 8352.53, 9261.05},  {5040.82, 5597.66, 6594.10, 7385.39, 8176.68, 9114.51}},
    table2_a = { {3.90, 4.20, 4.70, 5.10, 5.50, 5.90},  {3.40, 3.80, 4.20, 4.60, 4.90, 5.30},  {3.10, 3.30, 3.80, 4.10, 4.40, 4.80}},
    table2_b = { {5421.81, 6125.19, 7150.93, 8059.45, 9055.90, 10023.03},  {5275.28, 6007.96, 6975.09, 7854.30, 8821.44, 9788.57},  {5216.67, 5861.42, 6887.17, 7707.77, 8616.29, 9554.12}},
    table3_a = { {4.00, 4.40, 4.90, 5.30, 5.80, 6.20},  {3.50, 3.90, 4.40, 4.80, 5.20, 5.60},  {3.10, 3.50, 3.90, 4.30, 4.60, 5.00}},
    table3_b = { {5714.89, 6506.18, 7561.23, 8557.68, 9612.73, 10697.09},  {5539.04, 6359.64, 7385.39, 8352.53, 9378.27, 10433.33},  {5392.51, 6154.49, 7238.86, 8118.07, 9143.82, 10198.87}},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.QCon,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_outCon,
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
end Carrier_GZ024_heating;

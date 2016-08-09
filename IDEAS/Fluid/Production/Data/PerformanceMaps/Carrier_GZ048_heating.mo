within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Carrier_GZ048_heating
  "Carrier GZ048 geothermal water-air heat pump in heating mode"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=0.76,
    m2_flow_nominal=0.85,
    dp1_nominal=27600,
    dp2_nominal=100,
    indicesDim1 = {272.04, 277.59, 283.15, 288.71, 294.26, 299.82},
    indicesDim2 = {288.71, 294.26, 299.82},
    indicesDim3 = {0.38, 0.50, 0.76},
    table1_a = { {3.50, 3.80, 4.20, 4.60, 4.90, 5.30},  {3.10, 3.40, 3.80, 4.10, 4.40, 4.70},  {2.80, 3.10, 3.40, 3.70, 4.00, 4.30}},
    table1_b = { {10521.25, 11840.07, 13832.95, 15591.38, 17437.73, 19342.69},  {10374.72, 11752.15, 13598.50, 15298.31, 17086.04, 18932.39},  {10257.49, 11634.92, 13422.66, 15063.85, 16822.28, 18580.71}},
    table2_a = { {3.60, 3.90, 4.30, 4.70, 5.10, 5.40},  {3.20, 3.50, 3.90, 4.20, 4.60, 4.90},  {2.90, 3.20, 3.50, 3.80, 4.10, 4.40}},
    table2_b = { {10931.55, 12426.21, 14477.71, 16324.06, 18287.63, 20280.52},  {10726.40, 12221.06, 14155.33, 15972.37, 17877.34, 19840.91},  {10638.48, 12074.53, 13950.18, 15679.30, 17525.65, 19372.00}},
    table3_a = { {3.70, 4.00, 4.50, 4.90, 5.20, 5.60},  {3.30, 3.60, 4.00, 4.40, 4.70, 5.00},  {2.90, 3.30, 3.60, 3.90, 4.20, 4.50}},
    table3_b = { {11400.46, 13070.97, 15181.08, 17173.96, 19225.46, 21364.88},  {11166.01, 12777.90, 14829.40, 16734.36, 18756.55, 20808.05},  {11019.47, 12572.75, 14507.02, 16382.67, 18316.94, 20309.83}},
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
end Carrier_GZ048_heating;

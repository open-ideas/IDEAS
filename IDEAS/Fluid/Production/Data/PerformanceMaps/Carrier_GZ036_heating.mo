within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Carrier_GZ036_heating
  "Carrier GZ036 geothermal water-air heat pump in heating mode"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=0.57,
    m2_flow_nominal=0.71,
    dp1_nominal=16500,
    dp2_nominal=100,
    indicesDim1 = {288.71, 294.26, 299.82},
    indicesDim2 = {272.04, 277.59, 283.15, 288.71, 294.26, 299.82},
    indicesDim3 = {0.28, 0.38, 0.57},
    table1_a = { {3.60, 3.90, 4.30, 4.70, 5.10, 5.40},  {3.20, 3.50, 3.90, 4.20, 4.60, 4.90},  {2.90, 3.10, 3.50, 3.80, 4.10, 4.40}},
    table1_b = { {8118.07, 9231.74, 10609.17, 11927.99, 13305.43, 14741.47},  {8030.15, 9085.20, 10404.02, 11693.54, 13041.66, 14477.71},  {7883.61, 8909.36, 10228.18, 11459.08, 12777.90, 14155.33}},
    table2_a = { {3.70, 4.00, 4.50, 4.80, 5.20, 5.60},  {3.30, 3.60, 4.00, 4.40, 4.70, 5.00},  {2.90, 3.20, 3.60, 3.90, 4.20, 4.60}},
    table2_b = { {8411.14, 9583.42, 11048.78, 12455.52, 13920.88, 15444.85},  {8293.91, 9436.89, 10814.32, 12191.76, 13598.50, 15093.16},  {8118.07, 9290.35, 10579.87, 11957.30, 13305.43, 14800.09}},
    table3_a = { {3.80, 4.10, 4.60, 5.00, 5.40, 5.70},  {3.40, 3.70, 4.10, 4.50, 4.90, 5.20},  {3.00, 3.30, 3.70, 4.00, 4.40, 4.70}},
    table3_b = { {8733.52, 9993.72, 11547.00, 13041.66, 14624.25, 16206.83},  {8586.98, 9788.57, 11253.93, 12689.98, 14213.95, 15825.84},  {8440.45, 9612.73, 11048.78, 12426.21, 13920.88, 15444.85}},
    outputType1=IDEAS.Fluid.Production.BaseClasses.OutputType.COP,
    outputType2=IDEAS.Fluid.Production.BaseClasses.OutputType.QCon,
    inputType1=IDEAS.Fluid.Production.BaseClasses.InputType.T_inCon,
    inputType2=IDEAS.Fluid.Production.BaseClasses.InputType.T_inEva,
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
end Carrier_GZ036_heating;

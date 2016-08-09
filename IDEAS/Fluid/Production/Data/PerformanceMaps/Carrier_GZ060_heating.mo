within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Carrier_GZ060_heating
  "Carrier GZ060 geothermal water-air heat pump in heating mode"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpData3D(
    m1_flow_nominal=0.94,
    m2_flow_nominal=0.96,
    dp1_nominal=29000,
    dp2_nominal=100,
    indicesDim1 = {272.04, 277.59, 283.15, 288.71, 294.26, 299.82},
    indicesDim2 = {288.71, 294.26, 299.82},
    indicesDim3 = {0.47, 0.63, 0.94},
    table1_a = { {3.40, 3.70, 4.10, 4.40, 4.80, 5.10},  {3.10, 3.30, 3.70, 4.00, 4.30, 4.60},  {2.80, 3.00, 3.40, 3.70, 3.90, 4.20}},
    table1_b = { {12924.43, 14536.33, 16851.59, 18961.70, 21130.42, 23387.07},  {12777.90, 14419.10, 16646.44, 18668.63, 20808.05, 22976.77},  {12836.51, 14272.56, 16529.21, 18492.78, 20544.28, 22566.47}},
    table2_a = { {3.50, 3.80, 4.20, 4.60, 4.90, 5.20},  {3.10, 3.40, 3.80, 4.10, 4.40, 4.70},  {2.90, 3.10, 3.50, 3.70, 4.00, 4.30}},
    table2_b = { {13451.96, 15210.39, 17525.65, 19752.99, 22068.25, 24442.13},  {13217.51, 14946.62, 17320.50, 19430.61, 21657.95, 23973.21},  {13276.12, 14770.78, 17232.58, 19166.85, 21335.57, 23562.91}},
    table3_a = { {3.60, 3.90, 4.30, 4.70, 5.00, 5.30},  {3.20, 3.60, 3.90, 4.20, 4.50, 4.80},  {2.90, 3.20, 3.60, 3.80, 4.10, 4.40}},
    table3_b = { {14008.80, 15855.14, 18287.63, 20632.20, 23094.00, 25643.72},  {13715.73, 15650.00, 17965.26, 20251.21, 22595.78, 25086.88},  {13657.11, 15444.85, 17730.80, 19899.53, 22214.79, 24559.36}},
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
end Carrier_GZ060_heating;

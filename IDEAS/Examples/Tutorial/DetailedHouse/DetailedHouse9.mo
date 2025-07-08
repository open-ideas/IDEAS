within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse9 "Adding CO2-controlled ventilation"
  extends DetailedHouse7(
    pumSec(nominalValuesDefineDefaultPressureCurve=true),
    pumPri(nominalValuesDefineDefaultPressureCurve=true),
    recZon1(
      redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp),
    recZon(
      redeclare OccSched occNum(k=2),
      redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp),
    redeclare package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"}));

  IDEAS.Fluid.Actuators.Dampers.PressureIndependent vavSup(
    redeclare package Medium = MediumAir,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Supply VAV for first zone"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  IDEAS.Fluid.Actuators.Dampers.PressureIndependent vavSup1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Supply VAV for second zone"
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  IDEAS.Fluid.Actuators.Dampers.PressureIndependent vavRet(
    redeclare package Medium = MediumAir,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Return VAV for first zone"
    annotation (Placement(transformation(extent={{-100,20},{-120,40}})));
  IDEAS.Fluid.Actuators.Dampers.PressureIndependent vavRet1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Return VAV for second zone"
    annotation (Placement(transformation(extent={{-100,-60},{-120,-40}})));
  IDEAS.Fluid.Movers.FlowControlled_dp fanSup(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = MediumAir,
    dp_nominal=200,
    m_flow_nominal=vavSup.m_flow_nominal + vavSup1.m_flow_nominal) "Supply fan"
    annotation (Placement(transformation(extent={{-220,10},{-200,30}})));
  IDEAS.Fluid.Movers.FlowControlled_dp fanRet(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = MediumAir,
    dp_nominal=200,
    m_flow_nominal=vavRet.m_flow_nominal + vavRet1.m_flow_nominal) "Return fan"
    annotation (Placement(transformation(extent={{-200,-30},{-220,-10}})));
  IDEAS.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=fanSup.m_flow_nominal,
    m2_flow_nominal=fanRet.m_flow_nominal,
    dp1_nominal=100,
    dp2_nominal=100) "Heat exchanger with constant heat recovery effectivity"
    annotation (Placement(transformation(extent={{-250,-10},{-230,10}})));
  IDEAS.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.1,
    k=0.005,
    reverseActing=false,
    Ti=300) annotation (Placement(transformation(extent={{-40,80},{-60,100}})));
  IDEAS.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.1,
    k=0.005,
    reverseActing=false,
    Ti=300) annotation (Placement(transformation(extent={{-40,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant ppmSet(k=1000)
    annotation (Placement(transformation(extent={{40,80},{20,100}})));
  IDEAS.Fluid.Sources.OutsideAir outAir(
    redeclare package Medium = MediumAir,
    azi=0,
    nPorts=2) "Source model that takes properties from SimInfoManager"
    annotation (Placement(transformation(extent={{-280,10},{-260,-10}})));
protected
  model OccSched "Simple occupancy schedule"
    extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

    parameter Real k "Number of occupants";
    IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.RealExpression occ(y=if calTim.weekDay < 6 and (
          calTim.hour > 7 and calTim.hour < 18) then k else 0)
      "Number of occupants present"
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(occ.y, nOcc)
      annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
  end OccSched;

equation
  connect(vavSup.port_a, fanSup.port_b) annotation (Line(points={{-120,60},{-180,
          60},{-180,20},{-200,20}}, color={0,127,255}));
  connect(vavSup1.port_a, fanSup.port_b) annotation (Line(points={{-120,-10},{-180,
          -10},{-180,20},{-200,20}}, color={0,127,255}));
  connect(fanRet.port_a, vavRet1.port_b) annotation (Line(points={{-200,-20},{-160,
          -20},{-160,-50},{-120,-50}}, color={0,127,255}));
  connect(fanRet.port_a, vavRet.port_b) annotation (Line(points={{-200,-20},{-160,
          -20},{-160,30},{-120,30}}, color={0,127,255}));
  connect(hex.port_b1, fanSup.port_a) annotation (Line(points={{-230,6},{-230,20},
          {-220,20}}, color={0,127,255}));
  connect(hex.port_a2, fanRet.port_b) annotation (Line(points={{-230,-6},{-230,-20},
          {-220,-20}}, color={0,127,255}));
  connect(conPID.y, vavSup.y)
    annotation (Line(points={{-61,90},{-110,90},{-110,72}}, color={0,0,127}));
  connect(vavRet.y, vavSup.y)
    annotation (Line(points={{-110,42},{-110,72},{-110,72}}, color={0,0,127}));
  connect(vavRet1.y, vavSup1.y)
    annotation (Line(points={{-110,-38},{-110,2}}, color={0,0,127}));
  connect(vavSup1.y, conPID1.y)
    annotation (Line(points={{-110,2},{-110,10},{-61,10}}, color={0,0,127}));
  connect(recZon1.ppm, conPID1.u_m) annotation (Line(points={{11,-30},{14,-30},
          {14,-2},{-50,-2}}, color={0,0,127}));
  connect(recZon.ppm, conPID.u_m) annotation (Line(points={{11,30},{14,30},{14,78},{-50,78}}, color={0,0,127}));
  connect(ppmSet.y, conPID.u_s)
    annotation (Line(points={{19,90},{-38,90}}, color={0,0,127}));
  connect(ppmSet.y, conPID1.u_s) annotation (Line(points={{19,90},{-20,90},{-20,
          10},{-38,10}}, color={0,0,127}));
  connect(outAir.ports[1], hex.port_b2) annotation (Line(points={{-260,1},{-250,
          1},{-250,-6}}, color={0,127,255}));
  connect(outAir.ports[2], hex.port_a1) annotation (Line(points={{-260,-1},{-252,
          -1},{-252,6},{-250,6}}, color={0,127,255}));
  connect(vavSup.port_b, recZon.ports[1]) annotation (Line(points={{-100,60},{-2,60},{-2,40},{0,40}}, color={0,127,255}));
  connect(vavRet.port_a, recZon.ports[2]) annotation (Line(points={{-100,30},{-14,30},{-14,40},{0,40}}, color={0,127,255}));
  connect(vavSup1.port_b,recZon1.ports[1])
    annotation (Line(points={{-100,-10},{0,-10},{0,-20}}, color={0,127,255}));
  connect(vavRet1.port_a,recZon1.ports[2])  annotation (Line(points={{-100,-50},
          {-34,-50},{-34,-20},{0,-20}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-280,-100},{280,100}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse9.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Adding CO<sub>2</sub>-controlled ventilation system. The occupancy model
from <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4</a> is added to one zone and a 
fixed occupancy of 1 person to the other zone. The ventilation system
consists of two fans, two supply and two return air VAVs (Variable Air Volume), a heat recovery unit and an
outdoor air source. The control consists of PI controllers with a setpoint of <i>1000 ppm</i>.
</p>
<h4>Required models</h4>
<ul>
<li>
Custom occupant model from <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Sources.OutsideAir\">
IDEAS.Fluid.Sources.OutsideAir</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Actuators.Dampers.PressureIndependent\">
IDEAS.Fluid.Actuators.Dampers.PressureIndependent</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.ConstantEffectiveness\">
IDEAS.Fluid.HeatExchangers.ConstantEffectiveness</a>
</li>
<li>
<a href=\"modelica://IDEAS.Controls.Continuous.LimPID\">
IDEAS.Controls.Continuous.LimPID</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Sources.Constant\">
Modelica.Blocks.Sources.Constant</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
This model extends from <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse8\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse8</a> where its existing medium declaration is modified to add CO2.
For one zone, add the occupancy model from <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse4</a>. For the other zone, a fixed occupancy of 1 person is added. 
For making a connection with the outside air <a href=\"modelica://IDEAS.Fluid.Sources.OutsideAir\">
IDEAS.Fluid.Sources.OutsideAir</a> is used, which is similar to <a href=\"modelica://IDEAS.Fluid.Sources.Boundary_pT\">
IDEAS.Fluid.Sources.Boundary_pT</a> except that it automatically sets the outdoor dry bulb temperature and humidity.
</p>
<p>
For this exercise, assume that the VAV has a nominal flow rate of <i>100 m<sup>3</sup>/h</i>, which equals <i>0.033 kg/s</i>. A nominal pressure drop of <i>50 Pa</i>
is assumed and also <code>dpFixed_nominal=50</code>, which causes the VAV model to include a pressure drop of ducts, grills,
filters or bends that are connected at the inlet or outlet of the VAV. The fan pressure head is constant at <i>200 Pa</i> and its nominal flow
rate is the sum of the VAV flow rates. The heat recovery heat exchanger has a constant effectiveness of <i>80 %</i>. 
</p>
<p>
The model includes two PI controllers, with their outputs connected to the VAVs. The zone <code>ppm</code> 
outputs are connected to the measurement inputs <code>u_m</code> of the PI controllers, and a constant setpoint 
of <i>1000 ppm</i> is provided at the input <code>u_s</code>. The VAVs have a minimum opening of <i>10 %</i>. 
The PI controllers are configured with the following parameters: <code>k = 0.005</code>, <code>T_i = 300</code>, <code>reverseAction=false</code>, 
and <code>controllerType=PI</code>. The schematic representation of the model is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"The schematic of Example 9.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse9_schematic.png\" width=\"700\"/>
</p>
<h4>Reference result</h4>
<p>
The figures below show the operative zone temperature, CO<sub>2</sub> concentrations and PI control signals in both zones.
Note the small overshoot of the PI controller outputs and the exponential decay towards the outdoor CO<sub>2</sub>
concentration when there are no occupants.
</p>
<p align=\"center\">
<img alt=\"The schematic of Example 9.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse9.png\" width=\"700\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
April 14, 2025, by Anna Dell'Isola and Lone Meertens:<br/>
Update and restructure IDEAS tutorial models.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1374\">#1374</a> 
and <a href=\"https://github.com/open-ideas/IDEAS/issues/1389\">#1389</a>.
</li>
<li>
November 21, 2020 by Filip Jorissen:<br/>
Avoiding warnings for default pressure curves and due to using port_a and port_b.
</li>
<li>
September 21, 2019 by Filip Jorissen:<br/>
Using OutsideAir.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1052\">#1052</a>.
</li>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"));
end DetailedHouse9;

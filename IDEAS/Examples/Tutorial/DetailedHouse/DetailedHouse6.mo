within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse6
  "Extension of DetailedHouse5 that adds a heating system"
  extends DetailedHouse5;
  package MediumWater = IDEAS.Media.Water "Water Medium";

  IDEAS.Fluid.HeatPumps.ScrollWaterToWater heaPum(
    m2_flow_nominal=pumPri.m_flow_nominal,
    enable_variable_speed=false,
    m1_flow_nominal=pumEmi.m_flow_nominal,
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    datHeaPum=
        IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A(),
    scaling_factor=0.025,
    dp1_nominal=10000,
    dp2_nominal=10000)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={190,10})));

  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=500,
    T_a_nominal=318.15,
    T_b_nominal=308.15) "Radiator for zone 1" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-10})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad1(
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=500,
    T_a_nominal=318.15,
    T_b_nominal=308.15) "Radiator for zone 2" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-10})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV val(
    m_flow_nominal=rad.m_flow_nominal,
    dpValve_nominal=20000,
    redeclare package Medium = MediumWater) "Thermostatic valve for first zone"
                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Movers.FlowControlled_dp pumEmi(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal=20000,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    m_flow_nominal=rad.m_flow_nominal + rad1.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Circulation pump of the heat emission (radiator) side of the circuit"
    annotation (Placement(transformation(extent={{120,50},{100,70}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=2,
    redeclare package Medium = MediumWater,
    T=283.15) "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={270,10})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV val1(
    dpValve_nominal=20000,
    m_flow_nominal=rad1.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for second zone"
                                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  IDEAS.Fluid.Movers.FlowControlled_dp pumPri(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=10000,
    m_flow_nominal=rad.m_flow_nominal + rad1.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Circulation pump at the primary (evaporator) side of the heat pump"
    annotation (Placement(transformation(extent={{240,50},{220,70}})));
  Modelica.Blocks.Sources.IntegerConstant heaPumOn(k=1) "Heat pump is on"
    annotation (Placement(transformation(extent={{160,-62},{180,-42}})));
  Modelica.Blocks.Continuous.Integrator EEl(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{260,40},{280,60}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
        MediumWater, m_flow_nominal=pumEmi.m_flow_nominal)
    "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{146,70},{126,50}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = MediumWater)
              "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={110,90})));
  IDEAS.Fluid.Storage.Stratified tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pumEmi.m_flow_nominal,
    VTan=0.1,
    hTan=0.5,
    dIns=0.1) "Buffer tank for avoiding excessive heat pump on/off switches"
    annotation (Placement(transformation(extent={{146,0},{166,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTan
    "Temperature sensor of tank volume"
    annotation (Placement(transformation(extent={{138,2},{122,18}})));
  IDEAS.Fluid.Movers.FlowControlled_dp pumSec(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal=20000,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    m_flow_nominal=pumEmi.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Circulation pump at the secondary (condenser) side of the heat pump"
    annotation (Placement(transformation(extent={{180,50},{160,70}})));
equation
  connect(val.port_b, rad.port_a)
    annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
  connect(val1.port_b, rad1.port_a)
    annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
  connect(val.port_a,pumEmi. port_b)
    annotation (Line(points={{50,40},{50,60},{100,60}}, color={0,127,255}));
  connect(val1.port_a,pumEmi. port_b)
    annotation (Line(points={{90,40},{90,60},{100,60}}, color={0,127,255}));
  connect(heaPum.port_a2, pumPri.port_b)
    annotation (Line(points={{196,20},{196,60},{220,60}}, color={0,127,255}));
  connect(heaPum.port_b2, bou.ports[1]) annotation (Line(points={{196,0},{196,
          -30},{248,-30},{248,11},{260,11}},      color={0,127,255}));
  connect(pumPri.port_a, bou.ports[2]) annotation (Line(points={{240,60},{248,60},
          {248,9},{260,9}}, color={0,127,255}));
  connect(rad.heatPortCon, recZon.gainCon) annotation (Line(points={{42.8,-8},{20,-8},{20,27},{10,27}}, color={191,0,0}));
  connect(rad.heatPortRad, recZon.gainRad) annotation (Line(points={{42.8,-12},{16,-12},{16,24},{10,24}}, color={191,0,0}));
  connect(rad1.heatPortCon,recZon1.gainCon)  annotation (Line(points={{82.8,-8},
          {66,-8},{66,-33},{10,-33}}, color={191,0,0}));
  connect(rad1.heatPortRad,recZon1.gainRad)  annotation (Line(points={{82.8,-12},
          {70,-12},{70,-36},{10,-36}}, color={191,0,0}));
  connect(heaPumOn.y, heaPum.stage) annotation (Line(points={{181,-52},{187,-52},
          {187,-2}}, color={255,127,0}));
  connect(heaPum.P, EEl.u)
    annotation (Line(points={{190,21},{190,50},{258,50}}, color={0,0,127}));
  connect(recZon.TSensor, val.T) annotation (Line(points={{11,32},{26,32},{26,30},{39.4,30}}, color={0,0,127}));
  connect(recZon1.TSensor, val1.T) annotation (Line(points={{11,-28},{32,-28},{32,
          12},{79.4,12},{79.4,30}}, color={0,0,127}));
  connect(bou1.ports[1],pumEmi. port_b)
    annotation (Line(points={{110,80},{100,80},{100,60}}, color={0,127,255}));
  connect(senTemSup.port_b,pumEmi. port_a)
    annotation (Line(points={{126,60},{120,60}}, color={0,127,255}));
  connect(heaPum.port_a1, tan.port_b) annotation (Line(points={{184,0},{184,-32},
          {156,-32},{156,0}}, color={0,127,255}));
  connect(tan.heaPorVol[1], senTan.port)
    annotation (Line(points={{156,10},{138,10}},        color={191,0,0}));
  connect(heaPum.port_b1, pumSec.port_a)
    annotation (Line(points={{184,20},{184,60},{180,60}}, color={0,127,255}));
  connect(pumSec.port_b, tan.port_a)
    annotation (Line(points={{160,60},{156,60},{156,20}}, color={0,127,255}));
  connect(senTemSup.port_a, tan.fluPorVol[1])
    annotation (Line(points={{146,60},{150,60},{150,10},{151,10}},
                                                          color={0,127,255}));
  connect(rad1.port_b, tan.fluPorVol[2]) annotation (Line(points={{90,-20},{90,-32},
          {150,-32},{150,10},{151,10}},      color={0,127,255}));
  connect(rad.port_b, tan.fluPorVol[2]) annotation (Line(points={{50,-20},{50,-32},
          {150,-32},{150,10},{151,10}},      color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{280,100}},
          initialScale=0.1), graphics={Text(
          extent={{138,98},{224,90}},
          lineColor={28,108,200},
          textString="This sets the absolute pressure only"), Line(points={{126,
              86},{134,92}}, color={28,108,200})}), Icon(coordinateSystem(
          extent={{-100,-100},{100,100}}, initialScale=0.1)),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse6.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This model extends <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse5\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse5</a> by adding an HVAC system.
The system consists of a water-water heat pump, radiators, a storage tank, circulation
pumps and a heat source at a constant temperature of <i>10°C</i> for the heat pump. The model includes constant 
control setpoints for the heat pump and pumps. An integrator block is incorporated to measure 
the electrical energy consumption of the heat pump.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.Fluid.HeatPumps.ScrollWaterToWater\">
IDEAS.Fluid.HeatPumps.ScrollWaterToWater</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2\">
IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Actuators.Valves.TwoWayTRV\">
IDEAS.Fluid.Actuators.Valves.TwoWayTRV</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Movers.FlowControlled_dp\">
IDEAS.Fluid.Movers.FlowControlled_dp</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Sources.Boundary_pT\">
IDEAS.Fluid.Sources.Boundary_pT</a>
</li>
<li>
<a href=\"modelica://IDEAS.Fluid.Storage.Stratified\">
IDEAS.Fluid.Storage.Stratified</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">
Modelica.Blocks.Sources.IntegerConstant</a>
</li>
<li>
<a href=\"modelica://Modelica.Blocks.Continuous.Integrator\">
Modelica.Blocks.Continuous.Integrator</a>
</li>
</ul>
<p>
Most models include a parameter <code>energyDynamics</code>, which determines
how the energy balance equations are solved. In this example, it should be set to 
<i>FixedInitial</i>. This setting allows to define specific initial conditions,
which are by default the values of the <code>Medium</code> model. 
</p>
<h4>Connection instructions</h4>
<p>
A reference implementation for this example is shown in the figure below. 
</p>
<p align=\"center\">
<img alt=\" The schematic of Example 6.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse6_schematic.png\" width=\"700\"/>
</p>
<p>
One notable example is that in each fluid loop the <i>absolute</i> pressure of that loop has to be
defined somewhere: pumps and valves only provide information about <i>differential</i> pressures. For this purpose
use <a href=\"modelica://IDEAS.Fluid.Sources.Boundary_pT\"> IDEAS.Fluid.Sources.Boundary_pT</a> and connect it to the loop, 
which will set the absolute pressure at the connection point.
</p>
<h4>Reference result</h4>
<p>
The figures below show the operative zone temperatures <code>recZon.TSensor</code> and <code>recZon1.TSensor</code>, 
the radiator heat flow rates <code>rad.Q_flow</code> and <code>rad1.Q_flow</code>, the heat pump condenser temperature
<code>heaPum.con.T</code> and the heat pump heat flow rate <code>heaPum.QCon_flow</code>.
</p>
<p align=\"center\">
<img alt=\" The schematic of Example 6.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse6.png\" width=\"700\"/>
</p>
<p>
<p align=\"center\">
<img alt=\" The schematic of Example 6.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse6_bis.png\" width=\"700\"/>
</p>
<p>
This example illustrates the importance of control, which is currently not modelled. All pumps and the heat
pump are assumed to be active continuously, which is detrimental for the system performance. The COP
(heaPum.com.COP) is only about <i>2.5</i>.
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
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"));
end DetailedHouse6;

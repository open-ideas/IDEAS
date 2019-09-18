within IDEAS.Examples.Tutorial;
model Example6 "Extension of example 5 that adds a heating system"
  extends Example5;
  package MediumWater = IDEAS.Media.Water "Water Medium";

  Fluid.HeatPumps.ScrollWaterToWater heaPum(
    m2_flow_nominal=pumpPrim.m_flow_nominal,
    enable_variable_speed=false,
    m1_flow_nominal=pumpSec.m_flow_nominal,
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    datHeaPum=
        Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A(),

    scaling_factor=0.025,
    dp1_nominal=10000,
    dp2_nominal=10000) "Heat pump model, rescaled for low thermal powers"
                                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={170,10})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumWater,
    Q_flow_nominal=500,
    T_a_nominal=318.15,
    T_b_nominal=308.15) "Radiator for zone 1" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-10})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad1(
    redeclare package Medium = MediumWater,
    Q_flow_nominal=500,
    T_a_nominal=318.15,
    T_b_nominal=308.15) "Radiator for zone 2" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-10})));
  Fluid.Actuators.Valves.TwoWayTRV val(
    m_flow_nominal=rad.m_flow_nominal,
    dpValve_nominal=20000,
    redeclare package Medium = MediumWater) "Thermostatic valve for first zone"
                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  Fluid.Movers.FlowControlled_dp pumpSec(
    dp_nominal=20000,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    m_flow_nominal=rad.m_flow_nominal + rad1.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Circulation pump at secondary side"
    annotation (Placement(transformation(extent={{130,50},{110,70}})));
  Fluid.Sources.Boundary_pT bou(
    nPorts=3,
    redeclare package Medium = MediumWater,
    T=283.15) "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={250,10})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem
    "Temperature sensor for zone air temperature" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={34,6})));
  Fluid.Actuators.Valves.TwoWayTRV val1(
    dpValve_nominal=20000,
    m_flow_nominal=rad1.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for second zone"
                                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem1
    "Temperature sensor for zone air temperature" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={72,6})));
  Fluid.Movers.FlowControlled_dp pumpPrim(
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=10000,
    m_flow_nominal=rad.m_flow_nominal + rad1.m_flow_nominal,
    redeclare package Medium = MediumWater) "Circulation pump at primary side"
    annotation (Placement(transformation(extent={{220,50},{200,70}})));
  Modelica.Blocks.Sources.IntegerConstant HPOn(k=1) "Heat pump is on"
    annotation (Placement(transformation(extent={{140,-62},{160,-42}})));
  Modelica.Blocks.Continuous.Integrator EEl(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{260,40},{280,60}})));
equation
  connect(val.port_b, rad.port_a)
    annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
  connect(val1.port_b, rad1.port_a)
    annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
  connect(rad.heatPortCon, senTem.port)
    annotation (Line(points={{42.8,-8},{34,-8},{34,0}}, color={191,0,0}));
  connect(senTem.T, val.T)
    annotation (Line(points={{34,12},{34,30},{39.4,30}}, color={0,0,127}));
  connect(senTem1.T, val1.T)
    annotation (Line(points={{72,12},{72,30},{79.4,30}}, color={0,0,127}));
  connect(rad1.heatPortCon, senTem1.port)
    annotation (Line(points={{82.8,-8},{72,-8},{72,0}}, color={191,0,0}));
  connect(val.port_a, pumpSec.port_b)
    annotation (Line(points={{50,40},{50,60},{110,60}}, color={0,127,255}));
  connect(val1.port_a, pumpSec.port_b)
    annotation (Line(points={{90,40},{90,60},{110,60}}, color={0,127,255}));
  connect(rad1.port_b, heaPum.port_a1) annotation (Line(points={{90,-20},{90,-30},
          {164,-30},{164,0}}, color={0,127,255}));
  connect(rad.port_b, heaPum.port_a1) annotation (Line(points={{50,-20},{50,-30},
          {164,-30},{164,0}}, color={0,127,255}));
  connect(pumpSec.port_a, heaPum.port_b1)
    annotation (Line(points={{130,60},{164,60},{164,20}}, color={0,127,255}));
  connect(heaPum.port_a2, pumpPrim.port_b)
    annotation (Line(points={{176,20},{176,60},{200,60}}, color={0,127,255}));
  connect(heaPum.port_b2, bou.ports[1]) annotation (Line(points={{176,0},{176,-30},
          {228,-30},{228,7.33333},{240,7.33333}}, color={0,127,255}));
  connect(pumpPrim.port_a, bou.ports[2]) annotation (Line(points={{220,60},{228,
          60},{228,10},{240,10}}, color={0,127,255}));
  connect(rad.heatPortCon, rectangularZoneTemplate.gainCon) annotation (Line(
        points={{42.8,-8},{20,-8},{20,27},{10,27}}, color={191,0,0}));
  connect(rad.heatPortRad, rectangularZoneTemplate.gainRad) annotation (Line(
        points={{42.8,-12},{16,-12},{16,24},{10,24}}, color={191,0,0}));
  connect(rad1.heatPortCon, rectangularZoneTemplate1.gainCon) annotation (Line(
        points={{82.8,-8},{66,-8},{66,-33},{10,-33}}, color={191,0,0}));
  connect(rad1.heatPortRad, rectangularZoneTemplate1.gainRad) annotation (Line(
        points={{82.8,-12},{70,-12},{70,-36},{10,-36}}, color={191,0,0}));
  connect(heaPum.port_b1, bou.ports[3]) annotation (Line(points={{164,20},{166,
          20},{166,86},{240,86},{240,12.6667}},
                                            color={0,127,255}));
  connect(HPOn.y, heaPum.stage) annotation (Line(points={{161,-52},{167,-52},{167,
          -2}}, color={255,127,0}));
  connect(heaPum.P, EEl.u)
    annotation (Line(points={{170,21},{170,50},{258,50}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{280,100}},
          initialScale=0.1), graphics={Text(
          extent={{130,100},{216,92}},
          lineColor={28,108,200},
          textString="This sets the absolute pressure only"), Line(points={{156,
              92},{164,86}}, color={28,108,200})}), Icon(coordinateSystem(
          extent={{-100,-100},{280,100}}, initialScale=0.1)),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example6.mos"
        "Simulate and plot"));
end Example6;

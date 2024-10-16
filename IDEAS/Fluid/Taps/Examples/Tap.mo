within IDEAS.Fluid.Taps.Examples;
model Tap "Example with two 'Tap' models"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  Modelica.Blocks.Sources.Pulse m_flow_set1(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=5000,
    offset=0)
    "DHW demand (mass flow rate) for tap 1"
     annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Sources.Ramp step(
    startTime=86400,
    height=-30,
    duration=50000,
    offset=273.15 + 70)
    "Hot water supply temperature"
    annotation (Placement(transformation(extent={{-90,-14},{-70,6}})));
  IDEAS.Fluid.Taps.Tap tap1(redeclare package Medium = Medium) "DHW tap 1"
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  IDEAS.Fluid.Taps.Tap tap2(redeclare package Medium = Medium) "DHW tap 2"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium, use_T_in=true,
    nPorts=2)
    "Fluid source"
    annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Medium,
      nPorts=2)
    "Fluid sink"
    annotation (Placement(transformation(extent={{60,10},{40,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_set2(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=2500,
    offset=0)
    "DHW demand (mass flow rate) for tap 2"
     annotation (Placement(transformation(extent={{-60,-70},{-40,
            -50}})));
  Modelica.Blocks.Sources.RealExpression DHWDisCom1_K(y=if tap1.mFloHot.y > 0
         and (tap1.TSet - tap1.THot.T) > 0 then (tap1.TSet - tap1.THot.T) else
        0) "Instantaneous DHW discomfort in [K] for tap1"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Continuous.Integrator DHWDisCom1_Kh
    "Total DHW discomfort in [K.s] for tap1"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation

  connect(step.y, bou1.T_in)
    annotation (Line(points={{-69,-4},{-62,-4}}, color={0,0,127}));
  connect(m_flow_set1.y,tap1.mFloSet)
    annotation (Line(points={{-9,60},{0,60},{0,30}},   color={0,0,127}));
  connect(m_flow_set2.y,tap2.mFloSet)
    annotation (Line(points={{-39,-60},{-20,-60},{-20,-4},{0,-4},{0,-10}},
                                                          color={0,0,127}));
  connect(tap1.port_b, bou2.ports[1]) annotation (Line(points={{10,20},{30,20},
          {30,1},{40,1}}, color={0,127,255}));
  connect(tap2.port_b, bou2.ports[2]) annotation (Line(points={{10,-20},{30,-20},
          {30,-1},{40,-1}}, color={0,127,255}));
  connect(tap1.port_a, bou1.ports[1]) annotation (Line(points={{-10,20},{-30,20},
          {-30,1},{-40,1}}, color={0,127,255}));
  connect(tap2.port_a, bou1.ports[2]) annotation (Line(points={{-10,-20},{-30,
          -20},{-30,-1},{-40,-1}}, color={0,127,255}));
  connect(DHWDisCom1_K.y, DHWDisCom1_Kh.u)
    annotation (Line(points={{61,80},{68,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=259200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Taps/Examples/Tap.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>Initial implementation.
<br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> 
for more information. </li>
</ul>
</html>"));
end Tap;

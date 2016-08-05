within IDEAS.Fluid.Production.Examples;
model HeatPumpComparison
  extends Modelica.Icons.Example;
  BaseClasses.HeatPump3D hp3D(
    redeclare Data.PerformanceMaps.VitoCal300GBWS301dotA45_3D dat,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  HP_WaterWater_OnOff hp(
    use_onOffSignal=false,
    onOff=true,
    redeclare Data.PerformanceMaps.VitoCal300GBWS301dotA45 heatPumpData,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=4)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    m_flow=hp.m1_flow_nominal,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  replaceable package Medium = IDEAS.Media.Water;
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium,
    m_flow=hp.m1_flow_nominal,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Medium,
    nPorts=1,
    T=273.15 + 35,
    m_flow=hp.m2_flow_nominal)
    annotation (Placement(transformation(extent={{0,-22},{-20,-2}})));
  Sources.MassFlowSource_T boundary3(
    redeclare package Medium = Medium,
    nPorts=1,
    T=273.15 + 35,
    m_flow=hp.m2_flow_nominal)
    annotation (Placement(transformation(extent={{94,-20},{74,0}})));
equation
  connect(boundary.ports[1], hp.port_a1) annotation (Line(points={{-80,30},{-64,
          30},{-64,16},{-60,16}}, color={0,127,255}));
  connect(boundary1.ports[1], hp3D.port_a1) annotation (Line(points={{0,30},{18,
          30},{18,16},{40,16}}, color={0,127,255}));
  connect(hp.port_b1, bou.ports[1]) annotation (Line(points={{-40,16},{-30,16},{
          -30,73},{-40,73}}, color={0,127,255}));
  connect(hp3D.port_b1, bou.ports[2]) annotation (Line(points={{60,16},{62,16},{
          62,71},{-40,71}}, color={0,127,255}));
  connect(boundary2.ports[1], hp.port_a2) annotation (Line(points={{-20,-12},{-28,
          -12},{-28,-10},{-34,-10},{-34,4},{-40,4}}, color={0,127,255}));
  connect(hp.port_b2, bou.ports[3]) annotation (Line(points={{-60,4},{-70,4},{-70,
          40},{-40,40},{-40,69}}, color={0,127,255}));
  connect(boundary3.ports[1], hp3D.port_a2) annotation (Line(points={{74,-10},{66,
          -10},{66,4},{60,4}}, color={0,127,255}));
  connect(hp3D.port_b2, bou.ports[4]) annotation (Line(points={{40,4},{26,4},{26,
          67},{-40,67}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end HeatPumpComparison;

within IDEAS.Fluid.Production.Examples;
model HeatPumpComparison
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water(T_min=Modelica.SIunits.Conversions.from_degC(-15));
  HeatPump_OnOff         hp3D(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    redeclare Data.PerformanceMaps.VitoCal300GBWS301dotA45 dat)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=3)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

  Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=hp3D.m1_flow_nominal,
    T=283.15) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Sources.MassFlowSource_T boundary3(
    redeclare package Medium = Medium,
    nPorts=1,
    T=273.15 + 35,
    m_flow=hp3D.m2_flow_nominal)
    annotation (Placement(transformation(extent={{94,-20},{74,0}})));
equation
  connect(boundary1.ports[1], hp3D.port_a1) annotation (Line(points={{0,30},{18,
          30},{18,16},{40,16}}, color={0,127,255}));
  connect(hp3D.port_b1, bou.ports[1]) annotation (Line(points={{60,16},{62,16},
          {62,72.6667},{-40,72.6667}},
                            color={0,127,255}));
  connect(boundary3.ports[1], hp3D.port_a2) annotation (Line(points={{74,-10},{66,
          -10},{66,4},{60,4}}, color={0,127,255}));
  connect(hp3D.port_b2, bou.ports[3]) annotation (Line(points={{40,4},{26,4},{
          26,67.3333},{-40,67.3333}},
                         color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end HeatPumpComparison;

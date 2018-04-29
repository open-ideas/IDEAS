within IDEAS.Buildings.Components.BaseClasses;
model LeakageModel "Model for zone air leakage"
  replaceable package Medium = SolarwindBES.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.Area AFac(min=1) "Facade surface area for air leakage";

  IDEAS.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    final from_dp=true,
    dp_nominal=1,
    deltaM=0.01,
    m_flow_nominal=AFac*sim.k_facade) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Routing.RealPassThrough Te annotation (Placement(
    transformation(
    extent={{-10,-10},{10,10}},
    rotation=270,
    origin={6,70})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1,
    use_p_in=false,
    use_C_in=Medium.nC == 1,
    use_X_in=Medium.nX == 2,
    p=sim.pAbs) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,30})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThr annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,70})));
  Modelica.Fluid.Interfaces.FluidPort_a port_lea(redeclare package Medium =
        Medium) "Port for air leakage towards surroundings"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Sources.RealExpression reaExpX_air(y=1 - reaPasThr.y)
    annotation (Placement(transformation(extent={{58,42},{38,62}})));
protected
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus,
      outputAngles=sim.outputAngles)
    annotation (Placement(transformation(extent={{-50,82},{-30,102}})));

equation
  connect(Te.u,weaBus. Te) annotation (Line(points={{6,82},{6,92.05},{-39.95,
          92.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(reaExpX_air.y,bou. X_in[2])
    annotation (Line(points={{37,52},{14,52},{14,42}},  color={0,0,127}));
  connect(bou.C_in[1],weaBus. CEnv)
    annotation (Line(points={{18,42},{18,46},{62,46},{62,92},{10,92},{10,92.05},
          {-39.95,92.05}},                              color={0,0,127}));
  connect(reaPasThr.u,weaBus. X_wEnv)
    annotation (Line(points={{30,82},{30,92.05},{-39.95,92.05}},
                                                        color={0,0,127}));
  connect(reaPasThr.y,bou. X_in[1]) annotation (Line(points={{30,59},{14,59},{14,
          52},{14,42}}, color={0,0,127}));
  connect(Te.y,bou. T_in)
    annotation (Line(points={{6,59},{6,56},{6,42}},        color={0,0,127}));
  connect(sim.weaBus,weaBus)  annotation (Line(
      points={{-84,92.8},{-40,92.8},{-40,92}},
      color={255,204,51},
      thickness=0.5));
  connect(res.port_a, bou.ports[1])
    annotation (Line(points={{20,0},{10,0},{10,20}}, color={0,127,255}));
  connect(res.port_b, port_lea)
    annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LeakageModel;

within IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples;
model EmbeddedPipeNDiscrExample
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    redeclare
      IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_ValidationEmpa4_6
      RadSlaCha,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nDiscr=1,
    m_flow_nominal=ceiling.A*0.003,
    A_floor=ceiling.A,
    nParCir=1,
    m_flowMin=ceiling.A*0.003*0.3)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=1000,
    width=1000,
    falling=1000,
    period=5000,
    amplitude=embeddedPipe.m_flow_nominal)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zone(bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  IDEAS.Buildings.Components.InternalWall ceiling(
    azi=IDEAS.Types.Azimuth.S,
    redeclare IDEAS.Buildings.Data.Constructions.TABS constructionType,
    A=zone.w*zone.l,
    inc=IDEAS.Types.Tilt.Floor)
                     annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,70})));
  EmbeddedPipe                                        embeddedPipe1(
    redeclare package Medium = Medium,
    redeclare BaseClasses.FH_ValidationEmpa4_6 RadSlaCha,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=embeddedPipe.m_flow_nominal,
    A_floor=embeddedPipe.A_floor,
    nParCir=embeddedPipe.nParCir,
    m_flowMin=embeddedPipe.m_flowMin,
    nDiscr=4)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Sources.MassFlowSource_T             boundary1(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Sources.Boundary_pT             bou1(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    rising=1000,
    width=1000,
    falling=1000,
    period=5000,
    amplitude=embeddedPipe.m_flow_nominal)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Sensors.TemperatureTwoPort             senTem1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,-60},{46,-40}})));
  Buildings.Validation.Cases.Case900Template       zone1(bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Buildings.Components.InternalWall       ceiling1(
    azi=IDEAS.Types.Azimuth.S,
    redeclare Buildings.Data.Constructions.TABS constructionType,
    A=zone.w*zone.l,
    inc=IDEAS.Types.Tilt.Floor)
                     annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,-10})));
equation
  connect(boundary.ports[1], embeddedPipe.port_a) annotation (Line(
      points={{-40,30},{-10,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(trapezoid.y, boundary.m_flow_in) annotation (Line(
      points={{-79,30},{-70,30},{-70,38},{-62,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b, senTem.port_a) annotation (Line(
      points={{10,30},{26,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, bou.ports[1]) annotation (Line(
      points={{46,30},{60,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.heatPortEmb, ceiling.port_emb)
    annotation (Line(points={{0,40},{0,48},{40,48},{40,70}}, color={191,0,0}));
  connect(ceiling.propsBus_b, zone.proBusCei) annotation (Line(
      points={{28,75},{28,84},{-0.2,84},{-0.2,76}},
      color={255,204,51},
      thickness=0.5));
  connect(ceiling.propsBus_a, zone.proBusFlo) annotation (Line(
      points={{28,65},{28,54},{0,54},{0,64}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary1.ports[1], embeddedPipe1.port_a) annotation (Line(
      points={{-40,-50},{-10,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(trapezoid1.y, boundary1.m_flow_in) annotation (Line(
      points={{-79,-50},{-70,-50},{-70,-42},{-62,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(embeddedPipe1.port_b, senTem1.port_a) annotation (Line(
      points={{10,-50},{26,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
      points={{46,-50},{60,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ceiling1.propsBus_b, zone1.proBusCei) annotation (Line(
      points={{28,-5},{28,4},{-0.2,4},{-0.2,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(ceiling1.propsBus_a, zone1.proBusFlo) annotation (Line(
      points={{28,-15},{28,-26},{0,-26},{0,-16}},
      color={255,204,51},
      thickness=0.5));
  for i in 1:embeddedPipe1.nDiscr loop
    connect(embeddedPipe1.heatPortEmb[i], ceiling1.port_emb[1]) annotation (Line(points=
         {{0,-40},{0,-32},{40,-32},{40,-10}}, color={191,0,0}));
  end for;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/RadiantSlab/Examples/EmbeddedPipeExample.mos"
        "Simulate and plot"));
end EmbeddedPipeNDiscrExample;

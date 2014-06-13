within IDEAS.Fluid.Sources.Examples;
model Example_Boundary

  replaceable package Air = IDEAS.Media.Air;
  replaceable package Water = Modelica.Media.Water.ConstantPropertyLiquidWater;
  IDEAS.Fluid.Sources.Boundary_pT airAmbExt(
    use_T_in=false,
    redeclare replaceable package Medium = Air,
    nPorts=1)                                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,36})));
  IDEAS.Fluid.Movers.Pump fanSup(
    useInput=true,
    m_flow_nominal=1.225*3200/3600,
    redeclare replaceable package Medium = Air,
    show_T=true)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-4,-4})));
  IDEAS.Fluid.Sources.Boundary_pT airAmb(redeclare replaceable package Medium
      = Air, use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={54,-4})));
  Modelica.Blocks.Sources.RealExpression TAmb(y=270)
    annotation (Placement(transformation(extent={{42,14},{62,34}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
equation
  connect(TAmb.y, airAmb.T_in) annotation (Line(
      points={{63,24},{66,24},{66,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airAmb.ports[1], fanSup.port_a) annotation (Line(
      points={{44,-4},{6,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fanSup.port_b, airAmbExt.ports[1]) annotation (Line(
      points={{-14,-4},{-78,-4},{-78,36},{-70,36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, fanSup.m_flowSet) annotation (Line(
      points={{-7,50},{-4,50},{-4,6.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Example_Boundary;

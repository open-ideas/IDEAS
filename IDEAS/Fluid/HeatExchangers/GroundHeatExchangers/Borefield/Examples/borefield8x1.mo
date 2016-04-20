within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples;
model borefield8x1
  "Model of a borefield in a 8x1 boreholes line configuration and a constant heat injection rate"

  extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature T_start = bfData.gen.T_start;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  replaceable parameter
    Data.BorefieldData.SandStone_Bentonite_c8x1_h110_b5_d3600_T283
    bfData
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Integer lenSim=3600*24*366 "length of the simulation";

  replaceable MultipleBoreHolesUTube borFie(
    lenSim=lenSim,
    redeclare package Medium = Medium,
    bfData=bfData,
    T_start=T_start) "borefield"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Modelica.Blocks.Sources.Step load(height=1, startTime=36000)
    "load for the borefield"
    annotation (Placement(transformation(extent={{26,-18},{40,-4}})));

  IDEAS.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    dp_nominal=10000,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=bfData.m_flow_nominal,
    m_flow(start=bfData.m_flow_nominal),
    Q_flow_nominal=bfData.gen.q_ste*bfData.gen.nbBh*bfData.gen.hBor,
    T_start=T_start,
    p_start=100000)
    annotation (Placement(transformation(extent={{30,22},{10,2}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(          redeclare package
      Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem_out(
    redeclare package Medium = Medium,
    m_flow_nominal=bfData.m_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{38,-50},{58,-30}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pum(
    redeclare package Medium = Medium,
    m_flow_nominal=bfData.m_flow_nominal,
    T_start=T_start,
    addPowerToMedium=false,
    filteredSpeed=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-16,22},{-36,2}})));
  Modelica.Blocks.Sources.Constant mFlo(k=bfData.m_flow_nominal)
    annotation (Placement(transformation(extent={{-60,-18},{-48,-6}})));
  Sensors.TemperatureTwoPort             senTem_in(
    redeclare package Medium = Medium,
    m_flow_nominal=bfData.m_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
equation
  connect(load.y, hea.u) annotation (Line(
      points={{40.7,-11},{52,-11},{52,6},{32,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hea.port_a, senTem_out.port_b) annotation (Line(
      points={{30,12},{70,12},{70,-40},{58,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem_out.port_a, borFie.port_b) annotation (Line(
      points={{38,-40},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mFlo.y, pum.m_flow_in) annotation (Line(
      points={{-47.4,-12},{-25.8,-12},{-25.8,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum.port_a, hea.port_b) annotation (Line(
      points={{-16,12},{10,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], pum.port_b) annotation (Line(
      points={{-40,50},{-36,50},{-36,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pum.port_b, senTem_in.port_a) annotation (Line(
      points={{-36,12},{-78,12},{-78,-40},{-60,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem_in.port_b, borFie.port_a) annotation (Line(
      points={{-40,-40},{-20,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                    graphics),
    experiment(StopTime=1.7e+006, __Dymola_NumberOfIntervals=100),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"));
end borefield8x1;

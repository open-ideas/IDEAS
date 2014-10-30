within IDEAS.Fluid.Production.Examples;
model IdealHeaterChillerLimitedPower
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1;
  IDEAS.Fluid.Production.IdealHeaterChillerLimitedPower
    idealHeaterChillerLimitedPower(redeclare package Medium=Medium,
    m_flow_nominal=m_flow_nominal,
    QHea_nominal=20000,
    QCoo_nominal=20000,
    tauHeatLoss=0.1)
    annotation (Placement(transformation(extent={{-84,-10},{-64,12}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2,
    duration=100,
    offset=-1)
    annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  IDEAS.Fluid.Sources.Boundary_pT
                      bou(          redeclare package Medium = Medium,
    nPorts=2,
    use_T_in=true,
    p=200000)
    annotation (Placement(transformation(extent={{28,-10},{8,-30}})));
  IDEAS.Fluid.Movers.Pump
                    pump(
    redeclare package Medium = Medium,
    useInput=true,
    m_flow_nominal=m_flow_nominal,
    m=0.001)
    annotation (Placement(transformation(extent={{-8,-12},{-28,-32}})));
  Modelica.Blocks.Sources.Constant
                               const(k=293.15)
    annotation (Placement(transformation(extent={{64,-34},{44,-14}})));
  Sensors.TemperatureTwoPort             senTemBoiler_out(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-44,-4},{-28,12}})));
  Sensors.TemperatureTwoPort senTemBoiler_in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-38,-30},{-54,-14}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=100,
    height=20,
    offset=283.15,
    startTime=100)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
equation
  connect(const.y, bou.T_in) annotation (Line(
      points={{43,-24},{30,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[1], pump.port_a) annotation (Line(
      points={{8,-22},{-8,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp.y, pump.m_flowSet) annotation (Line(
      points={{-1,-50},{-18,-50},{-18,-32.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(idealHeaterChillerLimitedPower.port_b, senTemBoiler_out.port_a)
    annotation (Line(
      points={{-64,4},{-44,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b, bou.ports[2]) annotation (Line(
      points={{-28,4},{0,4},{0,-18},{8,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{-28,-22},{-38,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_in.port_b, idealHeaterChillerLimitedPower.port_a)
    annotation (Line(
      points={{-54,-22},{-64,-22},{-64,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp1.y, idealHeaterChillerLimitedPower.TSet) annotation (Line(
      points={{-79,30},{-75,30},{-75,12}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
                    graphics),
    experiment(StopTime=200),
    __Dymola_experimentSetupOutput);
end IdealHeaterChillerLimitedPower;

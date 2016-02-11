within IDEAS.Fluid.Production.Examples;
model NewHeatPump_AirWater
  "General example and tester for a modulating air-to-water heat pump"
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  Fluid.Movers.Pump pump(
    m=1,
    useInput=false,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{28,-30},{8,-10}})));
  IDEAS.Fluid.FixedResistances.Pipe_HeatPort pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K") = 313.15)
    annotation (Placement(transformation(extent={{62,-10},{42,-30}})));
  NewHeatPumpAirWater hp(
    tauHeatLoss=3600,
    cDry=10000,
    mWater=4,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    QNom=20000,
    heatSource(useTinPrimary=true))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  //  Real PElLossesInt( start = 0, fixed = true);
  //  Real PElNoLossesInt( start = 0, fixed = true);
  //  Real QUsefulLossesInt( start = 0, fixed = true);
  //  Real QUsefulNoLossesInt( start = 0, fixed = true);
  //  Real SPFLosses( start = 0);
  //  Real SPFNoLosses( start = 0);
  //
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 20)
    annotation (Placement(transformation(extent={{-42,-80},{-22,-60}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  constant SI.MassFlowRate m_flow_nominal=0.2 "Nominal mass flow rate";
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  Modelica.Blocks.Sources.BooleanConstant HP_on(k=true)
    annotation (Placement(transformation(extent={{-96,18},{-76,38}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 40)
    annotation (Placement(transformation(extent={{-72,24},{-52,44}})));
  Sensors.TemperatureTwoPort senTemHp_out(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Sensors.TemperatureTwoPort senTemHp_in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-4,-30},{-24,-10}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;
  connect(hp.heatPort, fixedTemperature.port) annotation (Line(
      points={{-20,30},{-18,30},{-18,30},{0,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TReturn.port, pipe.heatPort) annotation (Line(
      points={{20,-70},{52,-70},{52,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-21,-70},{-2,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, pump.port_a) annotation (Line(
      points={{42,-20},{28,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(HP_on.y, hp.on) annotation (Line(
      points={{-75,28},{-40.8,28}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realExpression.y, hp.u) annotation (Line(
      points={{-51,34},{-40.6,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hp.port_b, senTemHp_out.port_a) annotation (Line(
      points={{-30,40},{-30,60},{20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemHp_out.port_b, pipe.port_a) annotation (Line(
      points={{40,60},{80,60},{80,-20},{62,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemHp_in.port_a) annotation (Line(
      points={{8,-20},{-4,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemHp_in.port_b, hp.port_a) annotation (Line(
      points={{-24,-20},{-30,-20},{-30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], hp.port_a) annotation (Line(
      points={{-48,0},{-30,0},{-30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(StopTime=15000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Commands(file=
          "Resources/Scripts/Dymola/Fluid/Production/Examples/HeatPump_AirWater.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example shows the modulation behaviour of an inverter controlled air-to-water heat pump when the inlet water temperature is changed. </p>
<p>The modulation level can be seen from heater.heatSource.modulation.</p>
</html>", revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end NewHeatPump_AirWater;

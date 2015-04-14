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
    annotation (Placement(transformation(extent={{-14,-24},{-34,-4}})));
  IDEAS.Fluid.FixedResistances.Pipe_HeatPort pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K") = 313.15)
    annotation (Placement(transformation(extent={{32,-4},{12,-24}})));
  NewHeatPumpAirWater hp(
    tauHeatLoss=3600,
    cDry=10000,
    mWater=4,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    QNom=20000) annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=90,
        origin={-65,24})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-28,18},{-42,32}})));
  //  Real PElLossesInt( start = 0, fixed = true);
  //  Real PElNoLossesInt( start = 0, fixed = true);
  //  Real QUsefulLossesInt( start = 0, fixed = true);
  //  Real QUsefulNoLossesInt( start = 0, fixed = true);
  //  Real SPFLosses( start = 0);
  //  Real SPFNoLosses( start = 0);
  //
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{-40,-62},{-20,-42}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 20)
    annotation (Placement(transformation(extent={{-82,-62},{-62,-42}})));
  Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium,
    p=200000)
    annotation (Placement(transformation(extent={{-26,-2},{-40,10}})));
  constant SI.MassFlowRate m_flow_nominal=0.2 "Nominal mass flow rate";
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  Modelica.Blocks.Sources.BooleanConstant HP_on(k=true)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 40)
    annotation (Placement(transformation(extent={{-100,32},{-80,52}})));
  Sensors.TemperatureTwoPort senTemHp_out(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-16,36},{4,56}})));
  Sensors.TemperatureTwoPort senTemHp_in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-42,-24},{-62,-4}})));
equation
  //   der(PElLossesInt) = HP.PEl;
  //   der(PElNoLossesInt) = HP_NoLosses.PEl;
  //   der(QUsefulLossesInt) =thermalConductor.port_b.Q_flow;
  //   der(QUsefulNoLossesInt) = thermalConductor1.port_b.Q_flow;
  //   SPFLosses = if noEvent(PElLossesInt > 0) then QUsefulLossesInt/PElLossesInt else 0;
  //   SPFNoLosses = if noEvent(PElNoLossesInt > 0) then QUsefulNoLossesInt/PElNoLossesInt else 0;
  connect(hp.heatPort, fixedTemperature.port) annotation (Line(
      points={{-55,21.3},{-48,21.3},{-48,25},{-42,25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TReturn.port, pipe.heatPort) annotation (Line(
      points={{-20,-52},{22,-52},{22,-24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-61,-52},{-42,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, pump.port_a) annotation (Line(
      points={{12,-14},{-14,-14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(bou.ports[1], hp.port_a) annotation (Line(
      points={{-40,4},{-56,4},{-56,15},{-65,15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_on.y, hp.on) annotation (Line(
      points={{-79,0},{-75.8,0},{-75.8,22.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realExpression.y, hp.u) annotation (Line(
      points={{-79,42},{-78,42},{-78,27.6},{-76,27.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hp.port_b, senTemHp_out.port_a) annotation (Line(
      points={{-65,33},{-65,46},{-16,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemHp_out.port_b, pipe.port_a) annotation (Line(
      points={{4,46},{50,46},{50,-14},{32,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemHp_in.port_a) annotation (Line(
      points={{-34,-14},{-42,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemHp_in.port_b, hp.port_a) annotation (Line(
      points={{-62,-14},{-65,-14},{-65,15}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics),
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

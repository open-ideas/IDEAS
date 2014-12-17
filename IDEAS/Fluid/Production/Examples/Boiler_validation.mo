within IDEAS.Fluid.Production.Examples;
model Boiler_validation "Validation model for the boiler"
  import IDEAS;

  extends Modelica.Icons.Example;

  package Medium = IDEAS.Media.Water.Simple
    annotation (__Dymola_choicesAllMatching=true);

  Fluid.Movers.Pump pump(
    m=1,
    m_flow_nominal=1300/3600,
    useInput=true,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{8,-56},{-12,-36}})));
  IDEAS.Fluid.FixedResistances.Pipe_HeatPort pipe(
    m=5,
    redeclare package Medium = Medium,
    m_flow_nominal=1300/3600,
    T_start=313.15)
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  IDEAS.Fluid.Production.Boiler                    heater(
    tauHeatLoss=3600,
    mWater=10,
    cDry=10000,
    redeclare package Medium = Medium,
    m_flow_nominal=1300/3600,
    QNom=20000,
    redeclare
      IDEAS.Fluid.Production.BaseClasses.HeatSources.PerformanceMap3DHeatSource
      heatSource(redeclare IDEAS.Fluid.Production.Data.PerformanceMaps.Boiler3D
        data))
    annotation (Placement(transformation(extent={{-70,4},{-50,-16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-94,4},{-80,18}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
  Modelica.Blocks.Sources.TimeTable pulse(offset=0, table=[0, 0; 5000, 100;
        10000, 400; 15000, 700; 20000, 1000; 25000, 1300; 50000, 1300])
    annotation (Placement(transformation(extent={{-50,72},{-30,92}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{-34,24},{-14,44}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=30,
    freqHz=1/5000,
    offset=273.15 + 50,
    startTime=20000)
    annotation (Placement(transformation(extent={{-76,24},{-56,44}})));
  Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = Medium,
    p=200000)
    annotation (Placement(transformation(extent={{-12,-32},{-32,-12}})));

  Modelica.Blocks.Math.Gain gain(k=1/1300)
    annotation (Placement(transformation(extent={{-14,72},{6,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 60)
    annotation (Placement(transformation(extent={{-96,-34},{-76,-14}})));
  Sensors.TemperatureTwoPort senTemBoiler_out(redeclare package Medium = Medium,
      m_flow_nominal=1300/3600)
    annotation (Placement(transformation(extent={{-44,-2},{-24,18}})));
  Sensors.TemperatureTwoPort senTemBoiler_in(redeclare package Medium = Medium,
      m_flow_nominal=1300/3600)
    annotation (Placement(transformation(extent={{-24,-56},{-44,-36}})));
equation

  connect(heater.heatPort, fixedTemperature.port) annotation (Line(
      points={{-64,4},{-64,11},{-80,11}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TReturn.port, pipe.heatPort) annotation (Line(
      points={{-14,34},{0,34},{0,18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-55,34},{-36,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, pump.port_a) annotation (Line(
      points={{10,8},{48,8},{48,-46},{8,-46}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(bou.ports[1], heater.port_a) annotation (Line(
      points={{-32,-22},{-42,-22},{-42,-10},{-49.8,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pulse.y, gain.u) annotation (Line(
      points={{-29,82},{-16,82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, pump.m_flowSet) annotation (Line(
      points={{7,82},{18,82},{18,-35.6},{-2,-35.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, heater.TSet) annotation (Line(
      points={{-75,-24},{-56,-24},{-56,-16.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heater.port_b, senTemBoiler_out.port_a) annotation (Line(
      points={{-49.8,-2},{-49.8,8},{-44,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_out.port_b, pipe.port_a) annotation (Line(
      points={{-24,8},{-10,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senTemBoiler_in.port_a) annotation (Line(
      points={{-12,-46},{-24,-46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemBoiler_in.port_b, heater.port_a) annotation (Line(
      points={{-44,-46},{-49.8,-46},{-49.8,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics),
    experiment(StopTime=40000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Commands(file="Scripts/Tester_Boiler.mos" "TestModel"),
    Documentation(info="<html>
<p>Model used to validate the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">IDEAS.Thermal.Components.Production.Boiler</a>. With a fixed set point, the boiler receives different mass flow rates. </p>
</html>", revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end Boiler_validation;

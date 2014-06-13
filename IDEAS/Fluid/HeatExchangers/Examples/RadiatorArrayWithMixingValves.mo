within IDEAS.Fluid.HeatExchangers.Examples;
model RadiatorArrayWithMixingValves "Array of radiators with a simplified boiler and thermal mixing valve"
  extends Modelica.Icons.Example;
  Fluid.Movers.Pump volumeFlow1(
    m=4,
    T_start=313.15,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{76,-86},{56,-66}})));
  IDEAS.Fluid.FixedResistances.Pipe_HeatPort boiler(
    m=5,
    T_start=333.15,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,4},{-6,-16}})));
  Fluid.HeatExchangers.Radiators.Radiator[2] radiator(
    QNom={5000,10000},
    redeclare each package Medium = Medium,
    each T_start=293.15,
    dp_nominal=1e4) "Hydraulic radiator model"
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{30,52},{50,72}})));
  Modelica.Blocks.Sources.Step step(
    offset=291,
    height=5,
    startTime=2000)
    annotation (Placement(transformation(extent={{-8,52},{12,72}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedHeatFlow(T=333.15)
    annotation (Placement(transformation(extent={{-50,-52},{-30,-32}})));
  Fluid.Valves.Thermostatic3WayValve thermostaticValve(mFlowMin=0.01,
      redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,-16},{30,4}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 45)
    annotation (Placement(transformation(extent={{-2,6},{10,18}})));
  Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={46,-34})));
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;
  parameter SI.MassFlowRate m_flow_nominal=0.07 "Nominal mass flow rate";
  inner SimInfoManager sim annotation (Placement(transformation(extent={{-94,78},{-74,98}})));
equation
  connect(step.y, prescribedTemperature.T) annotation (Line(
      points={{13,62},{28,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, radiator[1].heatPortRad) annotation (Line(
      points={{50,62},{71,62},{71,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, radiator[2].heatPortRad) annotation (Line(
      points={{50,62},{71,62},{71,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, boiler.heatPort) annotation (Line(
      points={{-30,-42},{-16,-42},{-16,-16}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prescribedTemperature.port, radiator[1].heatPortCon) annotation (Line(
      points={{50,62},{64,62},{64,10},{67,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, radiator[2].heatPortCon) annotation (Line(
      points={{50,62},{64,62},{64,10},{67,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const.y, thermostaticValve.TMixedSet) annotation (Line(
      points={{10.6,12},{20,12},{20,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermostaticValve.port_b, radiator[1].port_a) annotation (Line(
      points={{30,-6},{42,-6},{42,0},{52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermostaticValve.port_b, radiator[2].port_a) annotation (Line(
      points={{30,-6},{42,-6},{42,0},{52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volumeFlow1.port_a, radiator[1].port_b) annotation (Line(
      points={{76,-76},{82,-76},{82,0},{72,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volumeFlow1.port_a, radiator[2].port_b) annotation (Line(
      points={{76,-76},{82,-76},{82,0},{72,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volumeFlow1.port_b, thermostaticValve.port_a2) annotation (Line(
      points={{56,-76},{20,-76},{20,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_a, thermostaticValve.port_a2) annotation (Line(
      points={{-26,-6},{-74,-6},{-74,-76},{20,-76},{20,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_b, thermostaticValve.port_a1) annotation (Line(
      points={{-6,-6},{10,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], radiator[1].port_a) annotation (Line(
      points={{46,-30},{46,0},{52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>In this example, two radiators are connected to a prescribed temperature (acting as room). The boiler is represented by a pipe_HeatPort component connected to a fixed temperature of 60&deg;C. Therefore, the heat flux will be a free variable and it will depend on the flowrate and temperature of the water entering the boiler. </p>
<p>The thermostatic valve controls the inlet temperature of the radiators to 45&deg;C. </p>
<p><br>Note: As the radiators are connected in parallel, it is necessary to specify their nominal pressure drop.  Otherwise, a singular model is obtained if only a single pump for both radiators is used: the mass flow rates in each radiator can take any value as long as their sum equals the pump mass flow rate.  </p>
<p><br><b>Note</b>: make sure that when using a radiator, both the radiative and convective heatPort are connected, otherwise the model will not run under all operating conditions. </p>
</html>", revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end RadiatorArrayWithMixingValves;

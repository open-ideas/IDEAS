within IDEAS.Utilities.IO.Examples;
model heatPortIO

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=10)
    annotation (Placement(transformation(extent={{-38,60},{-18,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1)
    annotation (Placement(transformation(extent={{-62,50},{-42,70}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C=10)
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(R=1)
    annotation (Placement(transformation(extent={{-14,50},{6,70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2(R=1)
    annotation (Placement(transformation(extent={{42,50},{62,70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature prescribedTemperature(
      T=293.15) annotation (Placement(transformation(extent={{92,50},{72,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-88,50},{-68,70}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=0.1)
    annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(C=10)
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor3(R=1)
    annotation (Placement(transformation(extent={{-62,-60},{-42,-40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor3(C=10)
    annotation (Placement(transformation(extent={{22,-50},{42,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor4(R=1)
    annotation (Placement(transformation(extent={{-12,-60},{8,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor5(R=1)
    annotation (Placement(transformation(extent={{42,-60},{62,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature prescribedTemperature1(
     T=293.15)
    annotation (Placement(transformation(extent={{92,-60},{72,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-88,-60},{-68,-40}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=2, freqHz=0.1)
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  heatPortPrescribedTemperature heatPortPrescribedTemperature1
    annotation (Placement(transformation(extent={{12,-20},{-8,0}})));
  heatPortPrescribedHeatFlow heatPortPrescribedHeatFlow1
    annotation (Placement(transformation(extent={{24,0},{44,-20}})));
  Modelica.Blocks.Math.Add error(k2=-1)
    annotation (Placement(transformation(extent={{76,20},{96,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{40,34},{52,46}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{40,18},{52,30}})));
equation
  connect(thermalResistor.port_b, heatCapacitor.port) annotation (Line(
      points={{-42,60},{-28,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor1.port_b, heatCapacitor1.port) annotation (Line(
      points={{6,60},{20,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatCapacitor.port, thermalResistor1.port_a) annotation (Line(
      points={{-28,60},{-14,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor2.port_a, heatCapacitor1.port) annotation (Line(
      points={{42,60},{20,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, thermalResistor2.port_b) annotation (Line(
      points={{72,60},{62,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, thermalResistor.port_a) annotation (Line(
      points={{-68,60},{-62,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-81,30},{-94,30},{-94,60},{-88,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermalResistor3.port_b, heatCapacitor2.port) annotation (Line(
      points={{-42,-50},{-28,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor5.port_a, heatCapacitor3.port) annotation (Line(
      points={{42,-50},{32,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature1.port, thermalResistor5.port_b) annotation (
      Line(
      points={{72,-50},{62,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.port, thermalResistor3.port_a) annotation (Line(
      points={{-68,-50},{-62,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine1.y, prescribedHeatFlow1.Q_flow) annotation (Line(
      points={{-81,-80},{-94,-80},{-94,-50},{-88,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPortPrescribedTemperature1.Q_flow, heatPortPrescribedHeatFlow1.Q_flow)
    annotation (Line(
      points={{13.2,-17},{23.2,-17}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPortPrescribedHeatFlow1.port1, heatCapacitor3.port) annotation (
      Line(
      points={{44,-10},{44,-26},{20,-26},{20,-50},{32,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor.port, heatCapacitor1.port) annotation (Line(
      points={{40,40},{20,40},{20,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor.T, error.u1) annotation (Line(
      points={{52,40},{64,40},{64,36},{74,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor1.T, error.u2) annotation (Line(
      points={{52,24},{74,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPortPrescribedHeatFlow1.T, heatPortPrescribedTemperature1.T)
    annotation (Line(
      points={{22.8,-3},{12.8,-3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermalResistor4.port_a, heatCapacitor2.port) annotation (Line(
      points={{-12,-50},{-28,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor4.port_b, heatPortPrescribedTemperature1.port1)
    annotation (Line(
      points={{8,-50},{16,-50},{16,-26},{-8,-26},{-8,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor1.port, heatPortPrescribedHeatFlow1.port1)
    annotation (Line(
      points={{40,24},{20,24},{20,10},{44,10},{44,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end heatPortIO;

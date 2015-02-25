within IDEAS.Controls.Discrete.Examples;
model HysteresisRelease_Heating_NoInputs
  "Example model for hysteresis with fixed uLow and uHigh"
  import IDEAS;
  extends Modelica.Icons.Example;
  IDEAS.Controls.Discrete.HysteresisRelease con(revert=true,
    use_input=false,
    uLow_val=308,
    uHigh_val=312)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1000000, T(start=
         313.15, fixed=true))
    annotation (Placement(transformation(extent={{38,30},{58,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TBC
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=20)
    annotation (Placement(transformation(extent={{38,60},{58,80}})));
  Modelica.Blocks.Math.Gain gain(k=2000)
    annotation (Placement(transformation(extent={{-12,20},{8,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Q_flow
    annotation (Placement(transformation(extent={{16,20},{36,40}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/86400,
    offset=273.15,
    amplitude=20,
    phase=-1.5707963267949,
    y(unit="K"))
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(TBC.port, theCon.port_a) annotation (Line(
      points={{20,70},{38,70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(theCon.port_b, cap.port) annotation (Line(
      points={{58,70},{66,70},{66,30},{48,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(con.y, gain.u) annotation (Line(
      points={{-19,30},{-14,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cap.port, temSen.port) annotation (Line(
      points={{48,30},{70,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gain.y, Q_flow.Q_flow) annotation (Line(
      points={{9,30},{16,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Q_flow.port, cap.port) annotation (Line(
      points={{36,30},{48,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TBC.T) annotation (Line(
      points={{-59,70},{-2,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temSen.T, con.u) annotation (Line(
      points={{90,30},{90,-4},{-48,-4},{-48,30},{-42,30}},
      color={0,0,127},
      smooth=Smooth.None));
 annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
             extent={{-100,-100},{100,100}}), graphics),
                      __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Controls/Discrete/Examples/HysteresisRelease_Heating_NoInputs.mos"
        "Simulate and plot"),
    experiment(StopTime=86400),
    Documentation(info="<html>
<p>Example that demonstrates the use of the hysteresis with release and fix uLow and uHigh for a typical HEATING control. The control objective is to keep the temperature of the capacity between uLow and uHigh. This example can be simulated with the &QUOT;simulate and plot&QUOT; command in the Commands menu. </p>
</html>", revisions="<html>
<ul>
<li>November 2014, Roel De Coninck and Damien Picard</li>
</ul>
</html>"));
end HysteresisRelease_Heating_NoInputs;

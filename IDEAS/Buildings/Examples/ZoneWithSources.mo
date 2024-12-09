within IDEAS.Buildings.Examples;
model ZoneWithSources "Zone with CO2 concentration model"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Air(extraPropertiesNames={"test", "CO2"});
  inner BoundaryConditions.SimInfoManager sim "Simulation information manager for climate data" annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zone(
    redeclare package Medium = Medium, 
    useCFlowInput = true, 
    useWatFlowInput = true,
    n50=40)
    "Zone with latent heat"
    annotation (Placement(visible = true, transformation(origin = {0, 0}, extent = {{-40, 0}, {-20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude = 0.0005, 
    period = 3600)  
    "Pulse for both mWat and C_flow" 
    annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(pulse.y, zone.mWat_flow) annotation(
    Line(points = {{20, 10}, {0, 10}, {0, 18}, {-18, 18}}, color = {0, 0, 127}));
  connect(pulse.y, zone.C_flow) annotation(
    Line(points = {{20, 10}, {0, 10}, {0, 22}, {-18, 22}}, color = {0, 0, 127}));
  annotation (experiment(
      StopTime=100000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"), Documentation(info="<html>
<p>
This model demonstrates how to use the zone model for
simulating the CO2 generation caused by occupants.
</p>
</html>", revisions="<html>
<ul>
<li>
July 25, 2023 by Filip Jorissen:<br/>
First implemmentation
</ul>
</html>"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Examples/ZoneWithSources.mos"
        "Simulate and plot"));
end ZoneWithSources;
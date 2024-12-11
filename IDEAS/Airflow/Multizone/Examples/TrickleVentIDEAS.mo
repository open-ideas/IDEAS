within IDEAS.Airflow.Multizone.Examples;
model TrickleVentIDEAS
  "Model with a trickle vent modelled using the models with flow based on tabulated data"
  extends IDEAS.Airflow.Multizone.Examples.TrickleVent(west(nPorts=2), east(nPorts=2));

  IDEAS.Airflow.Multizone.TrickleVent vent(
    redeclare package Medium = Medium,
    dp_nominal = 10,
    m_flow_nominal = 0.02614,
    use_y = true)
    "Analytic trickle vent implementation"  annotation (
    Placement(visible = true, transformation(origin = {20, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(
    duration = 1e6,
    height = -1,
    offset = 1,
    startTime = 1592000)
    "Step control signal" annotation (
    Placement(visible = true, transformation(origin = {-90, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
   connect(vent.port_a, east.ports[2]) annotation (
    Line(points = {{10, -70}, {-25, -70}, {-25, -30}, {-30, -30}}, color = {0, 127, 255}));
  connect(vent.port_b, west.ports[2]) annotation (
    Line(points = {{30, -70}, {65, -70}, {65, -30}, {70, -30}}, color = {0, 127, 255}));
  connect(ramp.y, vent.y) annotation (
    Line(points = {{-79, -88}, {20.5, -88}, {20.5, -82}, {20, -82}}, color = {0, 0, 127}));
  annotation (__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Airflow/Multizone/Examples/TrickleVentIDEAS.mos"
        "Simulate and plot"),
        experiment(
      StopTime=2592000,
      Interval=600,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This model illustrates the use of the models
<a href=\"modelica://IDEAS.Airflow.Multizone.TrickleVent\">
IDEAS.Airflow.Multizone.Table_V_flow</a>, 
which is an analytic alternative to the table implementation of
<a href=\"modelica://IDEAS.Airflow.Multizone.Table_m_flow\">
IDEAS.Airflow.Multizone.Table_m_flow</a> for modelling self regulating inlet vents.
</p>
</html>", revisions="<html>
<ul>
<li>
July 9, 2023 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
 Diagram);
end TrickleVentIDEAS;

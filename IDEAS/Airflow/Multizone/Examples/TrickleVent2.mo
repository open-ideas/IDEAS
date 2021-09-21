within IDEAS.Airflow.Multizone.Examples;
model TrickleVent2 "Model with a trickle vent"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air;
  IDEAS.Airflow.Multizone.TrickleVent
                                  res(redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dp_nominal=2)
             "Orifice"
             annotation (Placement(transformation(extent={{0,18},{20,38}})));
  IDEAS.Fluid.Sources.Boundary_pT roo1(
    redeclare package Medium = Medium,
    use_p_in=true,
    T=278.15,
    nPorts=1) "Pressure boundary condition"
              annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  IDEAS.Fluid.Sources.Boundary_pT roo2(
    redeclare package Medium = Medium,
    use_p_in=true,
    T=293.15,
    nPorts=1) "Pressure boundary condition"
              annotation (Placement(transformation(
        origin={70,30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Ramp ram(
    duration=0.5,
    height=20,
    offset=-10,
    startTime=0.25) "Ramp signal for pressure boundary condition"
    annotation (Placement(transformation(extent={{0,-48},{20,-28}})));
  Modelica.Blocks.Sources.Constant preBou(k=100000)
    "Constant pressure boundary condition"
    annotation (Placement(transformation(extent={{-92,-20},{-72,0}})));
  Modelica.Blocks.Math.Add add "Adder for pressure boundary condition"
    annotation (Placement(transformation(extent={{44,-30},{64,-10}})));
equation
  connect(preBou.y, add.u1) annotation (Line(points={{-71,-10},{-42,-10},{-42,
          -14},{42,-14}}, color={0,0,255}));
  connect(ram.y, add.u2) annotation (Line(points={{21,-38},{26,-38},{26,-26},{
          42,-26}}, color={0,0,255}));
  connect(preBou.y, roo1.p_in) annotation (Line(points={{-71,-10},{-68,-10},{
          -68,38},{-62,38}}, color={0,0,127}));
  connect(add.y, roo2.p_in) annotation (Line(points={{65,-20},{90,-20},{90,22},
          {82,22}}, color={0,0,127}));
  connect(roo1.ports[1], res.port_a) annotation (Line(points={{-40,30},{-20,30},
          {-20,28},{0,28}}, color={0,127,255}));
  connect(res.port_b, roo2.ports[1]) annotation (Line(points={{20,28},{42,28},{
          42,30},{60,30}}, color={0,127,255}));
  annotation (
experiment(Tolerance=1e-06, StopTime=1),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Airflow/Multizone/Examples/TrickleVent2.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of the trickle vent model.
</p>
</html>", revisions="<html>
<ul>
<li>
September 21, 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end TrickleVent2;

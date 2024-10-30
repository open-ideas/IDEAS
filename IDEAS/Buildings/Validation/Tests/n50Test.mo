within IDEAS.Buildings.Validation.Tests;
model n50Test "n50 consistency check for OnePort"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air(dStp=1.2041)
    "Air medium"
    annotation (choicesAllMatching=true);
  inner BoundaryConditions.SimInfoManager sim(HPres=simpleZone.hZone/2, Va=0,
    interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Real ach = abs(bou.ports[1].m_flow)/rho_default/simpleZone.V*3600 "Effective air change rate";

  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone simpleZone(
    redeclare package Medium = Medium,
    n50=3,
    energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    hasWinA=true,
    l=5,
    w=5,
    h=5)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));

  IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus1
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=1,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{60,-40},
            {40,-20}})));
protected
  final parameter Medium.ThermodynamicState state_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  final parameter Modelica.Units.SI.Density rho_default=Medium.density(state=state_default) "Medium default density";

initial equation
  simpleZone.port_b.Xi_outflow = {0.00590700766936828};

equation
  assert(abs(ach-simpleZone.n50) < 1e-3 or time < 2, "n50 computation consistency check failed");
  //The relatively high margin of error of 1e-3 is nececearry as the air density used during the simulation are calculated based on the medium state. Whearas for the calculation of ach, the medium default density is assumed.
  connect(sim.weaDatBus, weaDatBus1) annotation (Line(
      points={{-80.1,90},{-30,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add.y, bou.p_in)
    annotation (Line(points={{0,39},{0,22},{8,22},{8,12}}, color={0,0,127}));
  connect(ramp.y, add.u1)
    annotation (Line(points={{39,90},{6,90},{6,62}}, color={0,0,127}));
  connect(add.u2, weaDatBus1.pAtm) annotation (Line(points={{-6,62},{-6,90},{-30,
          90}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(prescribedTemperature.T, weaDatBus1.TDryBul) annotation (Line(points={{62,-30},
          {70,-30},{70,106},{-30,106},{-30,90}},                                                                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(prescribedTemperature.port, simpleZone.gainCon) annotation (Line(
        points={{40,-30},{16,-30},{16,-53},{10,-53}}, color={191,0,0}));
  connect(simpleZone.ports[1], bou.ports[1])
    annotation (Line(points={{0,-40},{-1.77636e-15,-40},{-1.77636e-15,-10}},
                                                         color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3, Tolerance=1e-06),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Jelger Jansen:<br/>
Use initial equation to use the same air humidity in the zones compared to the outdoor environment.
This is for issue <a href=\"https://github.com/open-ideas/IDEAS/issues/1244\">#1244</a>.
</li>
<li>
October 29, 2024, by Klaas De Jonge:<br/>
rho_default coupled to medium and new initial zone moisture content,outside pressure reference height at zone reference height.
This is for issue <a href=\"https://github.com/open-ideas/IDEAS/issues/1244\">#1244</a>.
</li>
<li>
June 3, 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model verifies the n50 recomputation implementation that is used for the interzonal airflow implementation.</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/n50Test.mos"
        "Simulate and plot"));
end n50Test;

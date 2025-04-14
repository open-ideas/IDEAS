within IDEAS.Buildings.Validation.Tests;
model n50Test2 "n50 consistency check for interzonalAirFlowType=OnePort"
  extends IDEAS.Buildings.Examples.ZoneExample(
    redeclare package Medium = IDEAS.Media.Air (dStp=1.2041),
    zone1(use_custom_n50=true, n50=2,
      energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    zone(use_custom_n50=true, n50=3,
      energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    sim(HPres=zone.hZone/2, Va=0,
      interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort),
    window(A=2, nWin=2));

  parameter Boolean disableAssert = false;

protected
  final parameter Medium.ThermodynamicState state_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  final parameter Modelica.Units.SI.Density rho_default=Medium.density(state=state_default) "Medium default density";

public
  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=1,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,50})));
  IDEAS.BoundaryConditions.WeatherData.Bus       weaDatBus1
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Real ach = abs(bou.ports[1].m_flow)/rho_default/zone.V*3600;
  Real ach1 = abs(bou.ports[2].m_flow)/rho_default/zone1.V*3600;


  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{90,-10},
            {70,10}})));
initial equation
  zone.port_b.Xi_outflow = {0.00590700766936828};
  zone1.port_b.Xi_outflow = {0.00590700766936828};

equation
  if not disableAssert then
    assert(abs(ach-zone.n50) < 1e-3 or time < 2, "n50 computation consistency check failed");
    assert(abs(ach1-zone1.n50) < 1e-3 or time < 2, "n50 computation consistency check failed");
  end if;

  connect(sim.weaDatBus,weaDatBus1)  annotation (Line(
      points={{-76.1,86},{-14,86},{-14,90},{10,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add.y,bou. p_in)
    annotation (Line(points={{40,39},{40,22},{48,22},{48,12}},
                                                           color={0,0,127}));
  connect(ramp.y,add. u1)
    annotation (Line(points={{79,90},{46,90},{46,62}},
                                                     color={0,0,127}));
  connect(add.u2,weaDatBus1. pAtm) annotation (Line(points={{34,62},{34,90},{10,
          90}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bou.ports[1], zone.ports[1]) annotation (Line(points={{39,-10},{28,-10},
          {28,-20},{10,-20}}, color={0,127,255}));
  connect(bou.ports[2], zone1.ports[1]) annotation (Line(points={{41,-10},{24,-10},
          {24,40},{10,40}}, color={0,127,255}));
  connect(prescribedTemperature.T, weaDatBus1.TDryBul) annotation (Line(points={{92,0},{
          104,0},{104,104},{10,104},{10,90}},                                                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(prescribedTemperature.port, zone1.gainCon) annotation (Line(points={{
          70,0},{56,0},{56,20},{26,20},{26,27},{20,27}}, color={191,0,0}));
  connect(prescribedTemperature.port, zone.gainCon) annotation (Line(points={{
          70,0},{56,0},{56,-33},{20,-33}}, color={191,0,0}));
  annotation (experiment(StopTime=3, Tolerance=1e-06),
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
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/n50Test2.mos"
        "Simulate and plot"));
end n50Test2;

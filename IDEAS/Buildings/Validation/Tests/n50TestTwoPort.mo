within IDEAS.Buildings.Validation.Tests;
model n50TestTwoPort
  extends n50Test(
    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts),
    simpleZone(energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{50,-60},{30,-40}})));

equation
  connect(simpleZone.gainCon, prescribedTemperature.port) annotation (Line(points={{10,-53},{10,-54},{20,-54},{20,-50},{30,-50}}, color={191,0,0}));
  connect(prescribedTemperature.T, weaDatBus1.TDryBul) annotation (Line(points={{52,-50},{60,-50},{60,-20},{-30,-20},{-30,90}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Documentation(revisions="<html>
<ul>
<li>
October 11, 2024, by Jelger Jansen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model verifies the n50 recomputation implementation that is used for the interzonal airflow two-port implementation.</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/n50TestTwoPort.mos"
        "Simulate and plot"));
end n50TestTwoPort;

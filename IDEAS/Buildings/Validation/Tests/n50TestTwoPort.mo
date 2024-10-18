within IDEAS.Buildings.Validation.Tests;
model n50TestTwoPort
  extends n50Test(
    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));

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
        "Simulate and plot"),
    experiment(
      StopTime=3,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end n50TestTwoPort;

within IDEAS.Buildings.Validation.Tests;
model n50Test3TwoPort
  extends n50Test3(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
  annotation (experiment(
      StopTime=3,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end n50Test3TwoPort;

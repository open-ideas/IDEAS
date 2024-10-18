within IDEAS.Buildings.Validation.Tests;
model n50Test2TwoPort
  extends n50Test2(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
  annotation (experiment(
      StopTime=3,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end n50Test2TwoPort;

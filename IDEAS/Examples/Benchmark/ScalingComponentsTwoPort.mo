within IDEAS.Examples.Benchmark;
model ScalingComponentsTwoPort
  extends ScalingComponents(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=1.6));
end ScalingComponentsTwoPort;

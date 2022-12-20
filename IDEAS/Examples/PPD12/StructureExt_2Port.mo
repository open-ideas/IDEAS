within IDEAS.Examples.PPD12;
model StructureExt_2Port "Extended the structure but with 2-port option ON"
  extends Structure(redeclare package MediumAir =
        IDEAS.Media.Specialized.Air.PerfectGas,
                    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=3));
  annotation (experiment(
      StopTime=432000,
      Interval=900.00288,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"));
end StructureExt_2Port;

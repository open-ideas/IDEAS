within IDEAS.Examples.PPD12;
model StructureExt_2Port "Extended the structure but with 2-port option ON"
  extends Structure(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=3));
end StructureExt_2Port;

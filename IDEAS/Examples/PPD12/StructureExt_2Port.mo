within IDEAS.Examples.PPD12;
model StructureExt_2Port "Extended the structure but with 2-port option ON"
  extends Structure(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 18, 2025, by Klaas De Jonge:<br/>
Use n50 declaration of extended model(<code>n50=1.1</code>) instead of <code>n50=3</code>
</li>
</ul>
</html>"),
experiment(__Dymola_Algorithm="Dassl"));
end StructureExt_2Port;

within IDEAS.Buildings.Data.Constructions.EPC.LabelC;
record OuterWall  "Construction data of OuterWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.EPC.HeavyMasonryForExteriorApplications(d=0.09),
        IDEAS.Buildings.Data.Materials.EPC.LargeCavityHorizontalHeatTransfer(d=0.025),
        IDEAS.Buildings.Data.Insulation.Rockwool(d=0.037261869785843296),
        IDEAS.Buildings.Data.Materials.EPC.HeavyMasonryForInteriorApplications(d=0.14),
        IDEAS.Buildings.Data.Materials.EPC.GypsumPlasterForFinishing(d=0.02)});
        annotation (Documentation(info="<html>
<p>
Construction data of an outer wall in an EPC C building
</p>
</html>",revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end OuterWall;

within IDEAS.Buildings.Data.Constructions.EPC.LabelA;
record CommonWall  "Construction data of CommonWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.EPC.GypsumPlasterForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.EPC.MediumMasonryForInteriorApplications(d=0.14)});
annotation (Documentation(info="<html>
<p>
Construction data of a common wall in an EPC A building
</p>
</html>",revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end CommonWall;

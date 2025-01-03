within IDEAS.Buildings.Data.Constructions.EPB.label_B;
record CommonWall  "Construction data of CommonWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.MediumMasonryForInteriorApplications(d=0.14)});
            annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end CommonWall;

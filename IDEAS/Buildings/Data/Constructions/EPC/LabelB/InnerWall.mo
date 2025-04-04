within IDEAS.Buildings.Data.Constructions.EPC.LabelB;
record InnerWall  "Construction data of InnerWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.EPC.GypsumPlasterForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.EPC.MediumMasonryForInteriorApplications(d=0.1),
        IDEAS.Buildings.Data.Materials.EPC.GypsumPlasterForFinishing(d=0.02)});
  annotation (Documentation(info="<html>
<p>
Construction data of an inner wall in an EPC B building
</p>
</html>",revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end InnerWall;

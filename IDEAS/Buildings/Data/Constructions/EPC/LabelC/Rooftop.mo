within IDEAS.Buildings.Data.Constructions.EPC.LabelC;
record Rooftop  "Construction data of Rooftop"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Insulation.Rockwool415TimberForFinishing35(
        d=0.03872196743554952),
        IDEAS.Buildings.Data.Materials.EPC.TimberForFinishing(d=0.01),
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.025)});
         annotation (Documentation(revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end Rooftop;

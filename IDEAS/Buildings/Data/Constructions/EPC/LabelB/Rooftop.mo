within IDEAS.Buildings.Data.Constructions.EPC.LabelB;
record Rooftop  "Construction data of Rooftop"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Insulation.EPC.Rockwool415TimberForFinishing35(d=0.09096077340569879),
        IDEAS.Buildings.Data.Materials.EPC.TimberForFinishing(d=0.01),
        IDEAS.Buildings.Data.Materials.EPC.GypsumPlasterForFinishing(d=0.025)});
  annotation (Documentation(info="<html>
<p>
Construction data of a rooftop in an EPC B building
</p>
</html>",revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end Rooftop;

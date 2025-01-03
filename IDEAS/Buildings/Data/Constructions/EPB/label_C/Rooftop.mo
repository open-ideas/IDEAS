within IDEAS.Buildings.Data.Constructions.EPB.label_C;
record Rooftop  "Construction data of Rooftop"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={IDEAS.Buildings.Data.Insulation.Rockwool415TimberForFinishing35(d=0.03872196743554952),
     IDEAS.Buildings.Data.Materials.TimberForFinishing(d=0.01),
     IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.025)});
end Rooftop;

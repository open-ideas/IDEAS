within IDEAS.Buildings.Data.Constructions.EPB.label_B;
record CommonWall  "Construction data of CommonWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.MediumMasonryForInteriorApplications(d=0.14)});
end CommonWall;

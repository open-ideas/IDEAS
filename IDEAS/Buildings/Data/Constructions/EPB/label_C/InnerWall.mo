within IDEAS.Buildings.Data.Constructions.EPB.label_C;
record InnerWall  "Construction data of InnerWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02),
        IDEAS.Buildings.Data.Materials.MediumMasonryForInteriorApplications(d=0.1),
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02)});
end InnerWall;

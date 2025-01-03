within IDEAS.Buildings.Data.Constructions.EPB.label_A;
record OuterWall  "Construction data of OuterWall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(final mats={
        IDEAS.Buildings.Data.Materials.HeavyMasonryForExteriorApplications(d=0.09),
        IDEAS.Buildings.Data.Materials.LargeCavityHorizontalHeatTransfer(d=0.025),
        IDEAS.Buildings.Data.Insulation.Rockwool(d=0.12520020438577814),
        IDEAS.Buildings.Data.Materials.HeavyMasonryForInteriorApplications(d=0.14),
        IDEAS.Buildings.Data.Materials.GypsumPlasterForFinishing(d=0.02)});
end OuterWall;

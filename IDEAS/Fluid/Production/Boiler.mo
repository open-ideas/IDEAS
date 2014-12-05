within IDEAS.Fluid.Production;
model Boiler
  extends BaseClasses.PartialBoiler(redeclare
      BaseClasses.HeatSources.PerformanceMap3DHeatSource heatSource, redeclare
      Data.PerformanceMaps.Boiler3D data);
end Boiler;

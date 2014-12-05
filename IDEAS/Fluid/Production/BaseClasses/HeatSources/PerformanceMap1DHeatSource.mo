within IDEAS.Fluid.Production.BaseClasses.HeatSources;
partial model PerformanceMap1DHeatSource
  "A heatsource based on a 1D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource;

  //Parameters
  parameter Real[ :,:] table "Data table for the 1D CombiTalbe";

  //Components
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    table=table,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
end PerformanceMap1DHeatSource;
